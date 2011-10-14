require "piano/controllerloader"

describe Piano::ControllerLoader do
  describe ".folder" do
    context "there are some files in the folder" do
      before :all do      
        Dir.should_not exist "controllers"
        FileUtils.mkdir "controllers"
        File.open "controllers/demo.controller", "w" do |file|
          file.write <<-HOLA
          self.i_should_be_included = "I should be included"
          HOLA
        end
        
        File.open "controllers/another.rb", "w" do |file|
          file.write <<-HOLA2
          self.i_should_not_be_included = "I should not be included"
          HOLA2
        end
        
        FileUtils.mkdir "controllers/recursive"
        FileUtils.mkdir "controllers/recursive/very"
        File.open "controllers/recursive/very/demo2.controller", "w" do
          |file|
          file.write <<-HOLA3
          self.another_included = "Another included"
          HOLA3
        end
        Piano::ControllerLoader.folder "controller"
      end
      
      it "should include the demo file" do 
        self.i_should_be_included.should == "I should be included"
      end
      
      it "should not include the .rb file" do
        pending "Wait for it..." do
          self.i_should_not_be_include.should_not == "I should not be included"
        end
      end
      
      it "should include the in-folder file" do
        pending "Wait more for it..." do
          self.another_included.should == "Another included"
        end
      end
      
      after :all do
        FileUtils.rm_r "controllers"
      end
    end
  end
end