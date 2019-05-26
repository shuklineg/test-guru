Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, path: :gurus,
                     path_names: { sign_in: :login, sign_out: :logout },
                     controllers: { registrations: :registrations }

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member  do
      get :result
      post :gist
    end
  end

  resources :feedbacks, only: %i[new create]

  namespace :admin do
    root 'tests#index'

    resources :badges

    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: %i[show index]
      end
    end

    resources :gists, only: %i[index]
  end
end
