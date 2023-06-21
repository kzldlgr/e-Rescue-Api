Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # user sign_up
      post '/sign_up' => 'user#sign_up'
      
      # user sign_in
      post '/sign_in' => 'auth#sign_in'
    end
  end
end
