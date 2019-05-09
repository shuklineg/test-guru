module GistsHelper
  def gist_url(name, id, options = {})
    link_to(name, "https://gist.github.com/#{id}", options.merge({ target: '_blank' }))
  end
end