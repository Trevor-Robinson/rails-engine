class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.paginate(page, per_page)
    page = (page || 1).to_i
    page = 1 if page == 0
    per_page = (per_page || 20).to_i
    limit(per_page).offset((page - 1) * per_page)
  end
end
