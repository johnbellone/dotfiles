# -*- mode: enh-ruby -*-
Pry.config.editor = 'emacsclient -t'

prompt = "ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
Pry.config.prompt = [
  proc { |obj, nest_level, _| "#{prompt} (#{obj}):#{nest_level} > " },
  proc { |obj, nest_level, _| "#{prompt} (#{obj}):#{nest_level} * " },
  proc { |obj, nest_level, _| "#{prompt} (#{obj}):#{nest_level} - " }
]

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai(:indent => 2) }
rescue LoadError => e
  warn "[WARN] #{e}"
  puts "$ gem install awesome_print"
end
