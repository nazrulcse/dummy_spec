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

  it 'It should visit blog new page' do
    visit '/blogs/new'
    expect(page).to have_content 'New Blog'
  end

  it 'It should validate blog title' do
    visit '/blogs/new'
    within('#new_blog') do
      fill_in 'Description', :with => 'Sample Description'
      fill_in 'User', :with => @user.id
    end
    click_button 'Create Blog'
    expect(page).to have_content "Title can't be blank"
  end

  it 'It should validate blog description' do
    visit '/blogs/new'
    within('#new_blog') do
      fill_in 'Title', :with => 'Test Blog'
      fill_in 'User', :with => @user.id
    end
    click_button 'Create Blog'
    expect(page).to have_content "Description can't be blank"
  end

  it 'It should create a new blog and redirect to show page' do
    visit '/blogs/new'
    within('#new_blog') do
      fill_in 'Title', :with => 'Test Blog'
      fill_in 'Description', :with => 'Sample Description'
      fill_in 'User', :with => @user.id
    end
    click_button 'Create Blog'
    expect(page).to have_content 'Blog was successfully created'
  end

  it 'It should redirect to edit page' do
    visit "/blogs/#{@blog.id}/edit"
    expect(page).to have_content 'Editing Blog'
  end

  it 'It should update blog and redirect to show page' do
    visit "/blogs/#{@blog.id}/edit"
    new_title = 'This is new title'
    within('.edit_blog') do
      fill_in 'Title', :with => new_title
    end
    click_button 'Update Blog'
    expect(page).to have_content new_title.to_s
  end

  it 'It should delete blog and redirect to index page' do
    visit '/blogs'
    click_link "delete-blog-#{@blog.id}"
    expect(page).to have_content 'Blog was successfully destroyed'
  end

end