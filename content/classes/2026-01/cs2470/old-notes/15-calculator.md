---
title: "Lecture Notes: 15 Calculator"
date: "2025-03-29"
---

# Computer Systems

## First Thing

 - Questions on the Homework?

## Calculator

Geneneral flow:

 - Read a line of text: fgets (*never* "gets")
 - Split the line into tokens.
- Parse the tokens into an abstract syntax tree
 - Evaluate the AST

Draw a diagram on the board, with an example.

### Tokenizer

 - We have a line of text.
 - We need a list of tokens.
 - Work character by character and build up current token.
 - When the current character doesn't match the previous token,
   push the previous token and start a new one.
 - This is a state machine.
 
```C
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "ast.h"
#include "parse.h"
#include "list.h"

char*
read_number(const char* text, int ii)
{
    int nn = 0;
    while (isdigit(text[ii + nn])) {
        ++nn;
    }

    char* num = malloc(nn + 1);
    memcpy(num, text + ii, nn);
    num[nn] = 0;
    return num;
}

list*
tokenize(const char* text)
{
    list* xs = 0;

    int nn = strlen(text);
    int ii = 0;
    while (ii < nn) {
        if (isspace(text[ii])) {
            ++ii;
            continue;
        }

        if (isdigit(text[ii])) {
            char* num = read_number(text, ii);
            xs = cons(num, xs);
            ii += strlen(num);
            free(num);
            continue;
        }

        // Else, operator.
        char op[4] = "x";
        op[0] = text[ii];
        xs = cons(op, xs);
        ++ii;
    }

    return rev_free(xs);
}
```

### Parser and AST

 - An Abstract Syntax tree encodes the expression as it will be evaluated.
 - For an arithemtic expression:
 - Numbers are leaves.
 - Internal nodes are operators.
 - Order of operations is encoded in the structure; the root note is evaluated
   last.
 - In general, this can be done efficiently with a stack.
 - Our code uses a less efficient method: scan the whole input for the root,
   split there, and recurse on the subtrees.


```C
#ifndef CALC_AST_H
#define CALC_AST_H

#include <stdlib.h>

typedef struct calc_ast {
    char op;
    // Op is either:
    //  one of: +, -, *, / for an operation
    //      or: '=' for value
    struct calc_ast* arg0;
    struct calc_ast* arg1;
    int value;
} calc_ast;

calc_ast* make_ast_value(int vv);
calc_ast* make_ast_op(char op, calc_ast* a0, calc_ast* a1);
void free_ast(calc_ast* ast);
int ast_eval(calc_ast* ast);
void print_ast(calc_ast* ast);

#endif
```

```C
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include "ast.h"
#include "parse.h"
#include "list.h"

int
streq(const char* aa, const char* bb)
{
    return strcmp(aa, bb) == 0;
}

int
find_first_index(list* toks, const char* tt)
{
    int ii = 0;
    for (list* it = toks; it; it = it->tail) {
        if (streq(it->head, tt)) {
            return ii;
        }
        ii++;
    }

    return -1;
}

int
contains(list* toks, const char* tt)
{
    return find_first_index(toks, tt) >= 0;
}

list*
slice(list* xs, int i0, int i1)
{
    list* ys = 0;
    list* it = xs;
    for (int ii = 0; ii < i0; ++ii) {
        it = it->tail;
    }
    for (int ii = i0; ii < i1; ++ii) {
        ys = cons(it->head, ys);
        it = it->tail;
    }
    return rev_free(ys);
}

calc_ast*
parse(list* toks)
{
    if (length(toks) == 1) {
        int vv = atoi(toks->head);
        return make_ast_value(vv);
    }

    const char* ops[] = {"+", "-", "*", "/"};

    for (int ii = 0; ii < 4; ++ii) {
        const char* op = ops[ii];

        if (contains(toks, op)) {
            int jj = find_first_index(toks, op);
            list* xs = slice(toks, 0, jj);
            list* ys = slice(toks, jj + 1, length(toks));
            calc_ast* ast = make_ast_op(op[0], parse(xs), parse(ys));
            free_list(xs);
            free_list(ys);
            return ast;
        }
    }

    fprintf(stderr, "Invalid token stream");
    exit(1);
}
```


### Evaluating an AST

 - AST can be evaluated.
 - This is a simple recursive function.


```C
#include <stdio.h>
#include <stdlib.h>

#include "ast.h"

calc_ast*
make_ast_value(int vv)
{
    calc_ast* ast = malloc(sizeof(calc_ast));
    ast->op = '=';
    ast->arg0 = 0;
    ast->arg1 = 0;
    ast->value = vv;
    return ast;
}

calc_ast*
make_ast_op(char op, calc_ast* a0, calc_ast* a1)
{
    calc_ast* ast = malloc(sizeof(calc_ast));
    ast->op = op;
    ast->arg0 = a0;
    ast->arg1 = a1;
    return ast;
}

void
free_ast(calc_ast* ast)
{
    if (ast) {
        if (ast->arg0) {
            free(ast->arg0);
        }

        if (ast->arg1) {
            free(ast->arg1);
        }

        free(ast);
    }
}

int
ast_eval(calc_ast* ast)
{
    switch (ast->op) {
    case '=':
        return ast->value;
    case '+':
        return ast_eval(ast->arg0) + ast_eval(ast->arg1);
    case '-':
        return ast_eval(ast->arg0) - ast_eval(ast->arg1);
    case '*':
        return ast_eval(ast->arg0) * ast_eval(ast->arg1);
    case '/':
        return ast_eval(ast->arg0) / ast_eval(ast->arg1);
    default:
        fprintf(stderr, "Unknown op: %c\n", ast->op);
        exit(1);
    }
}

char*
ast_string(calc_ast* ast)
{
    if (ast->op == '=') {
        char* tmp = malloc(16);
        sprintf(tmp, "%d", ast->value);
        return tmp;
    }
    else {
        char* aa = ast_string(ast->arg0);
        char* bb = ast_string(ast->arg1);
        char* cc = malloc(128);
        sprintf(cc, "(%s %c %s)", aa, ast->op, bb);
        free(aa);
        free(bb);
        return cc;
    }
}

void
print_ast(calc_ast* ast)
{
    char* text = ast_string(ast);
    printf("%s\n", text);
    free(text);
}
```
