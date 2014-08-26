require 'spec_helper'

feature 'Blog管理' do
  scenario 'Blogの新規作成時にtitleを入力しなかったらエラーが発生すること' do
    visit blogs_path
    click_link 'New Blog'
    expect {
      click_button 'Create Blog'
    }.not_to change(Blog, :count)
    expect(page).to have_content 'error'
    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Blogの新規作成時にtitleを入力したらデータが保存され閲覧画面に遷移すること' do
    title = 'いぬいぬブログ'
    visit blogs_path
    click_link 'New Blog'
    expect {
      fill_in 'Title', with: title
      click_button 'Create Blog'
    }.to change(Blog, :count).by(1)
    expect(current_path).to eq blog_path(Blog.where(title: title).first)
    expect(page).to have_content 'Blog was successfully created.'
  end
end