class ChangeBookTypeForRecommend < ActiveRecord::Migration
  def up
     connection.execute(%q{
    alter table recommends
    alter column item_id
    type integer using cast(number as integer)
  })
  end
  def end
  end
end