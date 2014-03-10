require_relative 'sagarin_parser'
require 'pry'

describe SagarinParser do
  before(:all) do
    parser = SagarinParser.new
    data = "1  Oklahoma City Thunder   =  97.06   46  15   90.18(  14)   15   8  |   23  11  |   97.15    1 |   96.71    2 |   97.92    1"
    @results = parser.parse_row(data)
  end

  it 'returns the overall record' do
    expect(@results.fetch(:overall_record)).to eq([46, 15])
  end

  it 'returns record vs top 10' do
    expect(@results.fetch(:record_vs_top_10)).to eq([15, 8])
  end

  it 'returns record vs top 16' do
    expect(@results.fetch(:record_vs_top_16)).to eq([23, 11])
  end

  it 'returns team name' do
    expect(@results.fetch(:team_name)).to eq("Oklahoma City Thunder")
  end

  it 'returns rating' do
    expect(@results.fetch(:overall_rating)).to eq(97.06)
  end

  it 'returns schedule rating' do
    expect(@results.fetch(:schedule_rating)).to eq(90.18)
  end

  it 'returns schedule ranking' do
    expect(@results.fetch(:schedule_ranking)).to eq(14)
  end

  it 'returns golden mean rating' do
    expect(@results.fetch(:golden_mean_rating)).to eq(97.15)
  end

  it 'returns predictor rating' do
    expect(@results.fetch(:predictor_rating)).to eq(96.71)
  end

  it 'returns pure elo rating' do
    expect(@results.fetch(:pure_elo_rating)).to eq(97.92)
  end

end
