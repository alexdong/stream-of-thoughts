# -*- encoding: utf-8 -*-
# stub: eventmachine 1.2.7 ruby lib
# stub: ext/extconf.rb ext/fastfilereader/extconf.rb

Gem::Specification.new do |s|
  s.name = "eventmachine".freeze
  s.version = "1.2.7".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Francis Cianfrocca".freeze, "Aman Gupta".freeze]
  s.date = "2018-05-12"
  s.description = "EventMachine implements a fast, single-threaded engine for arbitrary network\ncommunications. It's extremely easy to use in Ruby. EventMachine wraps all\ninteractions with IP sockets, allowing programs to concentrate on the\nimplementation of network protocols. It can be used to create both network\nservers and clients. To create a server or client, a Ruby program only needs\nto specify the IP address and port, and provide a Module that implements the\ncommunications protocol. Implementations of several standard network protocols\nare provided with the package, primarily to serve as examples. The real goal\nof EventMachine is to enable programs to easily interface with other programs\nusing TCP/IP, especially if custom protocols are required.\n".freeze
  s.email = ["garbagecat10@gmail.com".freeze, "aman@tmm1.net".freeze]
  s.extensions = ["ext/extconf.rb".freeze, "ext/fastfilereader/extconf.rb".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "docs/DocumentationGuidesIndex.md".freeze, "docs/GettingStarted.md".freeze, "docs/old/ChangeLog".freeze, "docs/old/DEFERRABLES".freeze, "docs/old/EPOLL".freeze, "docs/old/INSTALL".freeze, "docs/old/KEYBOARD".freeze, "docs/old/LEGAL".freeze, "docs/old/LIGHTWEIGHT_CONCURRENCY".freeze, "docs/old/PURE_RUBY".freeze, "docs/old/RELEASE_NOTES".freeze, "docs/old/SMTP".freeze, "docs/old/SPAWNED_PROCESSES".freeze, "docs/old/TODO".freeze]
  s.files = ["README.md".freeze, "docs/DocumentationGuidesIndex.md".freeze, "docs/GettingStarted.md".freeze, "docs/old/ChangeLog".freeze, "docs/old/DEFERRABLES".freeze, "docs/old/EPOLL".freeze, "docs/old/INSTALL".freeze, "docs/old/KEYBOARD".freeze, "docs/old/LEGAL".freeze, "docs/old/LIGHTWEIGHT_CONCURRENCY".freeze, "docs/old/PURE_RUBY".freeze, "docs/old/RELEASE_NOTES".freeze, "docs/old/SMTP".freeze, "docs/old/SPAWNED_PROCESSES".freeze, "docs/old/TODO".freeze, "ext/extconf.rb".freeze, "ext/fastfilereader/extconf.rb".freeze]
  s.homepage = "http://rubyeventmachine.com".freeze
  s.licenses = ["Ruby".freeze, "GPL-2.0".freeze]
  s.rdoc_options = ["--title".freeze, "EventMachine".freeze, "--main".freeze, "README.md".freeze, "-x".freeze, "lib/em/version".freeze, "-x".freeze, "lib/jeventmachine".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Ruby/EventMachine library".freeze

  s.installed_by_version = "3.7.1".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<test-unit>.freeze, ["~> 2.0".freeze])
  s.add_development_dependency(%q<rake-compiler>.freeze, ["~> 0.9.5".freeze])
  s.add_development_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.5.1".freeze])
end
