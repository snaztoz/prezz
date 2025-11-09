json.extract! user_import, :id, :status, :file, :tenant_id, :created_at, :updated_at
json.url user_import_url(user_import, format: :json)
json.file url_for(user_import.file)
