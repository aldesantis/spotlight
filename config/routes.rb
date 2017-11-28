Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :pings, only: %i(create)
    end
  end

  scope '/webhooks' do
    post 'push', to: 'webhooks#push', as: :push_webhook
  end
end
