require 'i18n_bundle_setup'

module ShowI18nMessage
  extend self
  def display_message(current_line, project_directory)
    if current_line =~ /I18n.t[^\w]+([\w\.]+)/
      i18n_key = $1
      all_project_locale_files = Dir[File.join(project_directory, '**', 'locales', '*.yml')]
      return I18n.t("i18n.error.no_locales_files_found") if all_project_locale_files.size == 0
      original_load_path, original_locale = I18n.load_path, I18n.locale
      messages = all_project_locale_files.inject({}) do |mem, locale_file|
        I18n.load_path = [locale_file]
        I18n.reload!
        I18n.locale = I18n.backend.available_locales.first
        mem[I18n.locale] = nil if mem[I18n.locale] =~ /translation missing/
        mem[I18n.locale] ||= I18n.t(i18n_key) if I18n.t(i18n_key)
        mem
      end
      I18n.locale, I18n.load_path = original_locale, original_load_path
      locale_messages = messages.inject([]) { |list, pair| locale, string = pair; list << "#{locale}: #{string}" }
      locale_messages.sort.join("\n")
    else
      I18n.t("i18n.error.no_locales_mentioned_on_line")
    end
  end
end
