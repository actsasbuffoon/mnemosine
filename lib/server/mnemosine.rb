require 'eventmachine'
require 'json'
require 'sourcify'

require File.expand_path(File.join(File.dirname(__FILE__), "lib", "type_check.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "key.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "string.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "hash.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "list.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "persistence.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "lib", "process.rb"))