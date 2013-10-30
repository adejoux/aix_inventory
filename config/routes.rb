# -*- encoding : utf-8 -*-
AixInventory::Application.routes.draw do

  resources :reports

  match "/reports/server_search/:id" => "reports#show", as: "server_search_report", :via => [:post]

  resources :import_reports

  resources :activities

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :users

  resources :uploads do
    member do
      get :import
      get :view_logs
    end
  end

  get "alerts/san_alerts"
  get "alerts/aix_alerts"

  resources :san_alerts

  get "statistics/general"

  get "statistics/customer"

  get "statistics/render_stats"

  get :contacts, to: "contacts#index"

  resources :aix_alerts
  root to: 'statistics#general'

end
