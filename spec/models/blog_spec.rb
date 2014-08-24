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
end