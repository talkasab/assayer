require 'xml-object'

module ScenarioLoader
  def self.load_xml(xml_in, family)
    s_xml = XMLObject.new(xml_in)
    scenario = family.scenarios.build(:patient_age => s_xml.patient.age.to_i, :patient_sex => s_xml.patient.sex)
    # s_xml.uuid
    index_exam = s_xml.index_exam
    scenario.exam_description = index_exam.exam_description
    scenario.exam_clinical_history = index_exam.clinical_history 
    scenario.exam_comment = index_exam.comments if index_exam.respond_to?(:comments)
    scenario.exam_report = index_exam.report
    scenario.save!
    s_xml.medical_record_items.each do |item|
      # item.id
      scenario.items.create(:days_from_index => item.days_from_index, :item_type => item.type.downcase.to_sym,
                            :description => item.description, :report => item.report)
    end
    scenario
  end
end
