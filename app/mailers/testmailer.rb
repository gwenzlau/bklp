class TestMailer < ActionMailer::Base

  def tagged_message
    mail(
      :subject => 'welcome',
      :to      => 'grantwenzlau@gmail.com',
      :from    => 'thescoop@bookloop.co',
      :tag     => 'welcome-tag'
    )
  end

end