require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  # ユーザーAを作成しておく
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  # 作成者がユーザーAであるタスクを作成しておく
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

  before do
    # ログインする
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク' }
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_url
      fill_in '名称', with: task_name
      click_button '登録する'
      click_button '登録'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name) { '新規作成のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:task_name) { '' }

      it 'バリデーションエラーとなること' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do

      let(:login_user) { user_a }
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

       it 'ユーザーAが作成したタスクが表示されない' do
         # ユーザーAが作成したタスクの名称が表示されないことを確認
         expect(page).to_not have_content '最初のタスク'
       end

    end
  end

  describe '一覧画面での削除機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが削除されること' do
        page.accept_confirm 'タスク「最初のタスク」を削除します。よろしいですか？' do
          click_link '削除'
        end
        within '.alert' do
          expect(page).to have_content "タスク「最初のタスク」を削除しました。"
        end
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

  end

  describe '詳細画面での削除機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it 'ユーザーAが作成したタスクが削除されること' do
        page.accept_confirm 'タスク「最初のタスク」を削除します。よろしいですか？' do
          click_link '削除'
        end
        within '.alert' do
          expect(page).to have_content "タスク「最初のタスク」を削除しました。"
        end
      end
    end
  end

end
