# frozen_string_literal: true
module HeavyControl
  module Extensions
    module IgnoreSubfolders
      def search_for_file(path_suffix)
        base_result = super(path_suffix)

        return base_result if base_result

        HeavyControl.config[:ignore_subfolders].each do |subfolder|
          new_path_suffix = File.join File.split(path_suffix).insert(-2, subfolder)
          result = super(new_path_suffix)
          return result if result
        end

        nil
      end
    end
  end
end
