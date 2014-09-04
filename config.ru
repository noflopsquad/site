require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
Sass::Plugin.options[:template_location] = 'public/css/sass'
Sass::Plugin.options[:css_location] = 'public/css'

use Sass::Plugin::Rack

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

run Rack::Directory.new("public")

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}