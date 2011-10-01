require 'spec_helper'

describe Dose do
  
  before(:each) do
    @vaccine = Factory(:vaccine)
    @attr = { number: 1, admin_start_month: 0, admin_end_month: 0, admin_month: 0 }
  end
  
  it "should create a new instance given valid attributes" do
    @vaccine.doses.create!(@attr)
  end
  
  describe "vaccine associations" do

    before(:each) do
      @dose = @vaccine.doses.create(@attr)
    end

    it "should have a vaccine attribute" do
      @dose.should respond_to(:vaccine)
    end

    it "should have the right associated vaccine" do
      @dose.vaccine_id.should == @vaccine.id
      @dose.vaccine.should == @vaccine
    end
  end

end
