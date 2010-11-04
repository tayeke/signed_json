# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "signed_json/version"

Gem::Specification.new do |s|
  s.name        = "signed_json"
  s.version     = SignedJson::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paul Annesley"]
  s.email       = ["paul@annesley.cc"]
  s.homepage    = "http://github.com/pda/signed_json"
  s.summary     = %q{Encodes and decodes JSON-encodable data into and from a signed JSON string.}

  s.rubyforge_project = "signed_json"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
