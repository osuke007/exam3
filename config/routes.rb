Rails.application.routes.draw do

  root 'top#index'



  resources :conversations do
    resources :messages
  end

  resources :topics, only: [:index, :new, :create, :edit, :update, :destroy] do
     collection do
       post :confirm
     end
  end

  devise_for :users, controllers: {
     registrations: "users/registrations",
     omniauth_callbacks: "users/omniauth_callbacks"
   }

   resources :users, only: [:index, :show]
   resources :relationships, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :topics do
    resources :comments

    collection do
      post :confirm
    end
  end
end
