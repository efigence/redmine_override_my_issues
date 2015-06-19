require_dependency 'my_helper'

module RedmineOverrideMyIssues
  module Patches
    module MyHelperPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          def issuesassignedtome_items per = nil
            per = per.blank? ? 10 : per
            Issue.visible.open.
              where(:assigned_to_id => ([User.current.id] + User.current.group_ids)).
              limit(per).
              includes(:status, :project, :tracker, :priority).
              where(projects: {status: Project::STATUS_ACTIVE}). #only active projects
              references(:status, :project, :tracker, :priority).
              order("#{IssuePriority.table_name}.position DESC, #{Issue.table_name}.updated_on DESC").
              to_a
          end
        end
      end

      module InstanceMethods
        # ...
      end
    end
  end
end