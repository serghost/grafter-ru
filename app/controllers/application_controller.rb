class ApplicationController < ActionController::Base
  protect_from_forgery

  def method_missing(method, *args)
    if method.to_s =~ /^find_([a-z]+)_id$/
      find_id($1)
    elsif method.to_s =~ /^find_([a-z]+)$/
      find_id($1, :search_name_only)
    else
      super
    end
  end

  private

  def find_id(name, *args)
    if args.include?(:search_name_only)
      id = params[name]
    else
      id = params["#{name}_id"].presence || params[:id]
    end

    # Create instance variable like @university = University.find(1)
    instance_eval "@#{name} = #{name.capitalize}.find(#{id})"
  end

  def authorize_admin!
    authenticate_user!

    unless current_user.admin?
      redirect_to root_path, :alert => "You must be an admin to do that."
    end
  end
end
