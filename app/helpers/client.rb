helpers do

def current_client
  @current_client ||= @client = Twilio::REST::Client.new
end

def four_letter_words
  @four_letter_words ||= JAPI::Trebek.category(51).clues
end

end
