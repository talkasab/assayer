class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Assocations
  has_many :ratings, :class_name => "ItemRating", :foreign_key => :rater_id, :inverse_of => :rater
  has_many :assignments, :class_name => "RatingAssignment", :foreign_key => :rater_id, :inverse_of => :rater
  has_many :scenario_families, :through => :assignments

  # Validations
  validates_presence_of :name

end
