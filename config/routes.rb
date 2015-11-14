#coding=utf-8
Rails.application.routes.draw do

  root 'home#index'
  get 'admin/sign_up' => 'admin/sessions#sign_up'
  get 'admin/users' => 'admin/channels#users'
  get 'channel/:english' => 'home#channel', as: :channel
  get 'private/Loving' => 'home#av_channel'
  get 'playing/:youku_id' => 'home#playing', as: :playing
  get 'video/get_more' => 'home#get_more'
  get 'v_show/:id' => 'home#youku_play'
  get 'fucking/:id' => 'home#av_play',as: :fucking
  get 'video/get_channel_more' => 'home#get_channel_more'
  get 'admin'=> 'admin/channels#index'
  get 'admin/dashboard' =>'admin/channels#index'
  get 'admin/released' =>'admin/channels#videos'
  get 'admin/search' =>'admin/channels#search'
  get 'admin/set_user_to_admin' =>'admin/channels#set_user_to_admin'
  get 'admin/style_option' => 'admin/sessions#style_option'

  get 'admin/qiniu' =>'admin/qiniu#index'
  get 'admin/youku' =>'admin/youku#index'

  resources :video_comments do #用户评论
    get 'anonymous_comment', on: :collection
    get 'user_comment', on: :collection
    get 'comment_vote', on: :collection
  end

  resources :user_details do  #用户信息
    get 'profile', on: :collection
    post 'profile_update', on: :collection
    get 'avatar', on: :collection
    post 'avatar_update', on: :collection
  end

  devise_for :users,
             controllers:{
                 sessions: 'users/sessions',
                 registrations: 'users/registrations',
                 passwords: 'users/passwords'
             }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new'
    get 'sign_out', to: 'users/sessions#destroy'
    get 'forgot_password', to: 'users/passwords#new'
  end

  namespace 'admin' do
    resources :youku do
      get 'upload', on: :collection
      post 'release_video', on: :collection
    end
    resources :channels do
      get 'update_youku', on: :collection
      resources :channel_videos
    end
    resources :sessions do
      post 'login', on: :collection
      get 'logout', on: :collection
    end
    resources :qiniu do
      get 'new', on: :collection
      get 'edit', on: :collection
      get 'destroy', on: :collection
      post 'create', on: :collection
      post 'update', on: :collection
    end
    resources :av_libs
  end

end
