class Template < ApplicationRecord
  belongs_to :shop
  before_save :replace_quote_entities_with_escape_characters, :test_insert

  def replace_quote_entities_with_escape_characters
    self.html = html.gsub("&quot;", "\"").gsub("&ldquo;", "\"").gsub("&rdquo;", "\"").gsub("&lsquo;", "\"").gsub("&rsquo;", "\"").gsub("&lt;", "<").gsub("&gt;", ">").gsub(/&amp;/i,"&").gsub(/&nbsp;/i,"")
  end

  def test_insert
    html.insert(5819 ,'<%= shop.shopify_domain %>')
  end
end
