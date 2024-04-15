---
title: "cs2370 Notes: 30 Spreadsheets"
date: "2024-04-14"
---


**Spreadsheets**

Chapter: https://automatetheboringstuff.com/2e/chapter13/

Incindiary claim: Using a spreadsheet to calculate anything 
important is malpractice.
   
 - A spreadsheet is a way to write a computer program.
 - Computer programs for import stuff should be testable, 
   reusable, and maintainable.
 - Spreadsheets embed the input data for your program. The only way
   to run a spreadsheet on different data is to copy the whole thing
   and edit in the new data.
 - Not only that - spreadsheets are error prone. They like to do
   things like turning fractions into dates.

Spreadsheets can be a reasonable tool for exploring data, but any
results where getting something wrong would cause harm should be
replicated using a real computer program.

Now that I've said that, spreadsheets can also be used as a way to
store data rather than as a way to calculate - and that makes them
potentially useful as the input or output of a computer program.


**"Pork Barrel Spending"**

Looking around for a moderately complicated spreadsheet, I found
[Congressionally Directed Spending FY23](
../code/spending/FY2023%20CDS.xlsx). This is a list of local projects
that congresspeople have gotten federal funding for.

We've got amount and column, so we can start asking questions:

 - What's the total funding to each state?
 

```python
import openpyxl as xl
from openpyxl.utils import column_index_from_string as l2i
import re

wb = xl.load_workbook("FY2023 CDS.xlsx")
sheet = wb["results"]

amount_col = l2i("H")
states_col = l2i("I")


totals = {}


for row in range(8, sheet.max_row):
    amount = sheet.cell(column=amount_col, row=row).value
    states = sheet.cell(column=states_col, row=row).value

    if states == None:
        continue
    
    xs = re.split(r',\s*', states)

    for st in xs:
        amt = totals.get(st, 0)
        amt += int(amount) / len(xs)
        totals[st] = amt


out_wb = xl.Workbook()
sh = out_wb.active
sh.title = "CDS Totals by State"

sh["A1"] = "State"
sh["B1"] = "Total"

ii = 2
for st in sorted(totals.keys()):
    sh[f"A{ii}"] = st
    sh[f"B{ii}"] = totals[st]
    ii += 1

out_wb.save("output.xlsx")
```


California gets all the money. Why?

Let's normalize by population.

Here's the [congressional apportionment spreadsheet](
../code/spending/apportionment-2020.xlsx), which gives populations as
of 2020 by state.


``` python
awb = xl.load_workbook("apportionment-2020.xlsx")

sh = awb.active

for row in range(5, 55):
    state = sh[f"A{ii}"].value
    pop = sh[f"B{ii}"].value

    # Wait, that's state names not abbreviations. 
``` 

We can probably figure this out.



Data sources:

 - https://www.gao.gov/tracking-funds
 - https://www.census.gov/data/tables/2020/dec/2020-apportionment-data.html
