# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  name       :string(255)
#  location   :string(255)      default("village")
#  token      :string(255)
#  visit_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submission < ActiveRecord::Base
  attr_accessible :email, :name, :visit_id, :location, :token

  # callbacks
  before_save :postprocess_fields
  before_create :create_token

  # validations
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: ": mandatory field" },
  										format: { with: VALID_EMAIL_REGEX, message: ": invalid format. Should be: \"aaa@bbbb.ccc\"." }


  # associations
  belongs_to :visit
  has_one :feedback


  
  def self.to_csv
    columns = ["id", "email", "name", "location", "created_at"]
    CSV.generate do |csv|
      csv << columns
      all.each do |submission|
        csv << submission.attributes.values_at(*columns)
      end
    end
  end


  private

  	def postprocess_fields
      self.email.downcase!
      self.name = UserConfig::FALLBACK_USERNAME if self.name.blank?
  	end

  	

    def create_token
      used_tokens = Submission.pluck(:token)
      tok = SecureRandom.urlsafe_base64(6)[0..3]
      while used_tokens.include?(tok)
        tok = SecureRandom.urlsafe_base64(6)[0..3]
      end
      self.token = tok
    end

end
