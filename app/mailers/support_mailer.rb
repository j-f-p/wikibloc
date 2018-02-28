class SupportMailer < ApplicationMailer
    default from: "emailreel@gmail.com"
    
    def test_mail
        mail(to: "emailreel@gmail.com", subject: "Test EMail")
    end
end
