---
title: "cs2370 Notes: 26 More Scraping"
date: "2024-03-30"
---

HTML Attributes

 - Each tag has attributes.
 - These are key-value pairs, so it's a dictionary.
 - Two are especially important.
 - The "id" is a unique string that indentifies that tag.
 - The "class" is a space-separated collection of non-unique strings.


```python
import requests
import bs4

resp = requests.get("https://homework.quest/")
resp.status_code
resp.raise_for_status()
resp.text
tree = bs4.BeautifulSoup(resp.text, 'html.parser')
xs = tree.select('p.ball__number')
for x in xs: print("[", x, "]")
```

 - '#foo'
 - '.foo'
 - soup.select('input[type="button"]')
 - spanElem.get('id')

## The Lottery

https://nhlottery.com/Winning-Numbers

 - There's a class for each game.
 - There's a class for numbers.
 - Print out numbers.


## Introducing Selenium

Sometimes it's useful to just do the HTTP request, get the result, and
process it.

Sometimes you want an actual web browser that will do things like running
JavaScript.


```
$ python -m pip install selenium
```

```python
browser = webdriver.Firefox()
browser.get("https://neal.fun/password-game")
```
