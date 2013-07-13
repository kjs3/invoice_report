# Invoice Parsing and Output

### What it does

* Reads included csv and psv (pipe separated) txt files
* Automatically determines if file is csv or psv
* Files represent invoices and are split up into line-items
* Line-items are parsed differently depending on csv or psv type
* All invoices are grouped into a report
* Line-items from all invoices are grouped and sorted on date and name
* Line-items are also separately grouped and sorted by total spent on item
* Report is pretty-printed to the shell

Everything is just straight Ruby/Core so you shouldn't need anything special.

Tested on OS X 10.8 with Ruby 2.0.0p0 and Ruby 1.9.3p392

Tests are just Minitest so you don't need any spec/mocha gems.

### How to run

```
rake report
```

### Output

```
All Line Items

Date       Item                     Quant   Unit Price   Ext Price
7/10/2013  Apple Golden Delicious   1       $14.00       $14.00
7/10/2013  Rice Basmati 50#         2       $32.00       $64.00
7/11/2013  Beans Kidney             2       $11.00       $22.00
7/11/2013  Watermelon               4       $5.00        $20.00
7/12/2013  Flour White 50#          1       $17.00       $17.00
7/12/2013  Watermelon               2       $4.00        $8.00
7/13/2013  Apple Golden Delicious   2       $15.00       $30.00
7/13/2013  Beans Kidney             1       $12.00       $12.00


Total Spent per Item

Item                     Total
Rice Basmati 50#         64.00
Apple Golden Delicious   44.00
Beans Kidney             34.00
Watermelon               28.00
Flour White 50#          17.00
```

### Running Tests

```
rake test
```