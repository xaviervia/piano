# -*- encoding : utf-8 -*-
module Piano
  class Base
    get '/' do
      @data = data_for 'index'
      fetch :index
    end

    get %r{/(.+?).css$} do |something|
      content_type :css
      fetch something, :sass
    end

    get %r{/(.+?).js$} do |something|
      content_type :js
      fetch something, :coffee
    end

    get '/*' do
      something = request.path[1..(request.path.length-1)]
      @data = data_for something
      fetch something
    end
  end
end
