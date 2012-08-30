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
      consume_whitespace!
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
      read_atom!
    end

    def read_rhs!
      rhs = []
      while true do
        break unless input_left_to_consume?
        char = get_char
        if char == "\n"
          break
        elsif char == '|'
          # add a term, nop
        else
          unget_char
          rhs << read_phrase!
        end
        consume_whitespace!(:no_newline => true)
      end
      STDERR.puts "Got RHS: #{rhs.inspect}" if ENV['DEBUG_PARSER']
      rhs
    end

    def read_phrase!
      phrase = Phrase.new
      while true do
        break unless input_left_to_consume?
        char = get_char
        if char == '"'
          phrase << read_string!
        elsif char == '|' || char == "\n"
          unget_char
          break
        else
          unget_char
          phrase << read_atom!
        end
        consume_whitespace!(:no_newline => true)
      end
      STDERR.puts "Got phrase: #{phrase.inspect}" if ENV['DEBUG_PARSER']
      phrase
    end

    def read_atom!
      val = []
      while true do
        char = get_char
        if char =~ /\w/
          val << char
        else
          unget_char
          break
        end
      end
      val.join('').to_sym
    end

    def read_string!
      val = []
      while true do
        char = get_char
        if char == '"'
          break
        else
          val << char
        end
      end
      STDERR.puts "String is #{val.inspect}." if ENV['DEBUG_PARSER']
      val.join('')
    end

    def consume_whitespace!(opts={})
      while true do
        break unless input_left_to_consume?
        char = get_char
        if char == "\n" && opts[:no_newline]
          unget_char
          break
        end
        if !(char =~ /\s/)
          unget_char
          break
        end
      end
    end

    def read_equals!
      char = get_char
      if char != '='
        raise SyntaxError.new("Expected '=' at #{input.read[0..10]}")
      end
    end

    def get_char
      raise SyntaxError.new("Unexpected EOF") if !input_left_to_consume?
      @char = @input.getc
      STDERR.puts "Read: #{@char.inspect}" if ENV['DEBUG_PARSER']
      # STDERR.puts caller.join("\n") if ENV['DEBUG_PARSER'] && @char == '='
      # STDERR.puts caller.join("\n") if ENV['DEBUG_PARSER'] && @char == "\n"
      @char
    end

    def unget_char
      @input.ungetc(@char)
      STDERR.puts "Unread: #{@char.inspect}" if ENV['DEBUG_PARSER']
      nil
    end
  end
end
