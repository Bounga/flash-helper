require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'echoe'

Echoe.new('flash-helper', '1.0.0') do |p|
  p.description    = "This Rails extension provides a simple way to handle flash messages. You can easily display notices, errors and warnings using the convinience method."
  p.url            = "http://www.bitbucket.org/Bounga/flash-helper"
  p.author         = "Nicolas Cavigneaux"
  p.email          = "nico@bounga.org"
  p.development_dependencies = []
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the flash-helper plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the flash-helper plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'FlashHelper'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
