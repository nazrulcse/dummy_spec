json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :parent_id, :body, :blog_id
  json.url comment_url(comment, format: :json)
end
