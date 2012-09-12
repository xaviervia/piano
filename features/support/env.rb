# -*- encoding : utf-8 -*-
require 'fast'

$LOAD_PATH << File.expand_path("../../../../lib", __FILE__)
require 'piano'
require 'piano/routes'

require 'rack/test'

def app
  Piano::Base
end

World Rack::Test::Methods