require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do
  let(:task) { create(:task,
                      name: "メイラーspecの作成",
                      description: "送信したメールの確認")}

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
    part.body.raw_source
  end

  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
    part.body.raw_source
  end

  describe "#creation_email" do
    let(:mail) { TaskMailer.creation_email(task) }

    it "想定通りメールが生成されていること" do
      # Header
      aggregate_failures do
        expect(mail.subject).to eq('タスク作成完了メール')
        expect(mail.to).to eq(['register@yuta-u.com'])
        expect(mail.from).to eq(['taskleaf@example.com'])
      end

      # text形式の本文
      aggregate_failures do
        expect(text_body).to include('以下のタスクを作成しました')
        expect(text_body).to include('メイラーspecの作成')
        expect(text_body).to include('送信したメールの確認')
      end

      # html形式の本文
      aggregate_failures do
        expect(html_body).to include('以下のタスクを作成しました')
        expect(html_body).to include('メイラーspecの作成')
        expect(html_body).to include('送信したメールの確認')
      end
    end

  end
end
