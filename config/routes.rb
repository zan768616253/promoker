Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount RedisCaptcha::Engine => '/captcha', :as => :captcha
  mount Resque::Server, :at => "/resque"
  devise_for :users, :controllers => {:passwords => "passwords", :omniauth_callbacks => 'omniauth_callbacks', :registrations => "registrations"} do
    resources :passwords
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :tickets, :only => [:create,:show]
  resources :promotions
  
  resources :project_details, :only => [:create, :update]
  resources :projects do
    member do 
      get 'preview'
      post 'publish'
      post 'unpublish'
    end
  end

  resources :messages do
    collection do
      post 'mark'
    end
  end
  resources :events do
    resources :comments, :only => [:create,:destroy]
    member do
      post 'like'
      post 'unlike'  
    end    
  end
  resources :movies do
    resources :comments, :only => [:create,:destroy]
    member do
      post 'like'
      post 'unlike'  
    end
  end
  resources :users, :only => [:show, :edit, :update] do
    member do 
      post 'update_avatar'  
      post 'follow'
      post 'unfollow'  
    end
  end
  resources :articles, :only => [:show, :index] do
    resources :comments, :only => [:create,:destroy]
    member do
      post 'like'
      post 'unlike'  
    end
  end

  match '/simplified' => 'locale#simplified', :via => :get
  match '/traditional' => 'locale#traditional', :via => :get

  match '/marketing' => 'home#marketing', :via => :get
  match '/home' => 'home#index', :via => :get
  match 'contact' => 'home#contact', :via => :get
  root to: "home#welcome"
  get '*unmatched_route', :to => 'application#rescue_routing'

end
