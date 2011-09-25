require 'spec_helper'

describe ManagerController do

  describe "GET 'timetable'" do
    it "should be successful" do
      get 'timetable'
      response.should be_success
    end
  end

end
