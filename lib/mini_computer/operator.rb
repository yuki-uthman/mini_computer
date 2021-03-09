# frozen_string_literal: true

class Operator
  STRENGTH = { nil => -1,
               :+ => 0,
               :- => 0,
               :* => 1,
               :/ => 1,
               :% => 1,
               :^ => 2 }

  def self.compare(left, right)
    STRENGTH[left] <=> STRENGTH[right]
  end
end
