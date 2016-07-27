get '/' do
  @users = User.order_by_points
  erb :index
end
