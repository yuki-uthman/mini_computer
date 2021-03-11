# frozen_string_literal: true

require "tty-table"

# This class makes it easier to render stacks
# next to each other
class StackTable
  attr_reader :stacks

  def initialize
    @headers = []
    @stacks = []
  end

  def ==(other)
    @stacks == other.stacks
  end

  def add(*stacks)
    stacks.each do |stack|
      @stacks << stack
    end
  end

  def render
    table = TTY::Table.new(header: headers)
    rows.each do |row|
      table << row
    end
    table.render(:unicode, alignment: [:center], padding: [0, 1, 0, 1])
  end

  private

  def rows
    max_size = @stacks.max_by(&:size).size
    rows = []
    (max_size - 1).downto(0) do |index|
      row = []
      @stacks.each do |stack|
        row << stack.to_a[index]
      end
      rows << row
    end
    rows
  end

  def headers
    to_result = []
    @stacks.each do |stack|
      to_result << stack.header
    end
    to_result
  end
end
