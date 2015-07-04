require 'group_by_summary/version'
require 'array_named_access'

class GroupBySummary

  attr_reader :list_of_items

  # Imagine you run a chain of stores that sell different kinds of fruit.
  # Query for store name and kind of fruit in stock:
  # StoreInventory.group(:name, :fruit).pluck(:name, :fruit, 'sum(quantity)')
  # [
  #   ['Eastside', 'banana', 44],
  #   ['Eastside', 'apple', 22],
  #   ['Westside', 'banana', 33],
  #   ['Westside', 'orange', 44],
  #   ['Northside', 'tomato', 55],
  # ]
  #
  # Order matters here: entity, attributes, value (optional)
  # Also must be ordered by entity.
  #
  def initialize(arr=[])
    @list_of_items = Array.new(arr).extend(ArrayNamedAccess)
    @list_of_items.each{|a| a.extend(ArrayNamedAccess)}
  end

  # ['apple', 'banana', 'orange', 'tomato']
  def column_names
    @column_names ||= @list_of_items.collect(&:second).uniq.sort
  end

  # ['Store', 'apple', 'banana', 'orange', 'tomato']
  def heading(entity_name=nil)
    [entity_name] + column_names
  end

  def rows
    rows = []
    @list_of_items.group_by(&:first).each do |store|
      store.extend(ArrayNamedAccess)
      store_row = [nil] * heading.size
      # Add the entity name to the start of the row.
      store_row[0] = store.first
      # Fill in values for each column (remember entity name is already first position).
      store.second.each do |tuple|
        store_row[@column_names.index(tuple.second) + 1] = (tuple.third || 'x')
      end
      rows << store_row
    end
    rows
  end

  def rows_with_tabs
    rows.collect{|i| i.join("\t")}
  end

end
