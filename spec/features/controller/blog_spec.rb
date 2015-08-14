require 'rails_helper'
describe 'Test User Blog', :type => :controller do
  before :each do
    @user = User.create!(:email => 'user1@example.com', :password => '123456789')
    @blog = Blog.create!(:title => 'Sample test blog', :description => 'Simple description', :user_id => @user.id)
  end

  it 'It should visit blog index page' do
    visit '/blogs'
    expect(page).to have_content 'Listing Blogs'
    expect(page).to have_content @blog.title.to_s
  end

end