# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jquery/gmap/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "jquery-gmap-rails"
  spec.version       = Jquery::Gmap::Rails::VERSION
  spec.authors       = ["Alfonso Alba"]
  spec.email         = ["alfonso@alfonsoalba.com"]
  spec.description   = "Packs the jquery.gmap plugin"
  spec.summary       = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
