# frozen_string_literal: true

require "tty-prompt"
require_relative "mini_computer/version"
require_relative "mini_computer/stack"
require_relative "mini_computer/stack_table"
require_relative "mini_computer/tokenizer"
require_relative "mini_computer/converter"

# Main Driver module for visualizing the conversion
module MiniComputer
  CONVERTER = Converter.new

  def self.run
    prompt = TTY::Prompt.new
    loop do
      input = prompt.ask("Please input infix expression ( press Q to quit )",
                         required: true)
      break if input.downcase == "q"

      CONVERTER.input = tokenize(input)
      display

      loop do
        next_or_back = prompt.select("Next or Back", %w[next back])
        case next_or_back
        when "next"
          done = CONVERTER.next
          break unless done
        when "back"
          CONVERTER.back
        end

        display
      end
      result = CONVERTER.output.to_a.join
      puts
      puts "Final result = #{result}"
      puts
    end

    shutdown
  end

  def self.display
    table = StackTable.new
    table.add CONVERTER.input
    table.add CONVERTER.output
    table.add CONVERTER.ops

    puts table.render
  end

  def self.tokenize(input)
    input = Tokenizer.tokens(input)
    input.reverse
  end

  def self.shutdown
    puts "shutting down..."

    3.times do
      sleep 1
      puts "..."
    end

    sleep 1
    puts "done"
    sleep 1
  end
end
