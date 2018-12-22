require 'rails_helper'

describe 'Profiles' do
  before { driven_by :with_push }

  it 'creates client and sets auth_token cookie' do
    expect do
      visit root_path
    end.to change { Client.count }.by(1)
    cookie = page.driver.browser.manage.cookie_named('auth_token')
    expect(cookie[:value]).to eq Client.last.auth_token
  end

  it 'obtains and removes push token from service worker' do
    visit root_path
    expect(page).to have_content 'No Token'

    click_button 'Obtain Token'
    expect(page).to have_content 'Got token'
    expect(Client.last.push_subscription).to be_present

    click_button 'Unsubscribe'
    expect(page).to have_content 'No Token'
    expect(Client.last.push_subscription).not_to be_present
  end

  it 'obtains a push token and sends push' do
    visit root_path
    click_button 'Obtain Token'
    click_button 'Send push'
  end

  after do
    STDERR.puts page.driver.browser.manage.logs.get(:browser)
  end
end
