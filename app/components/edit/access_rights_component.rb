# frozen_string_literal: true

module Edit
  # Component for rendering edit form for access rights
  class AccessRightsComponent < ApplicationComponent
    VIEW_RIGHTS = %w[world dark citation-only stanford location-based].freeze
    DOWNLOAD_RIGHTS = %w[world stanford location-based none].freeze

    def initialize(form:)
      @form = form
      super()
    end

    attr_reader :form

    # @param value [String] an access rights value, e.g. 'citation-only'
    # @param suffix [String] 'View' or 'Download'
    # @return [String] the Stimulus target name, e.g. 'citationOnlyView'
    def stimulus_target_name(value, suffix)
      "#{value.underscore.camelize(:lower)}#{suffix}"
    end
  end
end
