# frozen_string_literal: true

require_relative "lib/mini_computer/version"
Gem::Specification.new do |spec|
  spec.name          = "mini_computer"
  spec.version       = MiniComputer::VERSION
  spec.authors       = ["Yuki Yoshimine"]
  spec.email         = ["yuki07yuki@gmail.com"]

  spec.summary       = "A small project to visualize infix to postfix conversion using stack."
  spec.homepage      = "https://github.com/yuki07yuki/mini_computer.git"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.files =
    Dir.chdir(File.expand_path(__dir__)) do
      `git ls-files -z`.split("\x0").reject { |f|
        f.match(%r{\A(?:test|spec|features)/})
      }
    end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "tty-prompt"
  spec.add_runtime_dependency "tty-table"

  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "terminal-notifier"
  spec.add_development_dependency "terminal-notifier-guard"
end
