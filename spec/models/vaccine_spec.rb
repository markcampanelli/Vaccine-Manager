require 'spec_helper'

describe Vaccine do
  
  before(:each) do
    @attr = {
      name: "Hepatitis B",
      cdc_name: "HepB"
    }
  end

  it "should create a new instance given valid attributes" do
    Vaccine.create!(@attr)
  end
  
  describe "doses associations" do

    before(:each) do
      @vaccine = Vaccine.create(@attr)
    end

    it "should have a doses attribute" do
      @vaccine.should respond_to(:doses)
    end
  end

end
