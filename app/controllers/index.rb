get '/' do
  erb :index
end

post '/send_sms' do
  to = params["to"]

  p params

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

  if params["Body"] == 'stats'
    response = Twilio::TwiML::Response.new do |r|
      r.Message "You have #{user.points} points!"
    end

    response.text
  elsif params["Body"].downcase == 'new question'

  # NEED TO IMPLEMENT THIS
else

  if user

    if user_guess.downcase == user.clues.last.answer.downcase
      message = 'Correct!'

      current_client.messages.create(
        from: GAME_NUMBER,
        to: from_number,
        media_url: 'http://i.imgur.com/Orfey1R.jpg'
        )

      user.points += 10
    else
      message = 'Incorrect! Try again.'
    end

    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end

    response.text
  end
end
end


