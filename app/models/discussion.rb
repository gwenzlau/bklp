class Discussion < ActiveRecord::Base
  belongs_to :book
  has_many :commentaries

  validates_presence_of :quote, :page, :pages_total

  def public_params
    {
      id:             id,
      book_id:        book_id,
      quote:          quote,
      page:           page,
      pages_total:    pages_total,
      created_at:     created_at,
      comments:       commentaries.to_a.map(&:public_params)
    }
  end
end
