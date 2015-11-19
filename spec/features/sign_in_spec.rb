require 'rails_helper'

describe "Sign in flow" do #feature
  
  include TestFactories

  describe  "successful" do #scenario
    it "redirects to the topic index" do
      user = authenticated_user
      visit root_path

      within '.user-info' do # goes clicks the initital button # if you want to click a link, use a CSS tag. if it's a button,
                      # especially if it's from devise, then use 'form'
        click_link 'Sign In'
      end
        fill_in 'Email', with: user.email # fills out the form appropriately
        fill_in 'Password', with: user.password


      within 'form' do
        click_button 'Sign in' # submits the form
      end

      expect(current_path).to eq(topics_path) #tests the redirect
    end
  end
  
end