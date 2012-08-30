module Dada
  class Phrase
    attr_accessor :terms

    def initialize(*terms)
      @terms = terms
    end

    def <<(term)
      @terms << term
    end

    def ==(other)
      @terms == other.terms
    end

    include Enumerable
    def each(&blk)
      @terms.each(&blk)
    end

    def resolve(generator)
      each_with_index do |val, i|
        next if val.is_a?(String)
        @terms[i] = generator.term(val)
        @terms[i].resolve(generator)
      end
    end

    def to_s
      map { |x| x.to_s }.join('')
    end
  end
end
