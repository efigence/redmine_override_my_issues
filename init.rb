# encoding: utf-8
Redmine::Plugin.register :redmine_override_my_issues do
  name 'Redmine Override My Issues plugin'
  author 'Marcin Świątkiewicz'
  description 'This plugin override list of assigned to me issues which should not include issues from closed projects.'
  version '0.0.1'
  url 'http://github.com/efigence/redmine_override_my_issues'
  author_url 'http://efigence.com/'

  ActionDispatch::Callbacks.to_prepare do
    MyController.send(:include, RedmineOverrideMyIssues::Patches::MyControllerPatch)
    Issue.send(:include, RedmineOverrideMyIssues::Patches::IssuePatch)
  end
end
