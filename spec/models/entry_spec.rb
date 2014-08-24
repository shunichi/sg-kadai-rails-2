require 'spec_helper'

describe Entry do
  it "blog_id,title,bodyがあれば有効であること" do
    expect(Entry.new(blog_id: 1, title: 'ねこがすき', body: '大好きなんです！')).to be_valid
  end
  it "blog_idがなければ無効であること" do
    expect(Entry.new(blog_id: nil, title: 'ねこがすき', body: '大好きなんです！')).not_to be_valid
  end
  it "titleがなければ無効であること" do
    expect(Entry.new(blog_id: 1, title: nil, body: '大好きなんです！')).not_to be_valid
  end
  it "bodyがなければ無効であること" do
    expect(Entry.new(blog_id: 1, title: 'ねこがすき', body: nil)).not_to be_valid
  end
end