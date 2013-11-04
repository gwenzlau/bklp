class TestMailer < ActionMailer::Base

  def tagged_message
    mail(
      :subject => 'welcome',
      :to      => 'grant@youngbrokeanddangerous.com',
      :from    => 'thescoop@bookloop.co',
      :tag     => 'welcome-tag'
    )
  end

end