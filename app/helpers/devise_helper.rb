module DeviseHelper
  def devise_view?
    controller.class.module_parent.name == "Devise" || controller.class.module_parent.name == "Users"
  end
end
