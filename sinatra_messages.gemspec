# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sinatra_messages}
  s.version = "1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.4") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jen Oslislo"]
  s.date = %q{2014-02-19}
  s.description = %q{Pretty stdout and js console logging for your Sinatra app}
  s.email = ["jennifer@stepchangegroup.com"]
  s.files = ["lib/sinatra", "lib/sinatra/messages_helper.rb", "lib/sinatra/messages.rb", "lib/sinatra_messages.rb", "test/sinatra_messages_test.rb", "README.md"]
  s.homepage = %q{https://github.com/mjfreshyfresh/sinatra_messages}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{sinatra_messages}
  s.rubygems_version = %q{1.3.7.1}
  s.summary = %q{Logging all up in your Sinatra.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<colored>, [">= 1.2"])
    else
      s.add_dependency(%q<colored>, [">= 1.2"])
    end
  else
    s.add_dependency(%q<colored>, [">= 1.2"])
  end
end
