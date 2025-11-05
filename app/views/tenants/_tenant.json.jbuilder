json.extract! tenant, :id, :name, :time_zone, :archived_at, :created_at, :updated_at
json.url tenant_url(tenant, format: :json)
