class Piano
  get "/" do
    @data = data_for "index"
    try_haml "index"
  end
  
  get %r{/(.+?).css$} do |something|
    content_type :css
    sass something
  end
  
  get %r{/(.+?).js$} do |something|
    content_type :js
    coffee something
  end
  
  get "/*" do 
    something = request.path[1..(request.path.length-1)]
    @data = data_for something
    try_haml something
  end
end