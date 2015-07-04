require 'test_helper'

class GroupBySummaryTest < Minitest::Test

  def setup
    @test_array = [
        ['Eastside', 'banana', 44],
        ['Eastside', 'apple', 22],
        ['Westside', 'banana', 33],
        ['Westside', 'orange', 44],
        ['Northside', 'tomato', 55],
    ]
    @summary = GroupBySummary.new(@test_array)
  end

  def test_that_it_has_a_version_number
    refute_nil ::GroupBySummary::VERSION
  end

  def test_it_creates_rows
    rows = @summary.rows
    expected_rows = [
        ['Eastside', 22, 44, nil, nil],
        ['Westside', nil, 33, 44, nil],
        ['Northside', nil, nil, nil, 55]
    ]
    assert_equal expected_rows, rows, rows
  end

  def test_it_creates_rows_with_tabs
    rows_with_tabs = @summary.rows_with_tabs
    expected_rows_with_tabs =
        ["Eastside\t22\t44\t\t",
         "Westside\t\t33\t44\t",
         "Northside\t\t\t\t55"]
    assert_equal expected_rows_with_tabs, rows_with_tabs, rows_with_tabs
  end

  def test_it_builds_heading
    heading = @summary.heading
    expected_heading = [nil, 'apple', 'banana', 'orange', 'tomato']
    assert_equal expected_heading, heading, heading
  end

  def test_it_builds_heading_with_tabs
    heading_with_tabs = @summary.heading_with_tabs
    expected_heading_with_tabs = "\tapple\tbanana\torange\ttomato"
    assert_equal expected_heading_with_tabs, heading_with_tabs, heading_with_tabs
  end

  def test_it_builds_heading_with_name
    heading = @summary.heading('Store')
    expected_heading_with_name = ['Store', 'apple', 'banana', 'orange', 'tomato']
    assert_equal expected_heading_with_name, heading, heading
  end

  def test_it_handles_empty_array
    assert_equal [], GroupBySummary.new([]).rows
    assert_equal [nil], GroupBySummary.new([]).heading
    assert_equal ['Store'], GroupBySummary.new([]).heading('Store')
  end

  def test_it_generates_to_s
    test_array = [
        ['Eastside', 'banana'],
        ['Eastside', 'apple'],
        ['Westside', 'banana'],
        ['Westside', 'orange'],
        ['Northside', 'tomato'],
    ]
    summary = GroupBySummary.new(test_array)
    output = [[nil, "apple", "banana", "orange", "tomato"], ["Eastside", "x", "x", nil, nil], ["Westside", nil, "x", "x", nil], ["Northside", nil, nil, nil, "x"]]
    assert_equal output, summary.to_s
  end

  def test_it_generates_to_s_with_tabs
    test_array = [
        ['Eastside', 'banana'],
        ['Eastside', 'apple'],
        ['Westside', 'banana'],
        ['Westside', 'orange'],
        ['Northside', 'tomato'],
    ]
    summary = GroupBySummary.new(test_array)
    output = ["\tapple\tbanana\torange\ttomato", "Eastside\tx\tx\t\t", "Westside\t\tx\tx\t", "Northside\t\t\t\tx"]
    assert_equal output, summary.to_s(:tab)
  end

end
