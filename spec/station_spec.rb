require 'station'
describe Station do

  subject {described_class.new("Tooting", 1)}

  it 'returns its name' do
    expect(subject.name).to eq("Tooting")
  end

  it 'returns its zone' do
    expect(subject.zone).to eq(1)
  end
end
