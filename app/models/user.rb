class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend OmniauthCallbacks
  # include RedisCaptcha::Model
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :sent_messages, :foreign_key => 'from_id', :class_name => "Message", :dependent => :destroy
  has_many :received_messages, :foreign_key => 'to_id', :class_name => "Message", :dependent => :destroy
  has_many :tickets, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  has_one :profile, :as => :profilable, :dependent => :destroy
  has_many :authorizations, :dependent => :destroy

  mount_uploader :avatar, ImageUploader

  # before_create :copy_name
  after_create :generate_avatar
  acts_as_taggable_on :roles
  acts_as_voter
  acts_as_followable
  acts_as_follower


  def admin?
    Settings.admin_emails.include?(self.email)
  end
  def password_required?
    (authorizations.empty? || !password.blank?) && super
  end

  def self.find_by_email(email)
    where(:email => email).first
  end

  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"]
    authorizations.create(:provider => provider , :uid => uid )
  end

  def bind?(provider)
    self.authorizations.collect { |a| a.provider }.include?(provider)
  end

  def temp_access_token
    Rails.cache.fetch("user-#{self.id}-temp_access_token-#{Time.now.strftime("%Y%m%d")}") do
      SecureRandom.hex
    end
  end

  # def copy_name
  #   self.name = self.nickname
  # end 

  def generate_avatar
    if self.avatar.blank?
      blob = RubyIdenticon.create(self.email, background_color: 0xffffffff, square_size: 30, grid_size: 6)
      tempfile = Tempfile.new ['avatar', 'jpg']
      tempfile.binmode
      tempfile.write(blob)
      upload = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: '1')
      self.avatar = upload
    end
  end
  
end
