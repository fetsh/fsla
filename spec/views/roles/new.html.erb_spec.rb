require 'spec_helper'

describe "roles/new.html.erb" do
  before(:each) do
    assign(:role, stub_model(Role,
      :new_record? => true,
      :name => "MyString"
    ))
  end

  it "renders new role form" do
    render

    rendered.should have_selector("form", :action => roles_path, :method => "post") do |form|
      form.should have_selector("input#role_name", :name => "role[name]")
    end
  end
end
