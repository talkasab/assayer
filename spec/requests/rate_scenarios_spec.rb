require 'spec_helper'

describe "Rate a Scenarios" do
  setup_assayer_objects

  describe "GET /" do
    it "makes us log in" do
      visit '/'
      page.should have_content("sign in")
      fill_in "Email", :with => user.email
      fill_in "Password", :with => 'america'
      click_button "Sign in"
      page.should have_content("Current Assignments")
      click_link "Next Item"
      page.should have_content("Patient Scenario")
    end
  end
end
