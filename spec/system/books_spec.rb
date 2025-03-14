1	require 'rails_helper'
2	 
3	describe '投稿のテスト' do
4	  let!(:book) { create(:book,title:'hoge',body:'body') }
5	  describe 'トップ画面(root_path)のテスト' do
6	    before do 
7	      visit root_path
8	    end
9	    context '表示の確認' do
10	      it 'トップ画面(root_path)に一覧ページへのリンクが表示されているか' do
11	        expect(page).to have_link "", href: books_path
12	      end
13	      it 'root_pathが"/"であるか' do
14	        expect(current_path).to eq('/')
15	      end
16	    end
17	  end
18	  describe "一覧画面のテスト" do
19	    before do
20	      visit books_path
21	    end
22	    context '一覧の表示とリンクの確認' do
23	      it "bookの一覧表示(tableタグ)と投稿フォームが同一画面に表示されているか" do
24	        expect(page).to have_selector 'table'
25	        expect(page).to have_field 'book[title]'
26	        expect(page).to have_field 'book[body]'
27	      end
28	      it "bookのタイトルと感想を表示し、詳細・編集・削除のリンクが表示されているか" do
29	          (1..5).each do |i|
30	            Book.create(title:'hoge'+i.to_s,body:'body'+i.to_s)
31	          end
32	          visit books_path
33	          Book.all.each_with_index do |book,i|
34	            j = i * 3
35	            expect(page).to have_content book.title
36	            expect(page).to have_content book.body
37	            # Showリンク
38	            show_link = find_all('a')[j]
39	            expect(show_link.native.inner_text).to match(/show/i)
40	            expect(show_link[:href]).to eq book_path(book)
41	            # Editリンク
42	            show_link = find_all('a')[j+1]
43	            expect(show_link.native.inner_text).to match(/edit/i)
44	            expect(show_link[:href]).to eq edit_book_path(book)
45	            # Destroyリンク
46	            show_link = find_all('a')[j+2]
47	            expect(show_link.native.inner_text).to match(/destroy/i)
48	            expect(show_link[:href]).to eq book_path(book)
49	          end
50	      end
51	      it 'Create Bookボタンが表示される' do
52	        expect(page).to have_button 'Create Book'
53	      end
54	    end
55	    context '投稿処理に関するテスト' do
56	      it '投稿に成功しサクセスメッセージが表示されるか' do
57	        fill_in 'book[title]', with: Faker::Lorem.characters(number:5)
58	        fill_in 'book[body]', with: Faker::Lorem.characters(number:20)
59	        click_button 'Create Book'
60	        expect(page).to have_content 'successfully'
61	      end
62	      it '投稿に失敗する' do
63	        click_button 'Create Book'
64	        expect(page).to have_content 'error'
65	        expect(current_path).to eq('/books')
66	      end
67	      it '投稿後のリダイレクト先は正しいか' do
68	        fill_in 'book[title]', with: Faker::Lorem.characters(number:5)
69	        fill_in 'book[body]', with: Faker::Lorem.characters(number:20)
70	        click_button 'Create Book'
71	        expect(page).to have_current_path book_path(Book.last)
72	      end
73	    end
74	    context 'book削除のテスト' do
75	      it 'application.html.erbにjavascript_pack_tagを含んでいるか', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
76	        is_exist = 0
77	        open("app/views/layouts/application.html.erb").each do |line|
78	          strip_line = line.chomp.gsub(" ", "")
79	          if strip_line.include?("<%=javascript_pack_tag'application','data-turbolinks-track':'reload'%>")
80	            is_exist = 1
81	            break
82	          end
83	        end
84	        expect(is_exist).to eq(1)
85	      end
86	      it 'bookの削除', spec_category: "CRUD機能に対するコントローラーの処理と流れ" do
87	        before_delete_book = Book.count
88	        click_link 'Destroy', match: :first
89	        after_delete_book = Book.count
90	        expect(before_delete_book - after_delete_book).to eq(1)
91	        expect(current_path).to eq('/books')
92	      end
93	    end
94	  end
95	  describe '詳細画面のテスト' do
96	    before do
97	      visit book_path(book)
98	    end
99	    context '表示の確認' do
100	      it '本のタイトルと感想が画面に表示されていること' do
101	        expect(page).to have_content book.title
102	        expect(page).to have_content book.body
103	      end
104	      it 'Editリンクが表示される' do
105	        edit_link = find_all('a')[0]
106	        expect(edit_link.native.inner_text).to match(/edit/i)
107				end
108	      it 'Backリンクが表示される' do
109	        back_link = find_all('a')[1]
110	        expect(back_link.native.inner_text).to match(/back/i)
111				end  
112	    end
113	    context 'リンクの遷移先の確認' do
114	      it 'Editの遷移先は編集画面か' do
115	        edit_link = find_all('a')[0]
116	        edit_link.click
117	        expect(current_path).to eq('/books/' + book.id.to_s + '/edit')
118	      end
119	      it 'Backの遷移先は一覧画面か' do
120	        back_link = find_all('a')[1]
121	        back_link.click
122	        expect(page).to have_current_path books_path
123	      end
124	    end
125	  end
126	  describe '編集画面のテスト' do
127	    before do
128	      visit edit_book_path(book)
129	    end
130	    context '表示の確認' do
131	      it '編集前のタイトルと感想がフォームに表示(セット)されている' do
132	        expect(page).to have_field 'book[title]', with: book.title
133	        expect(page).to have_field 'book[body]', with: book.body
134	      end
135	      it 'Update Bookボタンが表示される' do
136	        expect(page).to have_button 'Update Book'
137	      end
138	      it 'Showリンクが表示される' do
139	        show_link = find_all('a')[0]
140	        expect(show_link.native.inner_text).to match(/show/i)
141				end  
142	      it 'Backリンクが表示される' do
143	        back_link = find_all('a')[1]
144	        expect(back_link.native.inner_text).to match(/back/i)
145				end  
146	    end
147	    context 'リンクの遷移先の確認' do
148	      it 'Showの遷移先は詳細画面か' do
149	        show_link = find_all('a')[0]
150	        show_link.click
151	        expect(current_path).to eq('/books/' + book.id.to_s)
152	      end
153	      it 'Backの遷移先は一覧画面か' do
154	        back_link = find_all('a')[1]
155	        back_link.click
156	        expect(page).to have_current_path books_path
157	      end
158	    end
159	    context '更新処理に関するテスト' do
160	      it '更新に成功しサクセスメッセージが表示されるか' do
161	        fill_in 'book[title]', with: Faker::Lorem.characters(number:5)
162	        fill_in 'book[body]', with: Faker::Lorem.characters(number:20)
163	        click_button 'Update Book'
164	        expect(page).to have_content 'successfully'
165	      end
166	      it '更新に失敗しエラーメッセージが表示されるか' do
167	        fill_in 'book[title]', with: ""
168	        fill_in 'book[body]', with: ""
169	        click_button 'Update Book'
170	        expect(page).to have_content 'error'
171	      end
172	      it '更新後のリダイレクト先は正しいか' do
173	        fill_in 'book[title]', with: Faker::Lorem.characters(number:5)
174	        fill_in 'book[body]', with: Faker::Lorem.characters(number:20)
175	        click_button 'Update Book'
176	        expect(page).to have_current_path book_path(book)
177	      end
178	    end
179	  end
180	end
