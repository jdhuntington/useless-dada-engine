require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Dada::Parser do
  it 'should parse out a string' do
    contents = fixture('simple')
    p = Dada::Parser.new(contents)
    p.atoms.should == { :main => ["Hello, world!"] }
  end

  it 'should parse out a 5 rule example' do
    contents = fixture('5-rules')
    p = Dada::Parser.new(contents)
    expected = {
      :word1 => ['foo'],
      :word2 => ['bar'],
      :term1 => [:word1],
      :term2 => [:word2],
      :main => [:term1, :term2, :word2],
    }
    p.atoms.should == expected
  end
end
