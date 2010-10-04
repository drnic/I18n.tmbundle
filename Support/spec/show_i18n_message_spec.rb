require "spec_helper"
require "show_i18n_message"

describe "One en.yml locale file in project" do
  before do
    @project_dir = File.expand_path("fixtures/one_locale", File.dirname(__FILE__))
  end
  
  it "works for double quotes" do
    line = %Q{  msg = I18n.t("my.project.message") }
    ShowI18nMessage.display_message(line, @project_dir).should == "en: This is my project's message"
  end

  it "works for single quotes" do
    line = %Q{  msg = I18n.t('my.project.message') }
    ShowI18nMessage.display_message(line, @project_dir).should == "en: This is my project's message"
  end
end

describe "For specific locale" do
  before do
    @project_dir = File.expand_path("fixtures/multi_locale", File.dirname(__FILE__))
  end
  
  it "works for double quotes" do
    line = %Q{  msg = I18n.t("my.project.message") }
    ShowI18nMessage.display_message(line, @project_dir).should == "en: This is my project's message\nfr: Bonjour!"
  end
  
  it "locale is unmodified" do
    I18n.locale = :es
    line = %Q{  msg = I18n.t("my.project.message") }
    ShowI18nMessage.display_message(line, @project_dir)
    I18n.locale.should == :es
  end
end