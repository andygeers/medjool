$:.unshift File.expand_path('../lib', __FILE__)
require 'medjool'

Gem::Specification.new do |s|
  s.name = 'medjool'
  s.version = Medjool::VERSION
  #s.rubyforge_project = 'medjool'
  s.license = 'MIT'
  s.summary     = 'Date parsing with context'
  s.description = 'Medjool is a date parser written in pure Ruby, which processes dates within a context.'
  s.authors  = ['Andy Geers']
  s.email    = ['andy@geero.net']
  s.homepage = 'http://github.com/andygeers/medjool'
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = %w[README.md LICENSE]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test`.split("\n")

  s.add_dependency 'activesupport', '~> 3.2.12'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest', '~> 5.0'
end
