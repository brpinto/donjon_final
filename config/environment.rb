# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :user_name => Rails.application.credentials.sg_username,
    :password => Rails.application.credentials.sg_password,
    :domain => 'www.donjonsetcornichons.fr',
    :address => 'smtp.sendgrid.net',
    :port => 465,
    :authentication => :plain,
    :enable_starttls_auto => true
}
