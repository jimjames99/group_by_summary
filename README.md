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

Create a summary object by passing an array of arrays. Each containing 2 or 3 elements:
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
+-----------+-------+--------+--------+--------+
|           | apple | banana | orange | tomato |
+-----------+-------+--------+--------+--------+
| Eastside  | 22    | 44     |        |        |
| Westside  |       | 33     | 44     |        |
| Northside |       |        |        | 55     |
+-----------+-------+--------+--------+--------+
```
Or output to console with tab separators so you can paste it into an Excel spreadsheet:
```

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/group_by_summary. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

