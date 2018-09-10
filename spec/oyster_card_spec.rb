require 'oyster_card'

describe OysterCard do
  it 'should respond to balance queries' do
    expect(subject.balance).to eq 0
  end

  it 'should be able to change the maximum balance' do

  end

  context "when the user calls top_up" do
    it 'should check that the balance increases by the right amount' do
      initial_balance = subject.balance
      expect(subject.top_up(50)).to eq initial_balance + 50
    end

    it 'fails if the maximum balance is exceeded' do
      message = "Exceeded maximum card balance"
      expect { subject.top_up(subject.maximum_balance + 1) }.to raise_error message
    end
  end
end
