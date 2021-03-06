require 'spec_helper'
require 'fileutils'

feature 'User wants to add a Dockerfile file', feature: true do
  before do
    user = create(:user)
    project = create(:project)
    project.team << [user, :master]

    gitlab_sign_in user

    visit namespace_project_new_blob_path(project.namespace, project, 'master', file_name: 'Dockerfile')
  end

  scenario 'user can see Dockerfile dropdown' do
    expect(page).to have_css('.dockerfile-selector')
  end

  scenario 'user can pick a Dockerfile file from the dropdown', js: true do
    find('.js-dockerfile-selector').click

    wait_for_requests

    within '.dockerfile-selector' do
      find('.dropdown-input-field').set('HTTPd')
      find('.dropdown-content li', text: 'HTTPd').click
    end

    wait_for_requests

    expect(page).to have_css('.dockerfile-selector .dropdown-toggle-text', text: 'HTTPd')
    expect(page).to have_content('COPY ./ /usr/local/apache2/htdocs/')
  end
end
