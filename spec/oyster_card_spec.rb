require 'oyster_card'
require 'pry'

describe OysterCard do

  let(:earls_court) { double :earls_court }
  let(:aldgate) { double :aldgate }
  let(:journey) { double :journey }
  let(:mock_journey) { double :mock_journey }
  let(:mock_station) { double :mock_station }
  subject { described_class.new(journey_record: journey, station_type: mock_station) }

  before(:each) do
    allow(journey).to receive(:new).and_return mock_journey
    allow(mock_journey).to receive(:set_start)
    allow(mock_journey).to receive(:set_end)
    allow(mock_journey).to receive(:fare).and_return 2
    allow(mock_journey).to receive(:start_point).and_return earls_court
    allow(mock_journey).to receive(:end_point).and_return aldgate

    allow(earls_court).to receive(:name).and_return("earls court")
    allow(aldgate).to receive(:name).and_return("aldgate")
    subject.top_up(20)
  end

  context "on instantiation" do
    it 'should have an empty journey history' do
      expect(subject.journey_history).to eq []
    end

    it 'should respond to balance queries' do
      expect(subject.balance).to eq 20
    end

    xit 'should be able to change the maximum balance' do
    end
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

    it 'should store the entry station in start_point' do
      subject.touch_in(earls_court)
      expect(subject.in_journey.start_point).to eq earls_court
    end

    it "should raise an error if the card balance is below minimum fare" do
      oyster = OysterCard.new
      message = "Balance too low, minimum fare: £#{oyster.minimum_fare}"
      expect { oyster.touch_in('earls court') }.to raise_error message
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
      subject.touch_in(earls_court)
      expect { subject.touch_out(aldgate) }.to change { subject.balance }.by(-2)
    end

    it "makes an entry station nil when we touch out" do
      subject.touch_in(earls_court)
      subject.touch_out(aldgate)
      expect(subject.start_point).to eq nil
    end

    it 'puts the journey details into the journey history when they touch out' do
      subject.touch_in(earls_court)
      subject.touch_out(aldgate)
      expect(subject.journey_history).to eq [mock_journey]
    end
  end

end
