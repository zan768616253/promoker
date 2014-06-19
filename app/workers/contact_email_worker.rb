class ContactEmailWorker
  @queue = :contact_mailer

  def self.perform(contact)
  	ContactMailer.contact_email(contact).deliver
  end
end