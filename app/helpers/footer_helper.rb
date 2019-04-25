module FooterHelper
  def current_year
    Date.current.year
  end

  def github_url(name, url)
    link = link_to('TestGuru', url, target: '_blank')
    "#{name}<#{link}>".html_safe
  end
end
