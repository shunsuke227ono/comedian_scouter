class ApplicationController < ActionController::Base
  layout 'admin_lte_2'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_companies

  private

  def set_companies
    @companies = Company.all
  end
end
