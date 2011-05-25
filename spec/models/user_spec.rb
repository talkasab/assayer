require 'spec_helper'

describe User do
  let!(:randy) { Factory.create(:user) }

  specify { User.first.should == randy }
  specify { User.count.should == 1 }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
end
