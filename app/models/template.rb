# frozen_string_literal: true

class Template < ApplicationRecord
  belongs_to :shop
  has_many :emails
  before_save :replace_quote_entities_with_escape_characters, :test_insert

  validates_presence_of :shop_id

  # old method
  # def replace_quote_entities_with_escape_characters
  #   self.html = html.gsub('&quot;', '"').gsub('&ldquo;', '"').gsub('&rdquo;', '"').gsub('&lsquo;', '"').gsub('&rsquo;', '"').gsub('&lt;', '<').gsub('&gt;', '>').gsub(/&amp;/i, '&').gsub(/&nbsp;/i, '')
  # end

  # method from non-embedded
  # def replace_quote_entities_with_escape_characters
  #   self.html = html.gsub('&quot;', '"').gsub('&ldquo;', '"').gsub('&rdquo;', '"').gsub('&lsquo;', '"').gsub('&rsquo;', '"').gsub('&lt;', '<').gsub('&gt;', '>').gsub('&nbsp;', ' ').gsub('{{', '<%=').gsub('}}', '%>')
  # end


  def test_insert
    html.insert(5819, '<%= shop.shopify_domain %>')
  end
end
