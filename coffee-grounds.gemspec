$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "coffee-grounds/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "coffee-grounds"
  s.version     = CoffeeGrounds::VERSION
  s.authors     = ["Andrew Hecht"]
  s.email       = ["andy@hechtllc.com"]
  s.homepage    = "https://github.com/Velkitor/coffee-grounds"
  s.summary     = "Grind your rails routes in to javascript."
  s.description = "This gem will provide an easy way to export your rails routes to a javascript file that you can then include in your asset pipeline."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.5"
end
