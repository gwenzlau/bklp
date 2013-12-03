class Discussion < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_many :commentaries, dependent: :destroy

  validates_presence_of :quote, :page, :pages_total, :user, :message

  def public_params
    {
      id:             id,
      book_id:        book_id,
      quote:          quote,
      message:        message,
      page:           page,
      pages_total:    pages_total,
      percentage:     percentage,
      created_at:     created_at,
      user:           user.public_params,
      comments:       commentaries.to_a.map(&:public_params)
    }
  end

  def percentage
    ((page.to_f / pages_total.to_f) * 100).round(2)
  end
end
