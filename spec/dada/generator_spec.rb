require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Dada::Generator do
  it 'should generate a simple string' do
    contents = fixture('simple')
    g = Dada::Generator.new(Dada::Parser.new(contents))
    g.generate.should == "Hello, world!"
  end

  it 'should generate a string from 5 rules' do
    contents = fixture('5-rules')
    g = Dada::Generator.new(Dada::Parser.new(contents))
    expects_either = %w{ foo bar }
    expects_either.should include(g.generate)
  end
end
