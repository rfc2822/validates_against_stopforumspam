$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "validates_against_stopforumspam/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "validates_against_stopforumspam"
  s.version     = ValidatesAgainstStopforumspam::VERSION
  s.authors     = ["Richard Hirner"]
  s.email       = ["hirner@bitfire.at"]
  s.homepage    = "http://github.com/rfc2822/validates_against_stopforumspam"
  s.summary     = "ActiveRecord model validation against stopforumspam.com (Rails 3)"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">3.0"

  s.add_development_dependency "sqlite3"
end
