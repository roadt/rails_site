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
    name_array_to_load(name).inject("".html_safe) {|s, nam|
      puts nam
      s += find_and_include_asset_css(nam) 
      s += find_and_include_asset_js(nam)
    }
  end


  def ensure_suffix(name, suffix)
    if not name.match(/#{Regexp.escape(suffix)}/)
      name + suffix
    else 
      name
    end
  end

  def name_array_to_load(name)
    names = name.split('/')
    names.inject([]) {|o, e|
      s = o.last ? "#{o.last}/#{e}" : "#{e}"
      o << s
    }
  end
end
