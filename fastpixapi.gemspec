# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

Gem::Specification.new do |s|
  s.name        = 'fastpixapi'
  s.version     = '1.1.5'
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['Apache-2.0']
  s.summary     = 'Ruby client SDK for FastPix API'
  s.description = 'A robust, type-safe Ruby SDK for seamless integration with the FastPix API platform for media uploads, live streaming, playlists, analytics, and signing keys.'
  s.authors     = ['FastPix']
  s.email       = ['devs@fastpix.com']
  s.homepage    = 'https://fastpix.com/docs'

  s.files         = Dir['{lib,test}/**/*']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3.2'

  s.add_dependency('base64', '>= 0.2.0', '< 1.0')
  s.add_dependency('faraday', '~> 2.0')
  s.add_dependency('faraday-multipart', '~> 1.2.0')
  s.add_dependency('faraday-retry', '~> 2.4.0')
  s.add_dependency('sorbet-runtime', '~> 0.6.12872')
  s.add_development_dependency('irb', '~> 1.0')
  s.add_development_dependency('json_schemer', '~> 2.3')
  s.add_development_dependency('minitest', '~> 5.27', '>= 5.27.0')
  s.add_development_dependency('minitest-focus', '~> 1.4.1')
  s.add_development_dependency('rake', '~> 13.0')
  s.add_development_dependency('rubocop', '~> 1.73.2')
  s.add_development_dependency('rubocop-minitest', '~> 0.37.1')
  s.add_development_dependency('sorbet', '~> 0.6.12872')
  s.add_development_dependency('tapioca', '~> 0.17.10')
  s.add_development_dependency('tsort', '~> 0.2.0')
end
