require 'spec_helper'

describe Comment do
  it "entry_id,bodyがあり、statusが'unapproved'なら有効であること" do
    expect(Comment.new(entry_id: 1, body: 'ねこはかわいい', status: 'unapproved')).to be_valid
  end

  it "entry_id,bodyがあり、statusが'approved'なら有効であること" do
    expect(Comment.new(entry_id: 1, body: 'ねこはかわいい', status: 'approved')).to be_valid
  end

  it "entry_idがないなら無効であること" do
    expect(Comment.new(entry_id: nil, body: 'ねこはかわいい', status: 'unapproved')).not_to be_valid
  end

  it "bodyがないなら無効であること" do
    expect(Comment.new(entry_id: 1, body: nil, status: 'unapproved')).not_to be_valid
  end

  it "statusがapprovedかunapprovedでないなら無効であること" do
    expect(Comment.new(entry_id: 1, body: 'ねこはかわいい', status: 'ok')).not_to be_valid
  end
end
