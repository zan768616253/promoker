class ContactMailer < ActionMailer::Base
  default from: Settings.from.service.user_name
  self.smtp_settings = {
  	:address => Settings.smtp.address,
    :port => Settings.smtp.port,
    :domain  => Settings.smtp.domain,
    :authentication => Settings.smtp.authentication,
    :user_name => Settings.from.service.user_name,
    :password => Settings.from.service.password,
    :ssl => true
  }
  def contact_email(contact)
  	@contact = contact
    mail(to: Settings.admin_emails, subject: "新的联系信息")
  end
end
