require 'station'
describe Station do

  subject(:station) {described_class.new("Tooting")}

  describe '#name' do
    it { is_expected.to respond_to(:name) }
  end

end
