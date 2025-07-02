# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'fastpixapi'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['Apache-2.0']
  s.summary     = 'Developer-friendly Ruby SDK for the FastPix Live Streaming API.'
  s.description = 'A developer-friendly and type-safe Ruby SDK for integrating with the FastPix Live Streaming API. This SDK enables you to create, manage, and distribute live video streams, configure stream settings, simulcast to external platforms, and manage playback and video assets with ease.'
  s.authors     = ['devs@fastpix.io']
  s.homepage    = 'https://www.fastpix.io'

  s.files         = Dir['{lib,test}/**/*']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3.2'

  s.add_dependency('base64', '~> 0.2.0')
  s.add_dependency('faraday', '~> 2.0')
  s.add_dependency('faraday-multipart', '~> 1.0')
  s.add_dependency('faraday-retry', '~> 2.2.1')
  s.add_dependency('rack', '~> 2.0')
  s.add_dependency('rake', '~> 13.0')
  s.add_dependency('sorbet-runtime', '~> 0.5')
  s.add_development_dependency('minitest', '~> 5.0')
  s.add_development_dependency('minitest-focus', '~> 1.0')
  s.add_development_dependency('rubocop', '~> 1.73.2')
  s.add_development_dependency('rubocop-minitest', '~> 0.37.1')
  s.add_development_dependency('sorbet', '~> 0.5')
  s.add_development_dependency('tapioca', '~> 0.16.11')
end
