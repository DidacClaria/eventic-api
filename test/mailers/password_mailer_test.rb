require "test_helper"

class PasswordMailerTest < ActionMailer::TestCase
  test "password_mail" do
    mail = PasswordMailer.password_mail
    assert_equal "Password mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end