# -*- encoding : utf-8 -*-
AixInventory::Application.routes.draw do

  resources :reports

  match "/reports/load_form/:form" => "reports#load_form", as: "load_form_report", :via => [:get]
  match "/reports/server_search/:id" => "reports#show", as: "server_search_report", :via => [:post]

  resources :import_reports

  resources :activities

  resources :server_attributes


  get "wwpns/index"

  devise_for :users, :controllers => {:registrations => "users/registrations"}

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

  resources :san_infras, :only => [:index, :show] do
    collection do
      post :search, to: 'san_infras#index'
      get :view_wwpns, to:'san_infras#view_wwpns'
    end
  end

  resources :health_checks, :only => [:index, :show] do
    collection do
      post :search, to: 'health_checks#index'
    end
    member do
      get :history
    end
  end

  resources :server_attributes, :only => [:index, :show] do
    collection do
      post :search, to: 'server_attributes#index'
    end
    member do
      get :history
    end
  end

  resources :aix_alerts
  root to: 'statistics#general'

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.role == "admin" } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
