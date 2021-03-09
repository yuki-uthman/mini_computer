require_relative "../../lib/mini_computer/stack"
require_relative "../../lib/mini_computer/converter"

RSpec.describe "Converter class" do
  before do
    @converter = Converter.new
  end

  describe "#next" do
    context "when the input stack becomes empty" do
      it "should handle StackEmptyError by returning false" do
        @converter.add input: [2]
        @converter.next
        expect(@converter.state).to eq [[], [2], []]
        expect(@converter.next).to eq false
        expect(@converter.next).to eq false
      end

      context "when there is some left on the ops stack" do
        it "should pop the ops to output" do
          @converter.state = [[], [1, 2, 3], [:+]]
          @converter.next
          expect(@converter.state).to eq [[], [1, 2, 3, :+], []]
        end
      end
    end

    context "when popped element is a number" do
      it "pops it to output stack" do
        @converter.add input: [1, 2, 3]

        expected = [[1, 2, 3], [], []]
        expect(@converter.state).to eq expected

        @converter.next
        expected = [[1, 2], [3], []]
        expect(@converter.state).to eq expected

        @converter.next
        @converter.next
        expected = [[], [3, 2, 1], []]
        expect(@converter.state).to eq expected
      end

      it "can use while loop to iterate through to the end" do
        @converter.add input: [1, 2, 3]
        @converter.next while @converter.next
        expected = [[], [3, 2, 1], []]
        expect(@converter.state).to eq expected
      end
    end

    context "when popped element is an operator" do
      context "and ops stack is empty" do
        it "should always push to ops stack" do
          @converter.add input: [:+]
          @converter.next
          expected = [[], [], [:+]]
          expect(@converter.state).to eq expected
        end
      end

      context "with stronger precedence" do
        it "pops it to ops stack" do
          @converter.state = [[:*], [], [:+]]
          @converter.next
          expected = [[], [], [:+, :*]]
          expect(@converter.state).to eq expected
        end

        it "can use while loop to iterate through to the end" do
          @converter.add input: [:+, :*]
          @converter.next while @converter.next
          expected = [[], [:*, :+], []]
          expect(@converter.state).to eq expected
        end
      end

      context "with same/weaker precedence" do
        it "pops ops stack and push it to output stack" do
          @converter.state = [[:+], [], [:*]]
          @converter.next
          expected = [[], [:*], [:+]]
          expect(@converter.state).to eq expected

          @converter.state = [[:+], [], [:-]]
          @converter.next
          expected = [[], [:-], [:+]]
          expect(@converter.state).to eq expected
        end

        it "can use while loop to iterate through to the end" do
          @converter.add input: [:+, :*]
          @converter.next while @converter.next
          expected = [[], [:*, :+], []]
          expect(@converter.state).to eq expected
        end
      end
    end

    context "more complex example" do
      it "can get the correct answer" do
        input = [3, :*, 2, :+, 1]
        @converter.add input: input
        @converter.next while @converter.next
        expected = [[], [1, 2, 3, :*, :+], []]
        expect(@converter.state).to eq expected

        input = [5, :-, 4, :/, 3, :*, 2, :+, 1]
        @converter.add input: input.clone
        @converter.next while @converter.next
        expected = [1, 2, 3, :*, 4, :/, :+, 5, :-]
        expect(@converter.output).to eq expected
      end
    end
  end # describe
end
