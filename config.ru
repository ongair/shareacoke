require_relative 'share.rb'
require 'rack-livereload'

use Rack::LiveReload
run Share::API