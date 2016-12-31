Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :users, only: [:show]
    root to: redirect('/supriyan')
    mount Thredded::Engine => '/'
  end

  root to: redirect('/users/sign_in')
end
