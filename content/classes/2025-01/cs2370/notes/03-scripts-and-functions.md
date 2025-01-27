---
title: "cs2370 Notes: 03 Scripts and Functions"
date: "2025-01-25"
---

## Scripts

```python
aa = int(input("aa = "))
bb = int(input("aa = "))

if aa > 10 and bb > 10:
   print("Both")

if aa > 10 or bb > 10:
   print("Either)
   
if aa <= 10 && bb <= 10:
    print("Neither")
```

Example 2:

```python
word = input("enter word: ")

if word < "n":
    print(word.capitalize())
else:
    print(word)
```


While loop example: 

 - let's write a script that left-pads strings to 40 chars in a loop


## Functions

Which has more alcohol, a 12 oz bottle of 10 proof beer or a 2 oz shot
of 80 proof tequila?

```python
beer_vol = 12
beer_proof = 10

teq_vol = 2
teq_proof = 80

teq_pct = teq_proof / 2.0
teq_frac = teq_pct / 100.0
teq_alco = teq_vol * teq_frac

beer_pct = beer_proof / 2.0
beer_frac = beer_pct / 100.0
beer_alco = beer_vol * beer_frac

if teq_alco > beer_alco:
    print("tequila")
else:
    print("beer")
```

```python
def proof_to_frac(proof):
    pct = proof / 2.0
    return pct / 100.0

def alcohol_volume(vol, proof):
    return proof_to_frac(proof) * vol
```


## Tests


```python
import approx from pytest

def test_proof_to_frac():
    assert proof_to_frac(100) == approx(50.0)
    assert proof_to_frac(80) == approx(40.0)

def test_alcohol_volume():
    assert ...
```

## How to set up tests with thing


## Design Recipe for Simple Data

 - A function that left pads a string to 40 characters (with a loop).
 - ...
