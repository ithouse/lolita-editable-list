require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Lolita::Configuration::EditableList do 
  let(:dbi){Lolita::DBI::Base.new(Post)}
  let(:all_fields){dbi.fields.map{|f| f[:name]}.map(&:to_sym)}
  it "should configure defaults" do
    Post.lolita.list.editable.fields.should == all_fields
  end

  before(:each) do 
    Post.lolita.list.editable = nil
  end

  it "should return :only fields" do
    Post.lolita.list.editable.only [:title]
    Post.lolita.list.editable.fields.should == [:title]
  end

  it "should return :except fields" do
    Post.lolita.list.editable.except [:title]
    Post.lolita.list.editable.fields.should == all_fields.select{|f| f != :title}
  end
end