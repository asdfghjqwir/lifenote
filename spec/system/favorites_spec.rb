require 'rails_helper'

RSpec.describe 'FovoritesControllerのシステムテスト',type: :system do
 let!(:user) {create(:user)}
 let!(:other_user) {create(:user)}
 let!(:post) {create(:post,user: other_user)}

  before do
    sign_in user
    visit post_path(post)
  end

  describe 'いいね機能のテスト' do
    context '投稿に対するいいね' do
    it '投稿にいいねできる' do
     click_link 'いいね'
     expect(page).to have_content 'いいね解除'
     expect(post.favorites.count).to eq(1)
     expect(post.favorited_by?(user)).to be true
    end
    
    it 'いいね解除できる' do
      click_link 'いいね'
      click_link 'いいね解除'
      expect(page).to have_content 'いいね'
      expect(post.favorites.count).to eq(0)
      expect(post.favorited_by?(user)).to be false
    end
  end

  context 'お気に入り投稿一覧ページ' do
    it 'いいねした投稿が表示される' do
      click_link 'いいね'
      visit favorites_path
      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
  end
end
end
 
  