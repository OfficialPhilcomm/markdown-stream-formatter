# Markdown Stream Formatter
This gem allows you to format a stream of markdown for the terminal. Useful for example for OpenAI GPT streams, when you don't have the full markdown yet.

## Installation
```
gem install markdown_stream_formatter
```

## Usage
```ruby
require "markdown_stream_formatter"

formatter = MarkdownStreamFormatter.new

# Feed next part of string and return formatted markdown
formatter.next(str)
```
