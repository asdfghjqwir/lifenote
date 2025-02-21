require 'rails_helper'

RSpec.describe 'PostControllerのシステムテスト',type: :system do
  let!(:user){create(:user)}
  let!(:other_user){create(:user)}
  let!(:post){create(:post,user:user)}

  before do
    sign_in user
  end

  describe '投稿一覧ページのテスト' do
    before do
      create(:post, user: user)
       visit posts_path
    end

    it '投稿一覧ページが表示される' do
      expect(page).to have_content'フォローしている人の投稿一覧'
      expect(page).to have_link '詳細へ',href: post_path(post)
    end
  end

  describe '投稿詳細ページのテスト' do
    before {visit post_path(post)}

    it '投稿詳細ページが表示される' do
      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
  end
  
  describe '投稿作成のテスト' do
    before {visit posts_path}

    it '投稿が作成できる' do
      fill_in 'タイトル',with: 'テストタイトル'
      fill_in '内容',with: 'これはテスト投稿です。'
      click_button '投稿'

      expect(page).to have_content '投稿が保存されました。'
      expect(Post.last.title).to eq 'テストタイトル'
    end
  end

  describe '投稿編集のテスト' do
    before {visit edit_post_path(post)}

    it '投稿編集ページが表示される' do
      expect(page).to have_content '投稿編集'
      expect(page).to have_field 'タイトル', with: post.title
    end

    it '投稿が編集される' do
      fill_in 'タイトル',with: '編集後のタイトル'
      click_button '更新'

      expect(page).to have_content '投稿が更新されました。'
      expect(post.reload.title).to eq '編集後のタイトル'
    end
  end

  describe '投稿削除のテスト' do
    before { visit edit_post_path(post) }

    it '投稿を削除できる' do
      expect(page).to have_link('削除')
        click_link '削除'

      expect(page).to have_current_path(posts_path)
      expect(page).to have_content '投稿が削除されました。'
      expect(Post.find_by(id: post.id)).to be_nil
    end
  end
end