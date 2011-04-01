require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Lolita::Configuration::EditableList do
  before(:each) do 
    Post.lolita.list.editable = nil
  end
  
  let(:all_columns){Post.lolita.list.editable.all_column_names}

  it "should configure defaults" do
    Post.lolita.list.is_editable
    Post.lolita.list.editable.columns.should == all_columns
  end

  it "should return :only fields" do
    Post.lolita.list.is_editable :only => [:title]
    Post.lolita.list.editable.columns.should == [:title]
  end

  it "should return :except fields" do
    Post.lolita.list.is_editable do 
      except :title
    end
    Post.lolita.list.editable.columns.should == all_columns.select{|f| f != :title}
  end

  it "should return :only fields assigned in block" do
    Post.lolita.list.is_editable do 
      only :title
    end
    Post.lolita.list.editable.columns.should == [:title]
  end

  it "should return :except fields assigned in block" do
    Post.lolita.list.is_editable :except => [:title]
    Post.lolita.list.editable.columns.should == all_columns.select{|f| f != :title}
  end

  it "should test is it editable?" do
    Post.lolita.list.editable?.should be_false
    Post.lolita.list.is_editable
    Post.lolita.list.editable?.should be_true
  end
end