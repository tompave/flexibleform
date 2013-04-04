# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  user_agent       :string(255)
#  operative_system :string(255)
#  os_version       :string(255)
#  ip_address       :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ActiveRecord::Base

  include ClientInfoHelper

  # attr_accessible :title, :body

  # callbacks

  # validations
  validates :user_agent, presence: true
  validates :operative_system, presence: true
  validates :os_version, presence: true
  validates :ip_address, presence: true

  # associations
  has_one :submission, dependent: :destroy

  
	def fill_properties(request = nil)
    if !request
      self.user_agent = "dummydata"
      self.operative_system = "dummydata"
      self.os_version = "dummydata"
      self.ip_address = "dummydata"
    else
      info_hash = fetch_info(request)
      self.user_agent = info_hash[:user_agent]
      self.operative_system = info_hash[:o_system]
      self.os_version = info_hash[:os_version]
      self.ip_address = find_ip_address(request)
    end
    return self
	end

end
