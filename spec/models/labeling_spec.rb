require 'rails_helper'

RSpec.describe Labeling, tyoe: :model do
  it { is_expected.to belong_to :labelable }
end
