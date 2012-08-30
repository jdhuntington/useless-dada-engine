require 'rspec'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'dada'))

def fixture(filename)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', "#{filename}.dad"))
end
