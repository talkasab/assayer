require 'spec_helper'

describe MedicalRecordItem do
  let!(:procedure) { Factory.create(:medical_record_item) }

  # Relationships
  it { should belong_to(:scenario) }
  it { should have_many(:ratings) }

  # Validations
  it { should validate_presence_of(:scenario) }
  it { should validate_presence_of(:days_from_index) }
  it { should validate_numericality_of(:days_from_index) }
  [-5, 12].each { |n| it { should allow_value(n).for(:days_from_index) } }
  [5.3, 6.7, 3.1415926].each { |n| it { should_not allow_value(n).for(:days_from_index) } }
  it { should validate_presence_of(:item_type) }
  [:rad, :opn, :ndo, :car, :mic].each { |n| it { should allow_value(n).for(:item_type) } }
  it "should choke on bad types" do
    [:dis, :nte, :foo, :bar, :baz].each do |bad_type| 
      expect { procedure.item_type = bad_type }.to raise_error(ArgumentError)
    end
  end
  it { should validate_presence_of(:report) }
end

