module Dada
end

%w{ phrase util parser generator }.each do |f|
  require File.expand_path(File.join(File.dirname(__FILE__), 'dada', f))
end
