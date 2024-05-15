Gem::Specification.new do |s|
  s.name = 'markdown_stream_formatter'
  s.version = '1.0.0'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = ">= 3.1.0"
  s.summary = 'String stream markdown parser'
  s.description = "Markdown parsing for the CLI supporting string streams, allowing to format before you know the full markdown"
  s.authors = ['Philipp Schlesinger']
  s.email = ['info@philcomm.dev']
  s.homepage = 'https://github.com/OfficialPhilcomm/markdown-stream-formatter'
  s.license = 'MIT'
  s.files = Dir.glob('{lib}/**/*')
  s.require_path = 'lib'
end
