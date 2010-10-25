require 'spec_helper'

describe "roles/index.html.erb" do
  before(:each) do
    assign(:roles, [
      stub_model(Role,
        :name => "Name"
      ),
      stub_model(Role,
        :name => "Name"
      )
    ])
  end

  it "renders a list of roles" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
  end
end
