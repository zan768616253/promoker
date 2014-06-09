Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user = "promoker"
  password == "QWLNgU7eqTYW"
end