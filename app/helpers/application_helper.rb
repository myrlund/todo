module ApplicationHelper
  FLASH_TYPES = [:success, :notice, :error, :message]
  
  def title(page_title)
    content_for(:title) { page_title }
  end

  def translate_and_capitalize(text)
    translate(text).capitalize
  end
  
  def markdown(text)
    BlueCloth.new(text).to_html
  end
  
  def strip_tags(html)
    html.gsub(/<\/?[^>]*>/, "")
  end

  alias_method :T, :translate_and_capitalize
  alias_method :st, :strip_tags

  def display_flash(type = nil)
    if type.nil?
      flashes = FLASH_TYPES.collect { |name| display_flash(name) }
      flashes.join
    else
      message = flash[type]
      hide_link = content_tag(:a, "", :href => request.url, :class => :hide)
      content_tag(:div, hide_link + message, :class => "flash-#{type}") if flash[type]
    end
  end

  def active_page_class(page, css_class = 'active')
    return :class => css_class if current_page?(page)
    return {}
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:tail) { javascript_include_tag(*args) }
  end
  
  def coffee_script_include_tag(*sources)
    javascript_include_tag(*(sources.map { |js| "compiled/#{js}" }))
  end

end
