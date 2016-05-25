#coding=utf-8
Rails.application.routes.draw do

  resources :comments
  match '/playing/(:tv_code).html',to: 'welcome#playing', via: :get, as: :video_playing
  match '/channel/:english',to: 'welcome#channel', via: :get, as: :video_channel
  match '/videos/get_channel_more',to: 'welcome#get_channel_more', via: :get
  match '/videos/get_index_more',to: 'welcome#get_index_more', via: :get
  match '/v_show/(:youku_url)',to: 'welcome#interim', via: :get, as: :youku_play
  match '/feed',to: 'welcome#feed', via: :get, as: :feed, defaults: { format: :xml }
  match '/channel/:english/feed',to: 'welcome#feed', via: :get, as: :channel_feed, defaults: { format: :xml }
  match 'zhang/dashboard', to: 'administer/dashboard#index',via: :get, as: :dashboard
  match 'zhang/:english/videos', to: 'administer/dashboard#channel',via: :get, as: :channel
  match 'zhang/users', to: 'administer/dashboard#users',via: :get, as: :users
  match 'zhang/search', to: 'administer/dashboard#search',via: :get, as: :search
  match 'zhang/role_set', to: 'administer/dashboard#role_control',via: :get, as: :role_set
  match 'zhang/columns', to: 'administer/columns#index',via: :get, as: :columns
  match 'zhang/set_skin', to: 'administer/dashboard#set_skin_style',via: :get, as: :set_skin
  match 'zhang/import/:column_id', to: 'administer/columns#import_videos',via: :get, as: :import_column_video
  match 'zhang/create/import', to: 'administer/columns#create_csv_data',via: :post, as: :create_import_video
  match 'zhang/sign_in', to: 'administer/sessions#admin_sign_in',via: :get, as: :admin_sign_in
  match 'zhang/sign_out', to: 'administer/sessions#admin_sign_out',via: :get, as: :admin_sign_out
  match 'zhang/files', to: 'administer/seven_cattle#index',via: :get, as: :files
  match 'zhang/files/new', to: 'administer/seven_cattle#new',via: :get, as: :new_file
  match 'zhang/files/edit', to: 'administer/seven_cattle#edit',via: :get, as: :edit_file
  match 'zhang/files/delete', to: 'administer/seven_cattle#destroy',via: :get, as: :delete_file
  match 'zhang/files/create', to: 'administer/seven_cattle#create',via: :post, as: :create_file
  match 'zhang/files/update', to: 'administer/seven_cattle#update',via: :post, as: :update_file
  post 'zhang/admin_login', to: 'administer/sessions#admin_sign_login', as: :admin_login
  match 'zhang' => redirect('/zhang/dashboard'), via: :get
  match '/my/avatar',to: 'users/profile#new_avatar', via: :get, as: :new_avatar
  match '/my/profile',to: 'users/profile#profile', via: :get, as: :profile
  match '/create/avatar',to: 'users/profile#create_avatar', via: :post, as: :create_avatar
  match '/update/profile',to: 'users/profile#update_profile', via: :post, as: :update_profile
  match '/video/comment', to: 'comments#create', via: :post
  match '/video/comment/vote', to: 'comments#vote', via: :get
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

  namespace :api do
    get 'echo_msg' => 'we_chat#echo_get_msg'
    post 'echo_msg' => 'we_chat#echo_post_msg'
  end

end
