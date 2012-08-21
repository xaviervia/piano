# encoding: utf-8

# Refer https://github.com/padrino/padrino-framework/issues/857
module Tilt
  class CoffeeScriptTemplate < Template
    alias_method :original_prepare, :prepare

    def prepare
      @data.force_encoding 'UTF-8'
      original_prepare
    end
  end
end