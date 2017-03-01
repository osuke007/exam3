Rails.application.routes.draw do

  root 'top#index'
  
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:index]

  devise_for :users, controllers: {
     registrations: "users/registrations",
     omniauth_callbacks: "users/omniauth_callbacks"
   }



  resources :topics, only: [:index, :new, :create, :edit, :update, :destroy] do
     collection do
       post :confirm
     end
  end

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
