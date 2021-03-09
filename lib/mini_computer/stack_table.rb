# frozen_string_literal: true

require "tty-table"

class StackTable
  attr_reader :stacks, :headers

  def initialize
    @headers = []
    @stacks = []
  end

  def ==(other)
    @headers == other.headers && @stacks == other.stacks
  end

  def add(stacks)
    stacks.each do |stack|
      @headers << stack.header
      @stacks << stack.to_a
    end
  end

  def render
    table = TTY::Table.new(header: @headers)
    # max_stack = @stacks.max_by(&:size)
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
        row << stack[index]
      end
      rows << row
    end
    rows
  end
end
