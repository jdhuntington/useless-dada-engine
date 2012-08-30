module Dada
  class Generator
    def initialize(parser)
      @atoms = parser.atoms
    end

    def generate
      strings = generate_helper(:main).flatten
      strings.each do |s|
        abort "#{s.inspect} is not a string" unless s.is_a?(String)
      end
      strings.join('')
    end

    def generate_helper(definition)
      selection = @atoms[definition].random
      selection = selection.is_a?(Array) ? selection : [selection]
      selection.map do |x|
        if x.is_a? Symbol
          generate_helper x
        else
          x
        end
      end
    end
  end
end
