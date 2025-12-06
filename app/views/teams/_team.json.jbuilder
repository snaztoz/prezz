json.extract! team, :id, :name, :tenant_id, :created_at, :updated_at
json.url tenant_team_url(tenant, team, format: :json)
