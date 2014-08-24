require 'spec_helper'

describe Blog do
  it "titleがあれば有効な状態であること" do
    expect(Blog.new(title: "ねこブログ")).to be_valid
  end
  it "titleがなければ無効な状態であること" do
    expect(Blog.new(title: nil)).not_to be_valid
  end
  it "titleがなければtitleにエラーが１つあること" do
    expect(Blog.new(title: nil)).to have(1).errors_on(:title) # needs rspec-collection_matchers
  end
  it "titleが空文字列なら無効な状態であること" do
    expect(Blog.new(title: '')).not_to be_valid
  end
  it "titleが空文字列ならtitleにエラーが１つあること" do
    expect(Blog.new(title: '')).to have(1).errors_on(:title)
  end

  describe "dependent destroy" do
    let(:blog) { Blog.create(title: "ねこブログ") }
    let!(:entry1) { blog.entries.create(title: '最初のエントリ', body: 'はじめまして') }
    let!(:entry2) { blog.entries.create(title: '２番目のエントリ', body: '久しぶりです')}

    it "ブログに属すエントリが２個あること" do
      expect(Entry.where(blog_id: blog.id).size).to eq(2)
    end

    it "ブログを消したらエントリも削除されること" do
      blog.destroy
      expect(Entry.where(blog_id: blog.id).size).to eq(0)
    end
  end
end