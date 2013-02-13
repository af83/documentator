# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'documentator/version'

Gem::Specification.new do |s|
  s.name          = "documentator"
  s.version       = Documentator::VERSION
  s.authors       = ["chatgris"]
  s.email         = ["julien.boyer@af83.com"]
  s.homepage      = "https://github.com/AF83/documentator"
  s.summary       = "Documents all the things"
  s.description   = "documentator provides templates of documentations and
  command-line utilities to add them to a project."

  s.files        = `git ls-files bin lib LICENSE README.md`.split("\n")
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.platform      = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.add_dependency 'boson'
end
