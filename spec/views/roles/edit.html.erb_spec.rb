require 'spec_helper'

describe "roles/edit.html.erb" do
  before(:each) do
    @role = assign(:role, stub_model(Role,
      :new_record? => false,
      :name => "MyString"
    ))
  end

  it "renders the edit role form" do
    render

    rendered.should have_selector("form", :action => role_path(@role), :method => "post") do |form|
      form.should have_selector("input#role_name", :name => "role[name]")
    end
  end
end
