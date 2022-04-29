Rails.application.routes.draw do

  scope(:path => '/api') do

    resources :users do

      collection do
        post :login
      end

    end

  end
end
