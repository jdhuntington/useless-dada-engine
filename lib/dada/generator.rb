module Dada
  class Generator
    def initialize(parser)
      @atoms = parser.atoms
    end

    def generate
      starting_phrase = term
      starting_phrase.resolve(self)
      starting_phrase.to_s
    end

    def term(name=:main)
      @atoms[name].random.dup
    end
  end
end
