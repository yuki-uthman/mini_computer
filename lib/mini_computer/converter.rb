# frozen_string_literal: true

require_relative "stack"
require_relative "operator"

class Converter
  attr_reader :output

  def initialize
    @input = Stack.new header: "Input"
    @output = Stack.new header: "Output"
    @ops = Stack.new header: "Ops"
    @history = Stack.new header: "History", stack: []
  end

  def add(input:)
    @input.set input
    @output.set []
    @ops.set []
  end

  def state=(arr)
    @input.set arr[0]
    @output.set arr[1]
    @ops.set arr[2]
  end

  def state
    [@input.stack.clone, @output.stack.clone, @ops.stack.clone]
  end

  def next
    return false if @input.empty? && @ops.empty?

    save
    if !@input.empty?
      case @input.peek
      when Integer
        @output.push @input.pop
      when Symbol
        push_ops
      end
    elsif !@ops.empty?
      @output.push @ops.pop
    end
    true
  end

  def back
    if @history.empty?
      false
    else
      self.state = @history.pop
      true
    end
  end

  private

  def push_ops
    # if the ops stack has an operator with same/weaker precedence
    if !@ops.empty? && Operator.compare(@input.peek, @ops.peek) < 1
      # keep poping the ops stack until @input.peek is stronger
      @output.push @ops.pop until Operator.compare(@input.peek, @ops.peek) == 1
    end
    @ops.push @input.pop
  end

  def save
    @history.push state
  end
end
