Rails.application.routes.draw do
  root :to => "site/home#index"

  get '/site/home/search'
  post '/site/home/search'

end
