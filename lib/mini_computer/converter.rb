# frozen_string_literal: true

require_relative "stack"
require_relative "operator"

# This class converts infix to postfix one step at a time
class Converter
  attr_reader :input, :output, :ops, :history

  def initialize(input = [])
    @input = Stack.new header: "Input", with: input
    @output = Stack.new header: "Output"
    @ops = Stack.new header: "Ops"
    @history = Stack.new header: "History"
  end

  def input=(input)
    reset
    @input.set = input
  end

  def reset
    @input.set = []
    @output.set = []
    @ops.set = []
    @history.set = []
  end

  def state=(arr)
    @input.set = arr[0]
    @output.set = arr[1]
    @ops.set = arr[2]
  end

  def state
    [@input.to_a.clone, @output.to_a.clone, @ops.to_a.clone]
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
