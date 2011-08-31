guard 'shell' do
  watch(%r{^lib/(.+)\.rb$}) {|m| `ruby test/test_helper.rb` }
  watch(%r{^test/.+\.rb$})  {|m| `ruby test/test_helper.rb` }
end
