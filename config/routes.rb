Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "forum_threads#index"
  
  resources :forum_threads, only: [:show, :new, :create, :edit, :update, :destroy] do
    put :pin_it, on: :member
    resources  :forum_posts, only: [:create] # Nested Resources dari forum_threads
  end
end


# :member hanya berlaku pada Action yang membutuhkan id, contohnya Edit, Update, Delete
# Jika ingin membuat sesuatu, yang Action awalnya tidak membutuhkan ID, gunakan :collection
# Method put digunakan untuk membuat routing yang mengupdate data di Database