require 'spec_helper'
describe Blog do

  before(:all) do
    @user1 = User.create!(:email => "user1test1#{Time.now.to_i}@example.com", :password => 'password')
    @user2 = User.create!(:email => "user2test2#{Time.now.to_i}@example.com", :password => 'password')
  end

  it 'should be a title in blog' do
    blog = Blog.create!(:title => 'title', :description => 'description', :user_id => "#{@user1.id}")
    blog.title = ''
    blog.should_not be_valid
  end

  it 'should be description in blog' do
    blog = Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user1.id}")
    blog.description = ''
    blog.should_not be_valid
  end

  it 'should return all unpublished blog' do
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user1.id}", :status => true)
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user1.id}")
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user1.id}")
    Blog.unpublished.count.should eq(2)
  end

  it 'should return all published blog of an user' do
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user1.id}", :status => true)
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user2.id}")
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user1.id}")
    Blog.user_published(@user1.id).count.should eq(1)
    Blog.user_published(@user2.id).count.should be 0
  end

  it 'should return all unpublished blog of an user' do
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user1.id}", :status => true)
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user2.id}")
    Blog.create!(:title => 'Title', :description => 'description', :user_id => "#{@user1.id}")
    Blog.user_unpublished(@user1.id).count.should eq(1)
    Blog.user_unpublished(@user2.id).count.should eq(1)
  end

end
