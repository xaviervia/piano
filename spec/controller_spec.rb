require "piano/controllerloader"

describe Piano::ControllerLoader do
  context "there are some files in the folder" do
    before :all do      
      if Dir.exist? "controllers"
        puts "#{File.expand_path('controllers')} should not exist for this to run"
        Process.exit!
      end
      
      FileUtils.mkdir "controllers"
      File.open "controllers/demo.controller", "w" do |file|
        file.write <<-HOLA
        def Piano.demo_was_loaded; true; end
        HOLA
      end
      
      File.open "controllers/another.rb", "w" do |file|
        file.write <<-HOLA2
        def Piano.wrong!; true; end
        HOLA2
      end
      
      FileUtils.mkdir "controllers/recursive"
      FileUtils.mkdir "controllers/recursive/very"
      File.open "controllers/recursive/very/demo2.controller", "w" do
        |file|
        file.write <<-HOLA3
        def Piano.another_was_loaded; true; end
        HOLA3
      end
    end
    
    describe ".folder" do
      context "files" do
        before :all do
          Piano::ControllerLoader.folder "controllers"
        end
        
        it "should include the demo file" do 
          Piano.demo_was_loaded.should be
        end
        
        it "should not include the .rb file" do
          expect { Piano.wrong!
          }.to raise_error(NoMethodError)
        end
        
        it "should include the in-folder file" do
          Piano.another_was_loaded.should be
        end
      end
      
      it "should not change $LOAD_PATH" do
        expect { Piano::ControllerLoader.folder "controllers"
        }.to change{ $LOAD_PATH.length }.by(1)
      end
    end
    
    describe ".recursive" do
      it "should contain the path to the demo file" do
        flag = false
        Piano::ControllerLoader.recursive "controllers" do |item|
          flag = true if item == "controllers/demo"
        end
        flag.should be_true
      end
      
      it "should not contain the path to the .rb file" do
        flag = false
        Piano::ControllerLoader.recursive "controllers" do |item|
          flag = true if item == "controllers/another"
        end
        flag.should_not be_true
      end
      
      it "should contain the path to the indented demo file" do
        flag = false
        Piano::ControllerLoader.recursive "controllers" do |item|
          flag = true if item == "controllers/recursive/very/demo2"
        end
        flag.should be_true
      end
    end
    
    after :all do
      FileUtils.rm_r "controllers"
    end
  end
end