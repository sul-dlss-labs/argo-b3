# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Edit::AccessRightsComponent, type: :component do
  let(:component) { described_class.new(form:) }
  let(:form) { ActionView::Helpers::FormBuilder.new(nil, manage_rights_form, vc_test_view_context, {}) }

  # The same labels (World, Stanford, Location Based) appear in more than one fieldset,
  # so assertions are scoped to the fieldset with the given legend.
  def fieldset(legend)
    page.find(:xpath, ".//fieldset[legend[normalize-space(text())='#{legend}']]")
  end

  context 'when the form has the default rights' do
    let(:manage_rights_form) { BulkActions::ManageRightsForm.new }

    it 'renders the view rights' do
      render_inline(component)

      expect(fieldset('View rights')).to have_field('World', type: 'radio', checked: true)
      expect(fieldset('View rights')).to have_field('Dark', type: 'radio', checked: false)
      expect(fieldset('View rights')).to have_field('Citation Only', type: 'radio', checked: false)
      expect(fieldset('View rights')).to have_field('Stanford', type: 'radio', checked: false)
      expect(fieldset('View rights')).to have_field('Location Based', type: 'radio', checked: false)
    end

    it 'renders the download rights' do
      render_inline(component)

      expect(fieldset('Download rights')).to have_field('World', type: 'radio', checked: true)
      expect(fieldset('Download rights')).to have_field('Stanford', type: 'radio', checked: false)
      expect(fieldset('Download rights')).to have_field('Location Based', type: 'radio', checked: false)
      expect(fieldset('Download rights')).to have_field('None', type: 'radio', checked: false)
    end

    it 'renders the locations' do
      render_inline(component)

      expect(fieldset('Location')).to have_field('Special collections', type: 'radio', checked: false)
      expect(fieldset('Location')).to have_field('Music', type: 'radio', checked: false)
      expect(fieldset('Location')).to have_field('ARS', type: 'radio', checked: false)
      expect(fieldset('Location')).to have_field('Art', type: 'radio', checked: false)
      expect(fieldset('Location')).to have_field('Hoover Institute', type: 'radio', checked: false)
      expect(fieldset('Location')).to have_field('Media and Microtext', type: 'radio', checked: false)
    end
  end

  context 'when the form has location-based rights' do
    let(:manage_rights_form) do
      BulkActions::ManageRightsForm.new(view: 'location-based', download: 'none', location: 'spec')
    end

    it 'renders the selected rights' do
      render_inline(component)

      expect(fieldset('View rights')).to have_field('Location Based', type: 'radio', checked: true)
      expect(fieldset('View rights')).to have_field('World', type: 'radio', checked: false)

      expect(fieldset('Download rights')).to have_field('None', type: 'radio', checked: true)
      expect(fieldset('Download rights')).to have_field('World', type: 'radio', checked: false)

      expect(fieldset('Location')).to have_field('Special collections', type: 'radio', checked: true)
      expect(fieldset('Location')).to have_field('Music', type: 'radio', checked: false)
    end
  end

  context 'when wiring the access rights Stimulus controller' do
    let(:manage_rights_form) { BulkActions::ManageRightsForm.new }

    it 'renders the targets that the controller expects' do
      render_inline(component)

      expect(page).to have_css('[data-controller="access-rights"]')
      expect(page).to have_css('[data-access-rights-target="citationOnlyView"]')
      expect(page).to have_css('[data-access-rights-target="locationBasedDownload"]')
      expect(page).to have_css('[data-access-rights-target="location"]', count: 6)
    end
  end
end
