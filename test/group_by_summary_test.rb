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

  def test_it_builds_heading
    heading = @summary.heading
    expected_heading = [nil, 'apple', 'banana', 'orange', 'tomato']
    assert_equal expected_heading, heading, heading
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

end
