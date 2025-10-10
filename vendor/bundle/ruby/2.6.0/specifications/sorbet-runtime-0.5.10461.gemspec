# -*- encoding: utf-8 -*-
# stub: sorbet-runtime 0.5.10461 ruby lib

Gem::Specification.new do |s|
  s.name = "sorbet-runtime".freeze
  s.version = "0.5.10461"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "source_code_uri" => "https://github.com/sorbet/sorbet" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Stripe".freeze]
  s.date = "2022-09-28"
  s.description = "Sorbet's runtime type checking component".freeze
  s.homepage = "https://sorbet.org".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.0.3.1".freeze
  s.summary = "Sorbet runtime".freeze

  s.installed_by_version = "3.0.3.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.11"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.90.0"])
      s.add_development_dependency(%q<rubocop-performance>.freeze, ["~> 1.8.0"])
      s.add_development_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1.5"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0"])
      s.add_development_dependency(%q<parser>.freeze, ["~> 2.7.1"])
      s.add_development_dependency(%q<subprocess>.freeze, ["~> 1.5.3"])
    else
      s.add_dependency(%q<minitest>.freeze, ["~> 5.11"])
      s.add_dependency(%q<mocha>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.90.0"])
      s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.8.0"])
      s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1.5"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
      s.add_dependency(%q<parser>.freeze, ["~> 2.7.1"])
      s.add_dependency(%q<subprocess>.freeze, ["~> 1.5.3"])
    end
  else
    s.add_dependency(%q<minitest>.freeze, ["~> 5.11"])
    s.add_dependency(%q<mocha>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.90.0"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.8.0"])
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.1.5"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
    s.add_dependency(%q<parser>.freeze, ["~> 2.7.1"])
    s.add_dependency(%q<subprocess>.freeze, ["~> 1.5.3"])
  end
end
