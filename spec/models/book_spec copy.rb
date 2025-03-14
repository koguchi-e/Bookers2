# frozen_string_literal: true
2	 
3	require 'rails_helper'
4	 
5	RSpec.describe Book, "モデルに関するテスト", type: :model do
6	  describe '実際に保存してみる' do
7	    it "有効な投稿内容の場合は保存されるか" do
8	      expect(FactoryBot.build(:book)).to be_valid
9	    end
10	  end
11	  context "空白のバリデーションチェック" do
12	    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
13	      book = Book.new(title: '', body:'hoge')
14	      expect(book).to be_invalid
15	      expect(book.errors[:title]).to include("can't be blank")
16	    end
17	    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
18	      book = Book.new(title: 'hoge', body:'')
19	      expect(book).to be_invalid
20	      expect(book.errors[:body]).to include("can't be blank")
21	    end
22	  end
23	end
