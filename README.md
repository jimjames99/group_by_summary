# GroupBySummary

You run a chain of stores that carry different kinds of fruit. Which stores carry which fruit?
The query for store name, fruit, and quantity in stock returns many rows for each store:

```StoreInventory.group(:name, :fruit).pluck(:name, :fruit, 'sum(quantity)')```

```
[
['Eastside', 'banana', 44],
['Eastside', 'apple', 22],
['Westside', 'banana', 33],
['Westside', 'orange', 44],
['Northside', 'tomato', 55],
with many rows for each store
]
```

You want to consolidate those rows into pretty summary table with only one row per store like this (output by [TerminalTable](https://github.com/tj/terminal-table)):

```
|           | apple | banana | orange | tomato |
|-----------|------:|-------:|-------:|-------:|
| Eastside  |    22 |     44 |        |        |
| Westside  |       |     33 |     44 |        |
| Northside |       |        |        |     55 |
```

Or you want to tab-separate the row values so you can paste it into an Excel spreadsheet.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'group_by_summary'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install group_by_summary

## Usage

Create a summary object by passing an array of arrays. The output of this arel is perfect:
```StoreInventory.group(:name, :fruit).pluck(:name, :fruit, 'sum(quantity)')```
Each array containing 2 or 3 elements:
* entity name
* attribute for column heading
* value to be displayed in the cell (optional)

```
require 'group_by_summary'
raw_rows = 
  [
    ['Eastside', 'banana', 44],
    ['Eastside', 'apple', 22],
    ['Westside', 'banana', 33],
    ['Westside', 'orange', 44],
    ['Northside', 'tomato', 55]
  ]
summary = GroupBySummary.new(raw_rows)
```

Column headings for the table are extracted from the second element in the array 
```
summary.heading
=> [nil, 'apple', 'banana', 'orange', 'tomato']
```
 If you want to give a column heading for the entity column (first col), give it a name:
```
summary.heading('Store')
=> ['Store', 'apple', 'banana', 'orange', 'tomato']
```
Install the [TerminalTable gem](https://github.com/tj/terminal-table) to display a nice table:
```
require 'terminal-table'
table = Terminal::Table.new(rows: summary.rows)
table.headings = summary.heading
puts table
=>
+-----------+-------+--------+--------+--------+
|           | apple | banana | orange | tomato |
+-----------+-------+--------+--------+--------+
| Eastside  | 22    | 44     |        |        |
| Westside  |       | 33     | 44     |        |
| Northside |       |        |        | 55     |
+-----------+-------+--------+--------+--------+
```
Or output to console with tab separators so you can paste it into an Excel spreadsheet. If values are not present an x is printed. 
```
puts summary.to_s(:tab)
=>
	apple	banana	orange	tomato
Eastside	x	x
Westside		x	x
Northside				x
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
