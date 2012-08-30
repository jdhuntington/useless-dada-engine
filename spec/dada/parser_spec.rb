require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Dada::Parser do
  it 'should parse out a string' do
    contents = fixture('simple')
    p = Dada::Parser.new(contents)
    p.atoms.should == { :main => [Dada::Phrase.new("Hello, world!")] }
  end

  it 'should parse out a 5 rule example' do
    contents = fixture('5-rules')
    p = Dada::Parser.new(contents)
    expected = {
      :word1 => [Dada::Phrase.new('foo')],
      :word2 => [Dada::Phrase.new('bar')],
      :term1 => [Dada::Phrase.new(:word1)],
      :term2 => [Dada::Phrase.new(:word2)],
      :main => [Dada::Phrase.new(:term1),
                Dada::Phrase.new(:term2),
                Dada::Phrase.new(:word2)],
    }
    p.atoms.should == expected
  end

  it 'should understand concatenation' do
    contents = fixture('concatenation')
    p = Dada::Parser.new(contents)
    expected = {
      :he => [Dada::Phrase.new('he')],
      :main => [Dada::Phrase.new(:he, ' is here.')]
    }
    p.atoms.should == expected
  end
end
