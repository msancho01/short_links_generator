Rails.application.routes.draw do
  resources :short_links, only: :create
  get ':token' => 'short_links#redirect'
  get '/' => 'short_links#index'
end
