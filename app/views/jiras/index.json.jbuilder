json.array!(@jiras) do |jira|
  json.extract! jira, :id, :issuekey, :projectname, :status
  json.url jira_url(jira, format: :json)
end
