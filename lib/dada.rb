module Dada
end

%w{ parser generator }.each do |f|
  require File.expand_path(File.join(File.dirname(__FILE__), 'lib', f))
end
