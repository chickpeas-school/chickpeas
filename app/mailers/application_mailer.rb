class ApplicationMailer < ActionMailer::Base
  default from: 'web@chickpeas.org'
  layout 'mailer'
end
