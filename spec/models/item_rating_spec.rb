require 'spec_helper'

describe ItemRating do
  let!(:rating) { Factory.create(:item_rating) }

  # Associations
  it { should belong_to(:rater) }
  it { should belong_to(:item) }
  specify { rating.item.should be_a_kind_of(MedicalRecordItem) }
  specify { rating.item.scenario.should be_a_kind_of(Scenario) }

  # Validations
  it { should validate_presence_of(:rater) }
  it { should validate_presence_of(:item) }
  it { should validate_uniqueness_of(:rater_id).scoped_to(:item_id) }
  it { should validate_presence_of(:rating) }
  it { should validate_numericality_of(:rating) }
  it { [-1, 3.2, 6, 4].each {|n| should_not allow_value(n).for(:rating) } }
  it { [0, 1, 2, 3].each {|n| should allow_value(n).for(:rating) } }
end

