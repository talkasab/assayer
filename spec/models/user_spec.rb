require 'spec_helper'

describe User do
  let!(:randy) { Factory.create(:user) }
  specify { User.first.should == randy }
  specify { User.count.should == 1 }

  # Associations
  it { should have_many(:ratings) }
  it { should have_many(:assignments) }
  it { should have_many(:scenario_families).through(:assignments) }
  it { should have_many(:scenario_statuses) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
end
