---
title: "cs2370 Notes: 25 Web Scraping"
date: "2024-03-29"
---



```python
import requests

resp = requests.get("https://homework.quest/")
resp.status_code
resp.raise_for_status()
resp.text
```


Scraping Wikipedia:

 - Trying to use regex
 - main
 - 




```python
import requests
import bs4

resp = requests.get("https://homework.quest/")
resp.status_code
resp.raise_for_status()
resp.text
tree = bs4.BeautifulSoup(resp.text, 'html.parser')
xs = tree.select('a')
for x in xs: print("[", x, "]")
```

 - '#foo'
 - '.foo'
 - soup.select('input[type="button"]')
 - spanElem.get('id')


 - https://en.wikipedia.org/wiki/List_of_Pok%C3%A9mon
