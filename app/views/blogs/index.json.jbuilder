json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :description, :user_id, :status
  json.url blog_url(blog, format: :json)
end
