Rails.application.routes.draw do
  namespace :v1 do
    resources :predictions, only: :index
  end
end
