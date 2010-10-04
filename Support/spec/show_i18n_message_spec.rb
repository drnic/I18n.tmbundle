require "spec_helper"
require "show_i18n_message"

describe "One en.yml locale file in project" do
  before do
    @project_dir = File.expand_path("fixtures/one_locale", File.dirname(__FILE__))
  end
  
  it "works for double quotes" do
    line = %Q{  msg = I18n.t("my.project.message") }
    ShowI18nMessage.display_message(line, @project_dir).should == "This is my project's message"
  end

  it "works for single quotes" do
    line = %Q{  msg = I18n.t('my.project.message') }
    ShowI18nMessage.display_message(line, @project_dir).should == "This is my project's message"
  end
end