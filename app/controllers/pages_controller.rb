class PagesController < ApplicationController
  skip_before_action :authenticate

  def home
  end

  def close_modal
  end
end
