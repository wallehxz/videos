#coding=utf-8
Rails.application.routes.draw do

  get 'welcome/index'

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
