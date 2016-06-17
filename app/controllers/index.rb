get '/' do
  @users = User.order(points: :desc)
  erb :index
end
