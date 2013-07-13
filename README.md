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

Everything is just straight Ruby/Core so you shouldn't need anything special

Tests are just Minitest so you don't need any spec/mocha gems

### How to run

```
rake report
```

### Running Tests

```
rake test
```

That's It!