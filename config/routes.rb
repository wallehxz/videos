#coding=utf-8
Rails.application.routes.draw do

  match 'just/dashboard', to: 'administer/columns#index',via: :get, as: :dashboard
  match 'just/sign_in', to: 'administer/sessions#admin_sign_in',via: :get, as: :admin_sign_in
  match 'just/sign_out', to: 'administer/sessions#admin_sign_out',via: :get, as: :admin_sign_out
  post 'just/admin_login', to: 'administer/sessions#admin_sign_login', as: :admin_login
  match 'just' => redirect('/just/dashboard'), via: :get
  namespace :administer, path:'/just' do
    resources :columns
  end

  devise_for :users, controllers:{
       sessions: 'users/sessions',
       registrations: 'users/registrations',
       passwords: 'users/passwords'
   }
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new'
    get 'sign_out', to: 'users/sessions#destroy'
    get 'pass_forgot', to: 'users/passwords#new'
    post 'sign_login', to: 'users/sessions#create'
  end
  root 'welcome#index'

end
