class Violation < ActiveRecord::Base      
  attr_accessible :lat, :lng, :date_entered, :date_closed, :description, 
  :status, :violation_address, :violation_type, :image_before, :image_after,:approved

  attr_protected :id
  

  has_attached_file :image_before, styles: {
    thumb: '150x120>',
    full: '1200x900>'
  }, :default_url => '/resources/images/missing_:style.png'

  has_attached_file :image_after, styles: {
    thumb: '150x120>',
    full: '1200x900>'
  }, :default_url => '/resources/images/missing_:style.png'

  def image_before_url_f
    image_before.url(:full)
  end

  def image_before_url_t
    image_before.url(:thumb)
  end

  def image_after_url_f
    image_after.url(:full)
  end

  def image_after_url_t
    image_after.url(:thumb)
  end


end
