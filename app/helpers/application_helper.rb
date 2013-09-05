module ApplicationHelper


  def find_and_include_asset_css(name)
    if Rails.application.assets.find_asset(ensure_suffix(name, ".css"))
      stylesheet_link_tag(name) 
    else 
      ""
    end
  end

  def find_and_include_asset_js(name)
    if Rails.application.assets.find_asset(ensure_suffix(name,'.js'))
      javascript_include_tag(name) 
    else
      ""
    end
  end

  def find_and_include_asset(name)
   find_and_include_asset_css(name)  +  find_and_include_asset_js(name)
  end


  def ensure_suffix(name, suffix)
    if not name.match(/#{Regexp.escape(suffix)}/)
      name + suffix
    else 
      name
    end
  end

end
