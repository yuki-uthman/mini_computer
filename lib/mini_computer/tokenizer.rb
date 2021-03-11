# frozen_string_literal: true

# This class helps to tokenize the infix notation
# to arrays of numbers and operators
class Tokenizer
  def self.tokens(string)
    tokens = string.split(%r{(\+|-|\*|/|%|\^)})
    tokens.map do |token|
      Integer(token)
    rescue ArgumentError
      token.to_sym
    end
  end
end
