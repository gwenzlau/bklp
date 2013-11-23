require 'spec_helper'

describe Discussion do

  it { should belong_to :book }
  it { should have_many :commentaries }
  it { should validate_presence_of :quote }
  it { should validate_presence_of :page }
  it { should validate_presence_of :pages_total }

end
