class SagarinParser
  attr_reader :results

  def initialize
    @results = {}
    @matches = []
  end

  def parse_row(row)
    name_regex = /([a-z]+)\s?/i
    predictors = /\d\d\.\d\d\s+\d/
    records = /\s(\d\d?\d?\s+\d\d?\d?)/
    schedule_rank = /\d\d.\d\d\(\s+\d\d?\)/
    rating_regex = /\=[[:space:]]+(\d\d\.\d\d)/

    patterns = [name_regex, rating_regex, records, schedule_rank, predictors]

    @matches = patterns.each.inject([]) do |h, p|
      h << row.scan(p)
    end

    schedule
    golden_mean
    predictor
    pure_elo
    overall_record
    record_vs_top_10
    record_vs_top_16
    team_name
    overall_rating

    @results
  end

  private

  def overall_record
    wins, losses = @matches[2].first.first.split
    @results[:overall_record] = [wins.to_i, losses.to_i]
  end

  def record_vs_top_10
    wins, losses = @matches[2][1].first.split
    @results[:record_vs_top_10] = [wins.to_i, losses.to_i]
  end

  def record_vs_top_16
    wins, losses = @matches[2][2].first.split
    @results[:record_vs_top_16] = [wins.to_i, losses.to_i]
  end

  def team_name
    @results[:team_name] = @matches.first.flatten.join(' ')
  end

  def overall_rating
    @results[:overall_rating] = @matches[1].first.first.to_f
  end

  def schedule
    normalize_schedule = @matches[3][0].gsub(/[\(\)]/, '')
    schedule_rating, schedule_ranking = normalize_schedule.split
    @results[:schedule_rating] = schedule_rating.to_f
    @results[:schedule_ranking] = schedule_ranking.to_i
  end

  def golden_mean
    golden_mean_rating, golden_mean_ranking = @matches[4][0].split
    @results[:golden_mean_rating] = golden_mean_rating.to_f
    @results[:golden_mean_ranking] = golden_mean_ranking.to_i
  end

  def predictor
    predictor_rating, predictor_ranking = @matches[4][1].split
    @results[:predictor_rating] = predictor_rating.to_f
    @results[:predictor_ranking] = predictor_ranking.to_i
  end

  def pure_elo
    pure_elo_rating, pure_elo_ranking = @matches[4][2].split
    @results[:pure_elo_rating] = pure_elo_rating.to_f
    @results[:pure_elo_ranking] = pure_elo_ranking.to_i
  end
end

