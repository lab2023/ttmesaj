ttmesaj
=======

Uygulama [http://www.ttmesaj.com/](http://www.ttmesaj.com/) servisini kullanarak kısa mesaj göndermektedir. Gönderilen kısa mesajları numara, mesaj ve statü (ttmesajdan dönen cevap) olarak db' ye kaydetmektedir.

```ruby
class Message < ActiveRecord::Base
  attr_accessible :body, :number

  validates :number, :body, :presence => true

  GSM_REGEX = /^5\d{9}$/

  validates :number, :format => {:with => GSM_REGEX}
  #before_create :send_message, :if => lambda{ Rails.env.production?}
  before_create :send_message

  def send_message
    client = Savon::Client.new("http://ws.ttmesaj.com/service1.asmx?WSDL")
    response = client.request :web, :send_single_sms, body: {
        "username" => "kullanici adi",
        "password" => "sifre",
        "numbers" => "0#{self.number}",
        "message" => "#{self.body}",
        "origin" => "origin",
        "sd" => "",
        "ed" => "" }

    if response.success?
      res = response.to_hash
      if res
        self.status = res[:send_single_sms_response][:send_single_sms_result]
      end
    end
  end
end
```

## Sorularınız İçin
[info@lab2023.com](mailto:info@lab2023.com) adresine mail gönderebilirsiniz.