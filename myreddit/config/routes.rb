Rails.application.routes.draw do
  devise_for :users

  resources :posts do

    member do
        put "like", to: "posts#upvote"
        put "dislike", to: "posts#downvote"
      end

    resources :comments do
      #  do resources :subcomments  end

      member do
          put "like", to: "comments#upvote"
          put "dislike", to: "comments#downvote"
        end
      end


  end

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
