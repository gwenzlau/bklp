class Discussion < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :commentaries

  validates_presence_of :quote, :page, :pages_total

  def public_params
    {
      id:             id,
      book_id:        book_id,
      quote:          quote,
      message:        message,
      page:           page,
      pages_total:    pages_total,
      percentage:     ((page / pages_total) * 100).round(2),
      created_at:     created_at,
      user:           user.public_params,
      comments:       commentaries.to_a.map(&:public_params)
    }
  end
end
