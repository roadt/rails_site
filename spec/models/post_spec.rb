require 'spec_helper'

describe Post do
#  pending "add some examples to (or delete) #{__FILE__}"

  it "should have title and content" do
    expect {Post.create!(:title=>nil, :content=>'x') }.to raise_error
    expect {Post.create!(:title=>'x', :content=>nil)}.to raise_error
    Post.create(:title=>'x', :content=>'x').should be_true
  end

  it "title > 5 chars" do
    expect { Post.create!(:title=>'x', :content=>'x')}.to raise_error
  end

  it "test fail" do
    false.should to_true
  end
end
