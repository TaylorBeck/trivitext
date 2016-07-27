post '/send_sms' do

  if params[:to] # request coming with query string
    to = params[:to] 
    phone_number = "+#{to}".gsub(/\s+/, '') 
  elsif params['to'] # request coming from Form submit
    to = params['to']
    phone_number = '+1' + to.gsub(/\D/, '') unless params[:to]
  end

  user = User.find_or_create_by!(phone_number: phone_number)
  
  # for any possible trivia question
  # clue = JAPI::Trebek.random.first 
  clue = four_letter_words.sample

  Clue.create!(
    question: clue.question,
    answer: clue.answer,
    category: '4-letter words',
    user: user
    )

  message = clue.question

  # send out twilio message
  current_client.messages.create(
    from: ENV['TWILIO_GAME_NUMBER'],
    to: to,
    body: message
    )
end

post '/receive_sms' do
  content_type 'text/xml'

  user_message = params['Body']
  from_number = params['From']

  user = User.find_by(phone_number: from_number)
  
  if user 
    if user_message.casecmp('stats')

      response = Twilio::TwiML::Response.new do |r|
        r.Message "You have #{user.points} points!"
      end
      response.text

    elsif user_message.casecmp('play again')
      redirect "/send_sms?to=#{from_number}"

    elsif user_message.casecmp(user.clues.last.answer.downcase)
      message = 'Correct!'

      current_client.messages.create(
        from: ENV['TWILIO_GAME_NUMBER'],
        to: from_number,
        media_url: 'http://i.imgur.com/Orfey1R.jpg'
        )

      user.update(points: user.points + 10)
    else
      message = 'Incorrect! Try again.'
    end
  end

  # send sms response back to player
  response = Twilio::TwiML::Response.new do |r|
    r.Message message
  end

  # render instructions for Twilio as XML
  response.text
end
