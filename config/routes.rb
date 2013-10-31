# -*- encoding : utf-8 -*-
AixInventory::Application.routes.draw do

  resources :reports

  match "/reports/report_search/:id" => "reports#show", as: "search_report", :via => [:post]
  match "/reports/:id/server_link/:name" => "reports#server_link", as: "server_link_report", :via => [:get]
  match "/reports/report_search/:id/server_link/:name" => "reports#server_link", as: "server_link_report", :via => [:get]
  match "/servers/:id/load_tab/:tab"  => "servers#load_tab", as: "load_tab_server", :via => [:get]

  resources :import_reports

  resources :activities

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :users

  resources :servers, :only => [:show, :edit]
  resources :uploads do
    member do
      get :import
      get :view_logs
    end
  end

  get "statistics/general"

  get "statistics/customer"

  get "statistics/render_stats"

  get :contacts, to: "contacts#index"

  root to: 'reports#index'

end
