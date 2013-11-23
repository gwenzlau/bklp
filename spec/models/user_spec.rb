require 'spec_helper'

describe User do

  subject(:user) { FactoryGirl.build(:user) }

  it { should have_many :commentaries }

end
