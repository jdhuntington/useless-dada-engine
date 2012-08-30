require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Dada::Generator do
  it 'should generate a simple string' do
    contents = fixture('simple')
    g = Dada::Generator.new(Dada::Parser.new(contents))
    g.generate.should == "Hello, world!"
  end
end
