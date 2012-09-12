# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Piano::Helpers::HTML do
  before do
    @controller = stub 'controller'
    @controller.extend Piano::Helpers::HTML
  end

  shared_examples_for 'any tag builder' do 
    it 'should serialize a hash of attributes as second argument'
    it 'should include a second argument string in the tag' do 
      tag = @controller.send @method, 'thedata', 'some="other" attr'
      tag.should include 'thedata'
      tag.should include 'some="other" attr'
    end
  end

  describe '#script' do
    before do 
      @method = :script
    end

    it 'should receive an argument and return the script tag' do 
      tag = @controller.script 'myscript.js'
      tag.should == "<script type='text/javascript' src='myscript.js'></script>"
    end

    it_behaves_like 'any tag builder'
  end

  describe '#style' do 
    before do 
      @method = :style
    end

    it 'should receive an argument and return the style tag' do 
      tag = @controller.style 'mystyle.css'
      tag.should == "<link rel='stylesheet' type='text/css' href='mystyle.css' />"
    end

    it_behaves_like 'any tag builder'
  end

  describe '#anchor' do
    it 'should receive the link and the text as arguments and return the tag'
  end
end
