Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :users, only: [:show]
    mount Thredded::Engine => '/'
    root to: 'home#show'
  end

  root to: redirect('/users/sign_in')
end
