require 'i18n_bundle_setup'

module ShowI18nMessage
  extend self
  def display_message(current_line, project_directory)
    if current_line =~ /I18n.t[^\w]+([\w\.]+)/
      i18n_key = $1
      all_project_locale_files = Dir[File.join(project_directory, '**', 'locales', '*.yml')]
      return I18n.t("i18n.error.no_locales_files_found") if all_project_locale_files.size == 0

      all_project_locale_files.each { |file| I18n.load_path << file }
      I18n.t(i18n_key)
    else
      I18n.t("i18n.error.no_locales_mentioned_on_line")
    end
  end
end
