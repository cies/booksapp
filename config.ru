require 'open-uri'
require 'json'
require 'dalli'
require 'rack/cache'

use Rack::Cache,
  :verbose     => false,
  :metastore   => Dalli::Client.new,
  :entitystore => Dalli::Client.new

base_uri = 'https://www.googleapis.com'
client   = File.read('./client.html')

run Proc.new { |env|
  if %w{/ /index.html}.include? env['REQUEST_URI']
    [200, {"Content-Type" => "text/html", "Cache-Control" => "no-cache"}, client]
  else
    content = JSON.parse(open(base_uri + env['REQUEST_URI']).read)['items'].map do |item|
      item['volumeInfo'].merge({ 'webReaderLink' => item['accessInfo']['webReaderLink'],
        'textSnippet' => item['searchInfo'] ? item['searchInfo']['textSnippet'] : nil })
    end
    [200, {"Content-Type" => "application/json", "Cache-Control" => "max-age=3600"}, JSON.generate(content)]
  end
}
