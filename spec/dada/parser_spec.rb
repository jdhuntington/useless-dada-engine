require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Dada::Parser do
  it 'should parse out a string' do
    contents = fixture('simple')
    p = Dada::Parser.new(contents)
    p.atoms.should == { :main => ["Hello, world!"] }
  end
end
