require 'twilio-ruby'

class Takeaway

  attr_accessor :total
  
  ACCOUNT_SID = 'ACc876bf97e06abe147e5ed97136053bbf' 
  AUTH_TOKEN = '5fb0f7df1e68952d5a610c11f5b5078d'

  def initialize
    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end  

  def menu
    {  
      fish_and_chips: 7,
      bangers_and_mash: 7,
      shephards_pie: 8  
    }
  end

  def order(dishes, payment)
    @total = dishes.inject(0) { |sum, (dish,quantity)| sum + menu[dish] * quantity }   
    raise "You still owe me money!" unless payment == total 
    send_text
  end

  def send_text
    time = Time.now + 3600
    @client.account.sms.messages.create(
      :from => "+441183100861",
      :to => "+447921197921",
      :body => "Thank you! Your order was placed and will be delivered before #{time}"
    )
  end  
 
end

