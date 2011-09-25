require 'spec_helper'

describe ManagerController do
  
  render_views
  
  describe "GET 'timetable'" do
    it "should be successful" do
      get 'timetable'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'timetable'
      response.should have_selector("title", :content => "Vaccine Manager: Schedule and Record")
    end
  end

end
