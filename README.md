# Trivitext
Trivitext lets you play Jeopardy on your phone via text messages. It utilizes Twilio to send and receive SMS and MMS messages, tracks the amount of points players earn on a leaderboard, and offers simple text commands like "stats" so you can instantly see your progress. Trivitext was born out of my love for all things trivia and Alex Trebek.

## Play Trivitext here:
[trivitext.herokuapp.com](https://trivitext.herokuapp.com)

## Instructions
1. Clone the repository to your local machine.
2. Open the project in your favorite text editor.
3. Add a '.env' file to the main project directory.
   * Include your own Twilio account information this new file.
    ![ENV Example](http://i.imgur.com/qgl6CKr.png) 
4. Run 'bundle install' to install all gems.
5. Run 'bundle exec rake db:create'.
6. Run 'bundle exec rake db:migrate'.
7. Run 'bundle exec shotgun' to start up the server.
8. Go to 'localhost:9393' (default port is 9393) in your browser to see the application.
9. Use a tool like [Ngrok](https://ngrok.com/) to create a private tunnel to your local machine for Twilio. If you do not do this, Twilio will not be able to send requests to your local server. Remember to point your Twilio number to the correct route.
 
You can alternatively host this project on Heroku and point your Twilio number towards that server:
![Twilio Routing Example](http://i.imgur.com/t9StnCS.png)
