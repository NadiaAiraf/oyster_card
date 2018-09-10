require 'oyster_card'

describe OysterCard do
  it 'should respond to balance queries' do
    expect(subject.balance).to eq 0
  end
end
