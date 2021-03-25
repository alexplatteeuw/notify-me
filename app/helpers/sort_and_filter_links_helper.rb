module SortAndFilterLinksHelper
  def generate_filter_link(status)
    link_to status, request.query_parameters.slice(:q).deep_merge(q: { status_cont: status }),
            class: class_names(active: status_selected?(status), filter_link: true)
  end

  def generate_sort_link(query, attribute, name, order)
    sort_link(query, attribute, name,
              { default_order: order,
                page: nil },
              { class: class_names(active: sort_selected?(attribute)) })
  end

  def sort_selected?(type)
    params[:q].present? && params[:q][:s].present? && params[:q][:s].include?(type.to_s)
  end

  def status_selected?(status)
    params[:q].present? && params[:q][:status_cont] == status
  end

  def any_status_selected?
    params[:q].present? && params[:q][:status_cont].present?
  end
end
