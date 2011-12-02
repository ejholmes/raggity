require 'spec_helper'

describe 'home' do
  it 'does nothing' do
    visit '/'
    page.should have_content('Welcome aboard')
  end
end
