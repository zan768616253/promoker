class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :tickets

  before_create :copy_name
  acts_as_voter

  def temp_access_token
    Rails.cache.fetch("user-#{self.id}-temp_access_token-#{Time.now.strftime("%Y%m%d")}") do
      SecureRandom.hex
    end
  end

  def copy_name
    self.name = self.nickname
  end 
  
end
