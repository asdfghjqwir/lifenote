require 'rails_helper'

RSpec.describe 'UsersControllerのシステムテスト',type: :system do
  let!(:user) {create(:user)}
  let!(:other_user) {create(:user)}

  before do
    sign_in user
  end

  describe 'ユーザー一覧ページのテスト' do
    before {visit users_path}

    it 'ユーザー一覧ページが表示される' do
      expect(page).to have_content 'ユーザーリスト'
      expect(page).to have_link '詳細へ',href: user_path(user)
    end
  end

  describe 'ユーザー詳細ページのテスト' do
    before {visit user_path(user)}

    it 'ユーザー詳細ページが表示される' do
      expect(page).to have_content user.name
      expect(page).to have_content '一言'
    end
  end

  describe 'ユーザー編集ページのテスト' do
    context '自分の編集' do
      before {visit edit_user_path(user)}

      it '編集ページが開ける' do
        expect(page).to have_content 'プロフィール'
        expect(page).to have_field 'user[name]',with: user.name
      end
      
      it '名前を編集できる' do
        fill_in 'user[name]', with: '新しい名前'
        click_button '更新'
        expect(page).to have_content 'プロフィールが更新されました。'
        expect(user.reload.name).to eq '新しい名前'
      end
    end

    context '他のユーザーの編集ページ' do
      before do
        sign_in other_user
        visit edit_user_path(user)
      end

      it 'リダイレクトされる'  do
        expect(page).to have_current_path user_path(other_user)
        expect(page).to have_content '他のユーザーの操作は許可されていません。'
      end
    end
  end

  describe 'ユーザー削除のテスト' do
    before { visit edit_user_path(user) }

    it '自分のアカウントを削除できる' do
      expect(page).to have_link('退会する')
      click_link '退会する'

      expect(page).to have_current_path root_path
      expect(page).to have_content 'アカウントが削除されました。'
      expect(User.find_by(id: user.id)).to be_nil
    end
  end
end



    