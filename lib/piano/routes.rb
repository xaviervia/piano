module Piano
  class Base
    get "/" do
      @data = data_for "index"
      template "index"
    end
    
    get %r{/(.+?).css$} do |something|
      content_type :css
      template something, :sass
    end
    
    get %r{/(.+?).js$} do |something|
      content_type :js
      template something, :coffee
    end
    
    get "/*" do 
      something = request.path[1..(request.path.length-1)]
      @data = data_for something
      template something
    end
  end
end
