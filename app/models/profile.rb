class Profile < ActiveRecord::Base
  belongs_to :profilable, :polymorphic => true
  mount_uploader :avatar, ImageUploader

  after_create :generate_avatar

  def generate_avatar
    if self.avatar.blank?
      token = SecureRandom.urlsafe_base64(32, false)
      blob = RubyIdenticon.create(token, background_color: 0xffffffff, square_size: 30, grid_size: 6)
      tempfile = Tempfile.new ['avatar', 'jpg']
      tempfile.binmode
      tempfile.write(blob)
      upload = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: '1')
      self.avatar = upload
    end
  end
end
