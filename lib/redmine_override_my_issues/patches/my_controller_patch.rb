require_dependency 'my_controller'
require 'pry'
module RedmineOverrideMyIssues
  module Patches
    module MyControllerPatch

      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          def page
            cookies[:my_per] = params[:per] if params[:per]
            @user = User.current
            @blocks = @user.pref[:my_page_layout] ||  MyController::DEFAULT_LAYOUT
          end
        end
      end

      module InstanceMethods
        # ..
      end
    end
  end
end