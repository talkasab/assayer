require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ApplicationHelper do
  describe "#days_from_to_text" do
    it "calls positive input after" do
      helper.days_from_to_text(2).should == "2 days after"
      helper.days_from_to_text(1).should == "1 day after"
    end

    it "calls negative input before" do
      helper.days_from_to_text(-2).should == "2 days prior"
      helper.days_from_to_text(-1).should == "1 day prior"
    end

    it "calls zero input the same day" do
      helper.days_from_to_text(0).should == "Same day"
    end
  end
end
