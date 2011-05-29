class MedicalRecordItem < ActiveRecord::Base
  class Type < Struct.new(:code, :name, :description)
    @@codes = []
    @@types = {}
    @@type_list = []

    def self.[](code)
      return nil unless code.present?
      @@types[code.to_sym]
    end

    def self.codes
      @@codes.clone
    end

    def self.list
      @@type_list.clone
    end

    def to_sym
      code.to_sym
    end

    def ==(another_type)
      self.code == another_type.code if another_type.respond_to?(:code)
    end

    private
    def self.add(code, name, description = nil)
      @@codes << code.to_sym
      @@types[code.to_sym] = Type.new(code.to_s, name, description).freeze
      @@type_list << @@types[code.to_sym]
    end

    add(:rad, "Radiology", "Reports from radiology exams (X-rays, CT scans, MRIs).")
    add(:pat, "Pathology", "Pathology reports (surgical pathology, cytology, etc.).")
    add(:mic, "Microbiology", "Reports from the microbiology lab (Gram stains, cultures and sensitivities).")
    add(:ndo, "Endoscopy", "Reports from endoscopic exams.")
    add(:opn, "Operation", "Reports from operations/procedures.")
    add(:car, "Cardiology", "Reports from cardiology procedures (echocardiograms, EKGs, catheterizations).")
    # add(:dis, "Discharge Notes", "Report given on patient discharge from an admission.")
    # add(:nte, "Patient Notes", "All patient notes for office visits, calls, etc.")
    # add(:bbk, "Transfusion Notes", "Reports from the blook band (transfusions, type/screen, etc.).")
    # add(:gen, "Genetic Testing", "Reports from genetic analysis.")
  end

  def item_type 
    Type[self[:item_type]]
  end

  def item_type=(type)
    if type
      type_obj = Type[type] or raise ArgumentError, "Don't know about type #{type.inspect}"
      self[:item_type] = type_obj.code.to_s
    else
      self[:item_type] = nil
    end
  end
end
