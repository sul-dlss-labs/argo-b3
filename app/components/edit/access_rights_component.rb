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

    def view_options
      VIEW_RIGHTS.map { |view_right| [view_right.titleize, view_right] }
    end

    def download_options
      DOWNLOAD_RIGHTS.map { |download_right| [download_right.titleize, download_right] }
    end

    def location_options
      Constants::ACCESS_LOCATIONS.map { |location| [I18n.t("access.locations.#{location}"), location] }
    end
  end
end
