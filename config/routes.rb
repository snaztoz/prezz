# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|id/, defaults: { locale: "en" } do
    resources :tenants, only: %i[ show edit update ], path: "t" do
      resources :passwords, param: :token

      resource :session

      resources :shift_attendances, except: %i[ edit destroy ], path: "shift-attendances"

      # Created via command line or recurring job
      resources :shift_occurences, only: %i[ index show destroy ], path: "shift-occurences"
    end

    resources :shifts

    resources :team_shifts, path: "team-shifts"

    resources :teams

    resources :user_imports, except: %i[ edit update destroy ], path: "user-imports"

    resources :users, only: %i[ index ]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
