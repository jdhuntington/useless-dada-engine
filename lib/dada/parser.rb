require 'stringio'

module Dada
  class Parser
    class SyntaxError < StandardError; end

    attr_accessor :atoms

    def initialize(input)
      @input = input.respond_to?(:rewind) ? input : StringIO.new(input)
      @atoms = {}
      parse!
    end

    def parse!
      while input_left_to_consume? do
        atom = read_lhs!
        consume_whitespace!
        read_equals!
        consume_whitespace!
        definition = read_rhs!
        @atoms[atom] = definition
        consume_whitespace!
      end
    end

    def input_left_to_consume?
      !@input.eof?
    end

    def read_lhs!
      val = []
      while true do
        char = @input.getc
        if char =~ /\w/
          val << char
        else
          @input.ungetc(char)
          break
        end
      end
      val.join('').to_sym
    end

    def read_rhs!
      rhs = []
      while true do
        break unless input_left_to_consume?
        if @input.getc == '"'
          rhs << read_string!
        elsif @input.getc == '|'
          # keep on going
        elsif @input.getc == "\n"
          break
        else
          read_atom!
        end
        consume_whitespace!
      end
      rhs
    end

    def read_atom!
      
    end

    def read_string!
      val = []
      while true do
        char = @input.getc
        if char == '"'
          break
        else
          val << char
        end
      end
      val.join('')
    end

    def consume_whitespace!
      while true do
        char = @input.getc
        if !(char =~ /\s/)
          @input.ungetc(char)
          break
        end
      end
    end

    def read_equals!
      char = @input.getc
      if char != '='
        raise SyntaxError.new("Expected '=' at #{input.read[0..10]}")
      end
    end
  end
end
