# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "raggity/version"

Gem::Specification.new do |s|
  s.name        = "raggity"
  s.version     = Raggity::VERSION
  s.authors     = ["Eric J. Holmes"]
  s.email       = ["eric@ejholmes.net"]
  s.homepage    = "https://github.com/ejholmes/raggity"
  s.summary     = %q{A Git repository browser}
  s.description = %q{Raggity is a Git repository browser similar to gitweb and cgit}

  s.rubyforge_project = "raggity"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "sinatra"
  s.add_dependency "grit"
  s.add_dependency "github-markup"
  s.add_dependency "mustache"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "capybara"
end
