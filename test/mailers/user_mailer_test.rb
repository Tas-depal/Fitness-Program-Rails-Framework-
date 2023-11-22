require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome_mail" do
    mail = UserMailer.welcome_mail
    assert_equal "Welcome mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "send_otp" do
    mail = UserMailer.send_otp
    assert_equal "Send otp", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
