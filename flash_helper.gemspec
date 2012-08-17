$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "flash_helper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "flash_helper"
  s.version     = FlashHelper::VERSION
  s.authors     = ["Nicolas Cavigneaux"]
  s.email       = ["nico@bounga.org"]
  s.homepage    = "http://www.bitbucket.org/Bounga/flash-helper"
  s.summary     = "Rails helpers to easily display flash messages"
  s.description = "Flash helper provides a simple way to handle flash messages. You can easily display notices, errors and warnings using the convinience method."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "minitest"
  s.add_development_dependency "turn"
end
