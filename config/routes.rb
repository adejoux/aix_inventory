# -*- encoding : utf-8 -*-
AixInventory::Application.routes.draw do
    


  devise_for :users
  
  resources :users do
    member do
      get :customer
    end
  end
  
  resources :uploads do
    member do
      get :import
      get :view_logs
    end
  end

    resources :firmwares
  
  get "alerts/san_alerts"
  get "alerts/aix_alerts"

  resources :san_alerts
  
  get "hardwares/index"

  get "statistics/general"
  
  get "statistics/customer"
  
  get "statistics/render_stats"
  
  get :contacts, to: "contacts#index"

  resources :servers, :only => [:index] 

  resources :san_infras, :only => [:index, :show] do
    collection do
      post :search, to: 'san_infras#index'
      get :view_wwpns, to:'san_infras#view_wwpns'
    end
  end
  
  resources :servers, :only => [:edit, :update, :show] do
    collection do
      post :search, to: 'servers#index' 
      get :quick_search, to:'servers#quick_search'
    end
  end

  resources :hardwares, :only => [:index, :show] do
    collection do
      post :search, to: 'hardwares#index' 
    end
  end

  resources :switch_ports, :only => [:index, :show] do
    collection do
      post :search, to: 'switch_ports#index' 
    end
  end

  resources :lparstats, :only => [:index] do
    collection do
      post :search, to: 'lparstats#index' 
    end
  end

  resources :aix_alerts
  root to: 'statistics#general'
end
