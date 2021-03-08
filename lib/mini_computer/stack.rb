# frozen_string_literal: true

require "tty-table"

class StackEmptyError < StandardError
end

class Stack
  attr_reader :header

  def initialize(header = "Stack")
    @header = header
    @stack ||= []
  end

  def ==(other)
    @stack == other
  end

  def push(data)
    @stack.push data
  end

  def pop
    raise StackEmptyError if @stack.empty?

    @stack.pop
  end

  def size
    @stack.size
  end

  def empty?
    @stack.empty?
  end

  def to_a
    @stack
  end

  def view
    formatted = []
    @stack.reverse_each do |value|
      formatted << [value]
    end
    table = TTY::Table.new [header], formatted
    puts table.render(:unicode, alignment: [:center], padding: [0, 1, 0, 1])
  end
end
