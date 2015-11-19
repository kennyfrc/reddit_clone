require 'rails_helper'



describe "Sign in flow" do #feature
  
  include TestFactories

  describe  "successful" do #scenario
    it "redirects to the topic index" do
      user = authenticated_user
      visit root_path
    end
  end

end