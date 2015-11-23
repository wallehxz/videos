#coding=utf-8
Rails.application.routes.draw do

  get 'dashboard/index'

  match '/playing/(:tv_code).html',to: 'welcome#playing', via: :get, as: :playing
  match '/v_show/(:youku_url)',to: 'welcome#interim_play', via: :get, as: :youku_play
  match 'zhang/dashboard', to: 'administer/dashboard#index',via: :get, as: :dashboard
  match 'zhang/:english/videos', to: 'administer/dashboard#channel',via: :get, as: :channel
  match 'zhang/columns', to: 'administer/columns#index',via: :get, as: :columns
  match 'zhang/import/:column_id', to: 'administer/columns#import_videos',via: :get, as: :import_column_video
  match 'zhang/create/import', to: 'administer/columns#create_csv_data',via: :post, as: :create_import_video
  match 'zhang/sign_in', to: 'administer/sessions#admin_sign_in',via: :get, as: :admin_sign_in
  match 'zhang/sign_out', to: 'administer/sessions#admin_sign_out',via: :get, as: :admin_sign_out
  post 'zhang/admin_login', to: 'administer/sessions#admin_sign_login', as: :admin_login
  match 'zhang' => redirect('/zhang/dashboard'), via: :get
  namespace :administer, path:'/zhang' do
    resources :columns do
      resources :videos
    end
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
