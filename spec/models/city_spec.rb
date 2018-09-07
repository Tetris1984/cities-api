require 'rails_helper'

RSpec.describe City, type: :model do
  it { should belong_to(:country) }
  it { should validate_presence_of(:name) }
end
