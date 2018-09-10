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
      message = "Exceeded maximum card balance. Maximum is #{subject.maximum_balance}"
      expect { subject.top_up(subject.maximum_balance + 1) }.to raise_error message
    end
  end

  # context "when the users calls deduct" do
  #   it 'should remove the correct amount from the balance' do
  #     expect(subject.deduct(50)).to eq initial_balance - 50
  #   end
  # end

  context "when the users touches in" do
    # it 'should make the in_journey variable true' do
    #   subject.top_up(10)
    #   subject.touch_in
    #   expect(subject.in_journey?).to eq true
    # end

    it "should raise an error if the card balance is below minimum fare" do
      message = "Balance too low, minimum fare: £#{subject.minimum_fare}"
      expect { subject.touch_in }.to raise_error message
    end
  end

  context "when a user is already touched in" do
    # it 'the touch_out method should set in_journey to false' do
    #   subject.top_up(10)
    #   subject.touch_in
    #   subject.touch_out
    #   expect(subject.in_journey?).to eq false
    # end

    it "takes off the correct fare when they touch out" do
      subject.top_up(10)
      subject.touch_in
      expect { subject.touch_out }.to change{ subject.balance }.by(- subject.minimum_fare)
    end
  end


end
