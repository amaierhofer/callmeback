require 'rails_helper'

describe 'Profiles' do
  before { driven_by :headless }
  it 'has welcome screen' do
    visit root_path
    expect(page).to have_content 'Welcome'
    logs = page.driver.browser.manage.logs.get(:browser)
    expect(logs.first.message).to match(/Application initialized/)
  end
end
