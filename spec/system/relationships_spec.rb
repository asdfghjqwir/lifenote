require 'rails_helper'

RSpec.describe 'RelationshipsControllerのシステムテスト',type: :system do
  let!(:user) {create(:user)}
  let!(:other_user) {create(:user)}

  before do
    sign_in user
    visit users_path
  end

  describe 'フォロー機能のテスト' do
    context 'ユーザーに対するフォロー' do
      it 'ユーザーをフォローできる' do
        within("tr",text: other_user.name) do
        click_link 'フォロー'
        end
        expect(page).to have_content 'フォロー解除'
        expect(user.following?(other_user)).to be true
      end
      
      it 'フォロー解除できる' do
        within("tr",text:other_user.name) do
        click_link 'フォロー'
        click_link 'フォロー解除'
        end
        expect(page).to have_content 'フォロー'
        expect(user.following?(other_user)).to be false
      end
    end
  end

  describe 'フォロー、フォロワー一覧のテスト' do
    before do
      user.follow(other_user)
    end

    it 'フォローしたユーザーがusers/indexに表示される' do
      visit users_path
      within("tr",text: other_user.name) do
      expect(page).to have_content other_user.name
      expect(page).to have_link 'フォロー解除'
    end
  end

    it 'フォロワーとして自分がusers/indexに表示される' do
      visit users_path
      within("tr",text: user.name) do
      expect(page).to have_content user.name
    end
  end
end
end