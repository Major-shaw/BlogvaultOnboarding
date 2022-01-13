ActiveAdmin.register Article do
  actions :all, except: [:new, :edit]
  permit_params :title, :comment

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :body, :status, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :status, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
