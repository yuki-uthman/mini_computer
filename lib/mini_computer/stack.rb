# frozen_string_literal: true

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
    renderer = TTY::Table::Renderer::Unicode.new(table)
  end
end
