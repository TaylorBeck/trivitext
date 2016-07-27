helpers do

def current_client
  @current_client ||= @client = Twilio::REST::Client.new
end

def four_letter_words
  @four_letter_words ||= JAPI::Trebek.category(51).clues
end

def twilio_response(message)
  # send sms response back to player
  response = Twilio::TwiML::Response.new do |r|
    r.Message message
  end

  # render instructions for Twilio as XML
  response.text 
end

end
