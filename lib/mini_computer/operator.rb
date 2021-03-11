# frozen_string_literal: true

# This class provides a class method to compare
# the precedence between operators
class Operator
  STRENGTH = { nil => -1,
               :+ => 0,
               :- => 0,
               :* => 1,
               :/ => 1,
               :% => 1,
               :^ => 2 }.freeze

  def self.compare(left, right)
    STRENGTH[left] <=> STRENGTH[right]
  end
end
