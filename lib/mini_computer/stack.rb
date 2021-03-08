# frozen_string_literal: true

require "tty-table"

class StackEmptyError < StandardError
end

class Stack
  def initialize(title = "Stack")
    @title = title
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

  def view
    formatted = []
    @stack.reverse_each do |value|
      formatted << [value]
    end
    table = TTY::Table.new [@title], formatted
    puts table.render(:unicode, alignment: [:center], padding: [0, 1, 0, 1])
  end
end
