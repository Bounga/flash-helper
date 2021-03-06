require 'active_support'

module Bounga
  module FlashHelper
    # This extension provides a simple way to handle flash messages.
    # You can easily display notices, errors and warnings using the convinience method.
    #
    # == Example
    #
    # For example, in your layout use :
    #
    #   display_flashes # Use defaults
    #
    # Then in your controllers you can use :
    #   flash[:notice] = "Successfully created..."
    #   flash[:errors] = "Creation failed!"
    #   flash[:errors] = @news.errors
    #   flash[:warning] = "The new user has no blog associated..."
    #
    # You can translate plugin internal messages,
    # for example in config/locales/fr.yml you can add :
    #
    # flash_helper:
    #   default_message: "Il y a des problèmes dans le formulaire :"

    # == Global options for helpers
    #
    # Options for flash helpers are optional and get their default values from the
    # <tt>Bounga::FlashHelper::ViewHelpers.flash_options</tt> hash. You can write to this hash to
    # override default options on the global level:
    #
    #   Bounga::FlashHelper::ViewHelpers.flash_options[:notice_class] = 'my_notice'
    #
    # By putting this into "config/initializers/flash_helper.rb" (or simply environment.rb in
    # older versions of Rails) you can easily override any default option.
    module ViewHelpers
      # default options that can be overridden on the global level
      @@flash_options = {
        :list_class     => 'errors_list',
        :notice_class     => 'notice',
        :errors_class     => 'errors',
        :warning_class    => 'warning',
        :default_message  => 'There are problems in your submission:'
      }
      mattr_reader :flash_options

      I18n.backend.store_translations :'en', {
        :flash_helper => {
          :default_message => 'There are problems in your submission:'
        }
      }
      @@flash_options.merge!(:default_message  => I18n.t('flash_helper.default_message'))

      # Display flash messages.
      # You can pass an optional string as a parameter. It will be display before
      # error messages.
      def display_flashes(message = @@flash_options[:default_message])
        if flash[:notice]
          flash_to_display, level = flash[:notice], @@flash_options[:notice_class]
        elsif flash[:warning]
          flash_to_display, level = flash[:warning], @@flash_options[:warning_class]
        elsif flash[:errors] || flash[:alert]
          error_flash = flash[:errors] || flash[:alert]
          level = @@flash_options[:errors_class]

          if error_flash.instance_of? ActiveModel::Errors
            flash_to_display = message.dup
            flash_to_display << activerecord_error_list(error_flash)
          else
            flash_to_display = error_flash
          end
        else
          return
        end
        flash.discard(:notice); flash.discard(:warning); flash.discard(:errors)
        content_tag('div', flash_to_display.html_safe, :class => "#{level}")
      end


      def activerecord_error_list(errors)
        content_tag :ul, :class => @@flash_options[:list_class] do
          errors.full_messages.collect do |m|
            content_tag(:li, m.html_safe)
          end.to_s.html_safe
        end
      end
    end
  end
end

ActionView::Base.send :include, Bounga::FlashHelper::ViewHelpers