require 'spec_helper'

describe BlogsController do
  describe 'GET #index' do
    let(:blog1) { Blog.create(title: 'ねこブログ') }
    let(:blog2) { Blog.create(title: 'いぬブログ') }

    it "@blogsに全てのブログが入っていること" do
      get :index
      expect(assigns(:blogs)).to match_array([blog1, blog2])
    end
  end

  describe 'GET #show' do
    let(:blog) { Blog.create(title:'ねこブログ') }

    it "@blogに要求されたブログを割り当てること" do
      get :show, id: blog
      expect(assigns(:blog)).to eq blog
    end

    it "showテンプレートを表示すること" do
      get :show, id: blog
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "@blogに新しいブログを割り当てること" do
      get :new
      expect(assigns(:blog)).to be_a_new(Blog)
    end

    it "newテンプレートを表示すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:blog) { Blog.create(title:'ねこブログ') }

    it "@blogに要求されたブログを割り当てること" do
      get :edit, id: blog
      expect(assigns(:blog)).to eq blog
    end

    it "editテンプレートを表示すること" do
      get :edit, id: blog
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context '正しい入力の場合' do
      it "データベースにレコードが保存されること" do
        expect {
          post :create, { blog: { title: 'ねこブログ'} }
        }.to change(Blog, :count).by(1)
      end

      it "新規作成後に@blogsのshowに遷移すること" do
        post :create, { blog: { title: 'ねこブログ' } }
        expect(response).to redirect_to assigns(:blog)
      end
    end

    context '不正な入力の場合' do
      it "データベースにレコードが保存されないこと" do
        expect {
          post :create, { blog: { title: ''} }
        }.to_not change(Blog, :count)
      end

      it "newテンプレートを再度表示すること" do
        post :create, { blog: { title: ''} }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    let(:blog) { Blog.create(title:'ねこブログ') }

    it "@blogに要求されたブログを割り当てること" do
        patch :update, id: blog, blog: { title: 'いぬブログ' }
        expect(assigns(:blog)).to eq blog
    end

    context '正しい入力の場合' do
      it "レコードが変更されること" do
        patch :update, id: blog, blog: { title: 'いぬブログ' }
        blog.reload
        expect(blog.title).to eq 'いぬブログ'
      end

      it "更新後に@blogsのshowに遷移すること" do
        patch :update, id: blog, blog: { title: 'いぬブログ' }
        expect(response).to redirect_to blog
      end
    end

    context '不正な入力の場合' do
      it "レコードが変更されないこと" do
        patch :update, id: blog, blog: { title: '' }
        blog.reload
        expect(blog.title).to eq 'ねこブログ'
      end

      it "editテンプレートを再度表示すること" do
        patch :update, id: blog, blog: { title: '' }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:blog) { Blog.create(title:'ねこブログ') }

    it "レコードが削除されること" do
        expect {
          delete :destroy, id: blog
        }.to change(Blog, :count).by(-1)
    end

    it "#indexにリダイレクトされること" do
      delete :destroy, id: blog
      expect(response).to redirect_to blogs_url
    end
  end
end