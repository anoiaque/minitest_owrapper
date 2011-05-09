# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "minitest_owrapper/version"

Gem::Specification.new do |s|
  s.name        = "minitest_owrapper"
  s.version     = MinitestOwrapper::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Philippe Cantin"]
  s.email       = ["anoiaque@gmail.com"]
  s.homepage    = "https://github.com/anoiaque/minitest_owrapper"
  s.summary     = %q{Get tests results as a TestResult object instead tied to output}
  s.description = %q{ With ruby or macruby test unit or minitest, results are damnly tied to output and you can't get result
                  of a test as an object after its execution and global tests result as an object too.
                  This gem permit to do so, and, have result of a unit test (with minitest  testunit and macruby for now but can easily be evolved
                  with ruby. See usage on github repository)
                  }
  s.add_dependency("minitest")
  s.rubyforge_project = "minitest_owrapper"

  s.files = Dir['lib/**/*.rb']
  s.require_path = "lib"
  s.test_files  = Dir['test/**/*.rb']
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
end
