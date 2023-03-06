
# Test Table  


**Check NOT a table if no line beginning with --- or |--- or :---  + `|`**

qsqsdqd | qsqdqd
qsqsdqd |---| qqsdqsd
|--- Not a table

**Check NOT a table if not at least 3 dashes `---`**

  FirstHeader    |     Header2      |     LastHeader 
--|--|--
 Left Align      | Center align     | Right align


**Check  Table if no leading/trailing pipe**

  FirstHeader       |     Header2        |     LastHeader
--------------------|:------------------:|--------------------:
 Left Align         | Center align       | Right align
 xxxxxxxxxxxxxxxxxx | xxxxxxxxxxxxxxxxxxx| xxxxxxxxxxxxxxxxxxxxxxxxx


**Check  Table if no leading/trailing pipe except delimiter row**

  FirstHeader       |     Header2        |     LastHeader
|--------------------|:------------------:|--------------------:
 Left Align         | Center align       | Right align
 xxxxxxxxxxxxxxxxxx | xxxxxxxxxxxxxxxxxxx| xxxxxxxxxxxxxxxxxxxxxxxxx

**Check  Table if spaces in delimiter row**

  FirstHeader       |     Header2        |     LastHeader
| --- | :---: | ---:
 Left Align         | Center align       | Right align
 xxxxxxxxxxxxxxxxxx | xxxxxxxxxxxxxxxxxxx| xxxxxxxxxxxxxxxxxxxxxxxxx


**Check  Table if leading pipe**

|  FirstHeader    |     Header2      |     LastHeader
|-----------------|:----------------:|-----------------:
| Left Align      | Center align     | Right align
| xxxxxxxxxxxxxxxxxx | xxxxxxxxxxxxxxxxxxx| xxxxxxxxxxxxxxxxxxxxxxxxx


**Check ColumnWidth , NewLine when exporting (Pandoc only)**
With pandoc, column width depends on number of dashes : 
if 3+6 dashes as  `|---|------|`,  column1 width=3/9   and   column2 width=6/9

| Header1    |             Header2            |  Header3
|------------|:------------------------------:|-----------------------------:|
| Very long text but will be shrink | Center align | Right align bsqdqsdqdsqsdqd qsdqds qsdqsdqds 
| `\` force a  \ New line     | Center align | Right align


