# frozen_string_literal: true

class UserAndTeamManagements::HeaderComponent < ApplicationComponent
  def initialize(active_tab:)
    @active_tab = active_tab
  end

  def tabs
    [
      Tab.new({
        text: "Users",
        url: users_url,
        html_class: html_class_for(:users)
      }),
      Tab.new({
        text: "Teams",
        url: teams_url,
        html_class: html_class_for(:teams)
      }),
      Tab.new({
        text: "Imports",
        url: user_imports_url,
        html_class: html_class_for(:user_imports)
      })
    ]
  end

  private

  class Tab
    include ActiveModel::Model

    attr_accessor :text, :url, :html_class
  end

  def html_class_for(tab_name)
    if tab_name == @active_tab
      "inline-block min-h-9 px-4 py-1.5 border-b-2 border-neutral-900 text-neutral-900"
    else
      "inline-block min-h-9 px-4 py-1.5 text-neutral-500 hover:text-neutral-700 transition-colors"
    end
  end
end
