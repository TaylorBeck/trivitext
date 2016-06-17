get '/' do
  # @client = Twilio::REST::Client.new

#   @client.messages.create(
#   from: '+13479604136',
#   to: '+18583362522',
#   body: 'Hey there!'
# )

  erb :index
end

post '/send_sms' do
  to = params["to"]

  phone_number = "+1" + to.gsub(/\D/, '')

  user = User.find_or_create_by!(phone_number: phone_number)
  # clue = JAPI::Trebek.random.first
  clue = four_letter_words.sample

  Clue.create!(question: clue.question, answer: clue.answer, category: '4-letter words', user: user)

  message = clue.question

  current_client.messages.create(
    from: GAME_NUMBER,
    to: to,
    body: message
  )

  redirect '/'
end


post '/receive_sms' do
  content_type 'text/xml'

  user_guess = params["Body"]
  from_number = params["From"]

  user = User.find_by(phone_number: from_number)

  if user

    if user_guess.downcase == user.clues.last.answer.downcase
      message = 'Correct!'

      current_client.messages.create(
        from: GAME_NUMBER,
        to: from_number,
        media_url: 'http://i.imgur.com/Orfey1R.jpg'
      )

    else
      message = 'Incorrect! Try again.'
    end

    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end

    response.text
  end
end

