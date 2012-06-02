$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "coffee-grounds/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "coffee-grounds"
  s.version     = CoffeeGrounds::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CoffeeGrounds."
  s.description = "TODO: Description of CoffeeGrounds."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.5"
end
