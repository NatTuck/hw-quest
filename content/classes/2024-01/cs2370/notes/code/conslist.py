

class Empty():
    # ConsList -> String
    def __str__(self):
        return "()"

    # ConsList -> boolean
    def isEmpty(self):
        return True

empty = Empty()


class Cons:
    # constructor
    def __init__(self, first, rest):
        self.first = first
        self.rest = rest

    # ConsList -> String
    def __str__(self):
        if self.rest.isEmpty():
            return f"({self.first})"
        else:
            rest = str(self.rest)[1:-1]
            return f"({self.first}, {rest})"

    # ConsList -> boolean
    def isEmpty(self):
        return False


# Any, Any, ... -> ConsList
def list(*items):
    if len(items) == 0:
        return empty
    else:
        return Cons(items[0], list(*items[1:]))

def add1_to_all(xs):
    if xs.isEmpty():
        return empty
    else:
        return Cons(2 * xs.first, add1_to_all(xs.rest))

# Map example


# Filter example


# Reduce example


# Map from reduce


    
# (ConsList of Number) -> Number
def sum(xs):
    if xs.isEmpty():
        return 0
    else:
        return xs.first + sum(xs.rest)


# ConsList -> Number
def length(xs):
    if xs.isEmpty():
        return 0
    else:
        return 1 + length(xs.rest)




if __name__ == '__main__':
    xs = Cons(1, Cons(2, Cons(3, empty)))
    ys = list(1, 2, 3)
    print(ys)
    print(sum(ys))
