# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tenants, only: %i[ show edit update ], path: "t" do
    resources :team_shifts

    resources :teams

    resources :passwords, param: :token

    resource :session

    resources :shift_attendances, except: %i[ edit destroy ]

    # Created via command line or recurring job
    resources :shift_occurences, only: %i[ index show destroy ]

    resources :shifts

    resources :user_imports, except: %i[ edit update destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
