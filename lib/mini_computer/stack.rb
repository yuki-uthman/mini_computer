# frozen_string_literal: true

require "tty-table"

class StackEmptyError < StandardError
end

# Simple stack implementation
class Stack
  attr_accessor :header, :data

  def initialize(header: "Stack", with: [])
    @header = header
    @data = with
  end

  def ==(other)
    @data == other
  end

  def push(data)
    @data.push data
  end

  def pop
    raise StackEmptyError if @data.empty?

    @data.pop
  end

  def set=(data)
    @data = data
  end

  def clear
    @data = []
  end

  def peek
    @data.last
  end

  def size
    @data.size
  end

  def empty?
    @data.empty?
  end

  def to_a
    @data.clone
  end

  def view
    formatted = []
    @data.reverse_each do |value|
      formatted << [value]
    end
    table = TTY::Table.new [header], formatted
    puts table.render(:unicode, alignment: [:center], padding: [0, 1, 0, 1])
  end
end
