require 'test_helper'

describe FlashHelper do
  router = ActionDispatch::Routing::RouteSet.new
  router.draw do
    resources :pages
    match ':controller(/:action(/:id(.:format)))'
  end

  include router.url_helpers

  before do
    @controller = ActionView::TestCase::TestController.new
    @controller.instance_variable_set(:@_routes, router)
  end

  it "should be aware of module existance" do
    FlashHelper.must_be_kind_of Module
  end

  it "should return nil if there is no flash to display" do
    @controller.view_context.must_respond_to :display_flashes
    @controller.view_context.display_flashes.must_be_nil
  end

  it "should return a notice message if flash[:notice] is set" do
    message = "Hey it is a test notice message"

    @controller.flash.notice = message

    @controller.view_context.display_flashes.must_be_kind_of String
    @controller.view_context.display_flashes.must_include message
    @controller.view_context.display_flashes.must_include %q{class="notice"}
  end

  it "should return an error message if flash[:errors] is set" do
    message = "Hey it is a test notice message"

    @controller.flash[:errors] = message

    @controller.view_context.display_flashes.must_be_kind_of String
    @controller.view_context.display_flashes.must_include message
    @controller.view_context.display_flashes.must_include %q{class="errors"}
  end

  it "should return a warning message if flash[:warning] is set" do
    message = "Hey it is a test notice message"

    @controller.flash[:warning] = message

    @controller.view_context.display_flashes.must_be_kind_of String
    @controller.view_context.display_flashes.must_include message
    @controller.view_context.display_flashes.must_include %q{class="warning"}
  end

  it "should return an ul with validation errors if an invalid ActiveRecord object is passed" do
    page = Page.create

    page.valid?.must_equal false

    @controller.flash[:errors] = page.errors

    @controller.view_context.display_flashes.must_be_kind_of String
    @controller.view_context.display_flashes.must_include %q{<div class="errors"}
    @controller.view_context.display_flashes.must_include %q{<ul class="errors_list"}

    page.errors.full_messages.each do |m|
      @controller.view_context.display_flashes.must_include m
    end
  end

  it "should return an error message if flash[:alert] is set" do
    message = "Hey it is a test notice message"

    @controller.flash[:alert] = message

    @controller.view_context.display_flashes.must_be_kind_of String
    @controller.view_context.display_flashes.must_include message
    @controller.view_context.display_flashes.must_include %q{class="errors"}
  end

  it "should return an ul with validation errors if an invalid ActiveRecord object is passed" do
    page = Page.create

    page.valid?.must_equal false

    @controller.flash[:alert] = page.errors

    @controller.view_context.display_flashes.must_be_kind_of String
    @controller.view_context.display_flashes.must_include %q{<div class="errors"}
    @controller.view_context.display_flashes.must_include %q{<ul class="errors_list"}

    page.errors.full_messages.each do |m|
      @controller.view_context.display_flashes.must_include m
    end
  end
end
