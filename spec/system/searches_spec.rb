require 'rails_helper'

RSpec.describe 'SearchsControllerのシステムテスト',type: :system do
  let!(:user) { create(:user,name: 'テストユーザー')}
  let!(:post) { create(:post,title: 'テスト投稿',content: 'これはテスト投稿です',user: user)}

  before do
    sign_in user
    visit root_path
  end 

  describe 'ユーザー検索のテスト' do
    before do
      select 'ユーザー',from: 'model'
      fill_in 'キーワード',with: 'テストユーザー'
      click_button '検索'
    end

    it '検索結果にユーザーが表示される' do
      expect(page).to have_content 'Users search for "テストユーザー"'
      expect(page).to have_link 'テストユーザー', href: user_path(user)
    end
  end

  describe '投稿検索のテスト' do
    before do
      select '投稿',from: 'model'
      fill_in 'キーワード',with: 'テスト投稿'
      click_button '検索'
    end

    it '検索結果が投稿に表示される' do
      expect(page).to have_content 'Posts search for "テスト投稿"'
      expect(page).to have_link 'テスト投稿',href: post_path(post)
      expect(page).to have_content'これはテスト投稿です'
    end
  end

  describe 'ユーザーの検索結果がない場合のテスト' do
    before do
      select 'ユーザー', from: 'model'
      fill_in 'キーワード',with: '存在しないユーザー'
      click_button '検索'
    end

    it '「No users found」と表示される' do
      expect(page).to have_content 'No users found.'
    end
  end
  
  describe '投稿の検索結果がない場合のテスト' do
    before do
      select '投稿',from: 'model'
      fill_in 'キーワード',with: '存在しない投稿'
      click_button '検索'
    end

   it '「No posts found」と表示される' do
    expect(page). to have_content 'No posts found.'
   end
  end
end

