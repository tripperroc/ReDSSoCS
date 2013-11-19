class ResponderMailer < ActionMailer::Base
  default from: 'cmh@cs.rit.edu'

  def thank_you_email (recipients)
    @email_address = recipients[:email_address]
    @invitation_url = recipients[:invitation_url]
    mail(:to => @email_address, :subject => 'Thank you')
  end
end
