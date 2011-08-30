require 'base64'

desc "Run database server"
task :run do
  require File.join(File.dirname(__FILE__), "lib", "server", "mnemosine.rb")
  Mnemosine::Server.new
end

desc "Bundle into 1 file to create a gist"
task :pack do
  files = {}
  Dir["**/*"].select {|f| File.file?(f)}.each do |f|
    files[f] = Base64.encode64(File.read(f))
  end
  str = <<-EOS
# Since my entry consists of multiple files, but CodeBrawl insists everything
# must fit in a single gist, I had to create this installer. This script
# contains the Base64 encoded files in my project, including the tests and
# the Rakefile that generates this install script.
#
# To install, open IRB and paste the contents of this script in. If run in
# an empty directory, it will unpack its contents there. Should you run the
# script in a directory that is NOT empty, this installer will create a new
# directory and put the code there.
# 
# Be sure to consult the README that the installer creates. It has useful
# information about the DB, as this is a full client/server application.
# Also, be sure to take a look at the tests, as they are quite extensive.
# 
# As noted in the readme, this code this code is being released under the
# MIT license, so have fun with it!
require 'base64'
require 'fileutils'
files = #{files.inspect}
root_dir = Dir["*"].length > 0 ? "code_brawl_db/" : ""
files.each_pair do |f, content|
  f = root_dir + f
  FileUtils.mkdir_p File.dirname(f) unless File.exist?(File.dirname(f))
  File.open(f, 'w') {|file| file.write Base64.decode64(content)}
end
  EOS
  `echo "#{str.gsub('"', '\"')}" | pbcopy`
  puts "Copied to clipboard"
end
