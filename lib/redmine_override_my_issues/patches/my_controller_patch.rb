require_dependency 'my_controller'

module RedmineOverrideMyIssues
  module Patches
    module MyControllerPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          def page
            cookies[:my_per] = set_value if params[:per]
            cookies[:my_per] ||= 10
            @user = User.current
            @blocks = @user.pref[:my_page_layout] ||  MyController::DEFAULT_LAYOUT
          end

          private

          def set_value
            if [10, 20, 50, 100].include? params[:per].to_i
              params[:per].to_i
            else
              10
            end
          end
        end
      end

      module InstanceMethods
        # ..
      end
    end
  end
end