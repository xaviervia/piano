require "mechanize"

module Environment
  def self.server
    "http://localhost:4567/"
  end
  
  module Setup
    def self.file donde, que
      File.open donde, "w" do |file|
        file.write que
      end
    end

    module SimpleController
      def self.setup 
        destroy
        
        FileUtils.mkdir "arena"
        FileUtils.mkdir "arena/controllers"
        Setup.file "arena/controllers/un.controller", "get '/' do 
            '#{expectation}'
          end"
      end
      
      def self.expectation
        "Hello!"
      end
      
      def self.url
        Environment.server
      end
      
      def self.destroy
        FileUtils.rm_r "arena" if Dir.exist? "arena"
      end
    end    
  end
end

module Mecha
  def self.go url
    @@page = agent.get url
  end
  
  def self.page
    @@page
  end

  def self.agent
    @@agent ||= Mechanize.new
  end
end 