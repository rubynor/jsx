require 'spec_helper'
require 'pathname'

describe Jsx::Platform::Base do
  
  context "Platform::Base class" do
    before do
      @cs4 = fixture_path+'cs4.jsx'
      @osx = Jsx::Platform::OSX.new @cs4
      @body = File.open(@cs4).read
    end

    it "should be array with appname and version" do
      expect(@osx.find_target(@body)).to eql ['indesign','6.0']
    end
  end

  context "each version" do
    
    before do
      @cs4 = fixture_path+'cs4.jsx'
      @osx = Jsx::Platform::OSX.new @cs4
    end

    it "should be ['indesign','5.0']" do
      expect(@osx.find_target("#target indesign-5.0")).to eql ['indesign','5.0']
    end

    it "should be ['indesign','6.0']" do
      expect(@osx.find_target("#target InDesign-6.0")).to eql ['indesign','6.0']
    end

    it "should be ['indesign','7.0']" do
      expect(@osx.find_target("#target \"InDesign-7.0\"")).to eql ['indesign','7.0']
    end

    it "should be ['indesign','7.5']" do
      expect(@osx.find_target("#target \"InDesign 7.5\"")).to eql ['indesign','7.5']
    end

    it "should be ['indesign','8.0']" do
      expect(@osx.find_target("#target 'indesign 8.0'")).to eql ['indesign','8.0']
    end

    it "should be ['indesign','9.2']" do
      expect(@osx.find_target("#target 'indesign 9.2'")).to eql ['indesign','9.2']
    end

    it "should be ['indesign','0.0']" do
      expect(@osx.find_target("#target 'indesign 0.0'")).to eql ['indesign','0.0']
    end

    it "should be ['indesign']" do
      expect(@osx.find_target("#target indesign")).to eql ['indesign']
    end

  end

end
