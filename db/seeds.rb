# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
STDERR.puts "Reloading medical record items types."
MedicalRecordItemType.delete_all
MedicalRecordItemType.create([
  { :code => "RAD", :name => "Radiology", :description => "Reports from radiology exams (X-rays, CT scans, MRIs)." },
  { :code => "PAT", :name => "Pathology", :description => "Pathology reports (surgical pathology, cytology, etc.)." },
  { :code => "CAR", :name => "Cardiology", :description => "Reports from cardiology exams (EKGs, echo, catheterization)." },
  { :code => "CHM", :name => "Chemistry", :description => "Results from the chemistry lab." },
  { :code => "HEM", :name => "Hematology", :description => "Results from the hematology lab." },
  { :code => "IMM", :name => "Immunology", :description => "Results from immunological assays." },
  { :code => "MIC", :name => "Microbiology", :description => "Reports from the microbiology lab (Gram stains, cultures and sensitivities)." },
  { :code => "NDO", :name => "Endoscopy", :description => "Reports from endoscopic exams." },
  { :code => "OPN", :name => "Operative Notes", :description => "Reports from operations/procedures." },
  { :code => "DIS", :name => "Discharge Notes", :description => "Report given on patient discharge from an admission." },
  { :code => "NTE", :name => "Patient Notes", :description => "All patient notes for office visits, calls, etc." },
  { :code => "BBK", :name => "Transfusion Notes", :description => "Reports from the blook band (transfusions, type/screen, etc.)." },
  { :code => "GEN", :name => "Genetic Testing", :description => "Reports from genetic analysis." },
  { :code => "LMED", :name => "Outpatient Medications", :description => "Reports on outpatient medications." },
  { :code => "PMED", :name => "Inpatient Medications", :description => "Lists of inpatient medications (including reconciliation)." },
  { :code => "CMED", :name => "Active Medications", :description => "Currently ordered medications (for inpatients)." },
  { :code => "PROB", :name => "Problem List", :description => "Problem lists maintained in an EMR." },
  { :code => "HM", :name => "Health Maintenance", :description => "Health maintenance issues in an EMR." },
  { :code => "VTL", :name => "Vital Statistics", :description => "Demographic information regarding a patient." },
  { :code => "ALRG", :name => "Allergies", :description => "Allergy information on a patient." },
])
