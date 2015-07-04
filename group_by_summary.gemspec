# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'group_by_summary/version'

Gem::Specification.new do |spec|
  spec.name          = 'group_by_summary'
  spec.version       = GroupBySummary::VERSION
  spec.authors       = ['jimjames99']
  spec.email         = ['jim@jimjames.org']

  spec.summary       = %q{Takes array produced from StoreInventory.group(:name, :fruit).pluck(:name, :fruit, 'sum(quantity)') and produces an array of arrays suitable for display in a table.}
  spec.description   = %q{Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/jimjames99/group_by_summary'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '>= 1.7.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5'
end
