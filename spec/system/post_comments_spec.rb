require 'rails_helper'

RSpec.describe 'PostCommentsControllerのシステムテスト', type: :system do
  let! (:user) {create(:user)}
  let! (:post) {create(:post,user: user)}
  let! (:comment) {create(:post_comment,post: post,user: user)}
   
  before do
    sign_in user
    visit post_path(post)
  end

 describe 'コメント投稿のテスト' do
  context '有効なコメント' do
    it 'コメントが投稿できる' do
      fill_in 'コメントをここに', with: '新しいコメントです。'
      click_button '送信'
      expect(page).to have_content 'コメントが追加されました。'
      expect(page).to have_content '新しいコメントです。'
    end
  end

  context '無効なコメント' do
    it '空のコメントを投稿できない' do
      fill_in 'コメントをここに', with:  ''
      click_button '送信'
      expect(page).to have_content 'コメントの追加に失敗しました。'
    end
  end
end

describe 'コメント削除のテスト' do
  it 'コメントを削除できる' do
    expect(page).to have_content comment.comment
    click_link '削除'
    expect(page).to have_content 'コメントが削除されました。'
    expect(page).not_to have_content comment.comment
  end
end
end
