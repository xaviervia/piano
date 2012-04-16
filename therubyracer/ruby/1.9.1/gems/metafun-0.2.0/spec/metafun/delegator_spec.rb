require "metafun/delegator"

describe Metafun::Delegator do
  describe "#delegate" do
    it "should complain if the first argument is nil or something" do
      obj = mock "object"
      obj.extend Metafun::Delegator
      expect { obj.delegate 
      }.to raise_error ArgumentError
    end
    
    it "should define a new method in the Singleton class of self" do
      obj     = mock "object"
      target  = mock "target"
      obj.extend Metafun::Delegator
      obj.delegate target, :greet
      obj.should respond_to :greet
    end

    context "the target has an implementation of the message" do
      before do 
        @target = mock "target"
        @target.stub( :greet ).and_return "Hi!"
      end
      
      it "should return the same the message called on the target and on self" do
        obj = mock "self"
        obj.extend Metafun::Delegator
        obj.delegate @target, :greet
        obj.greet.should == @target.greet
      end
      
      it "should have local access to the target's properties"
      
      it "should redirect arguments to the target"
      
      it "should redirect blocks to the target"
    end
    
    it "should do fine on multiple method calls"
  
    it "should be injected in Object" do # This is calling for a Feature!
      obj = Object.new
      obj.should respond_to :delegate
    end
    
    it "should be the :delegate from Metafun::Delegator which is in Object" do
      obj = Object.new
      obj.method( :delegate ).owner.should == Metafun::Delegator
    end
  end
end
