module Dada
  class Generator
    def initialize(parser)
      @atoms = parser.atoms
    end

    def generate
      bits = []
      bits << @atoms[:main].random
      bits.join('')
    end
  end
end
