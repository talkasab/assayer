require 'xml-object'

module ScenarioLoader
  def self.load_scenario_xml(xml_in)
    scenario = XMLObject.new(xml_in)
    # scenario.uuid
    # scenario.patient.age
    # scenario.patient.sex
    index_exam = scenario.index_exam
    # index_exam.exam_description
    # index_exam.clinical_history
    # index_exam.comments
    # index_exam.report
    scenario.medical_record_items.is_a?(Array) or fail "Only one medical record item? Surely not."
    scenario.medical_record_items.each do |item|
      # item.id
      # item.days_from_index
      # item.type
      # item.description
      # item.report
    end
  end
end
