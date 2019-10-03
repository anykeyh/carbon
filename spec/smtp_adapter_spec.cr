require "./spec_helper"
require "email"

describe Carbon::SMTPAdapter do
  it "can use smtp adapter" do

    domain = ENV.fetch("SMTP_MAIL_DOMAIN")
    username = ENV.fetch("SMTP_MAIL_USERNAME")
    password = ENV.fetch("SMTP_MAIL_PASSWORD")
    port = ENV.fetch("SMTP_MAIL_PORT").to_i

    config = EMail::Client::Config.new(domain, port)
    config.use_auth(username, password)
    config.use_tls

    email = FakeEmail.new(
      from: Carbon::Address.new("noreply@ticketsdev.helpcube.net"),
      to: [Carbon::Address.new("yacine@helpcube.net")],
      subject: "I'm just testing to send an email",
      text_body: "This is a text body and it should work\nWell.",
      html_body: "This is the <strong>html version</strong> and should work<br>too."
      )
    adapter = Carbon::SMTPAdapter.new(config)
    adapter.deliver_now(email)
  end
end
