# frozen_string_literal: true

class TennisGame4
  ALL = "All"
  LOVE = "Love"
  DEUCE = "Deuce"
  SCORE_DICT = {
    0 => LOVE,
    1 => "Fifteen",
    2 => "Thirty",
    3 => "Forty",
  }.freeze

  def initialize player1, player2
    @player1 = player1
    @player2 = player2
    @p1points = 0
    @p2points = 0
  end

  def won_point player_name
    if player_name == player1
      p1Score
    else
      p2Score
    end
  end

  def score
    case [@p1points, @p2points]
    in points1, ^points1 if points1 <= 2 then combine_score SCORE_DICT[points1], ALL
    in points1, ^points1 then DEUCE
    in 0, points2 if points2 <= 3 then combine_score LOVE, SCORE_DICT[points2]
    in points1, 0 if points1 <= 3 then combine_score SCORE_DICT[points1], LOVE
    in points1, points2 if points1 <= 3 and points2 <= 3 then combine_score SCORE_DICT[points1], SCORE_DICT[points2]
    in points1, points2 if points1 - points2 >= 2 then win_for player1
    in points1, points2 if points2 - points1 >= 2 then win_for player2
    in points1, points2 if points1 - points2 == 1 then advantage player1
    in points1, points2 if points2 - points1 == 1 then advantage player2
    else
      "no match"
    end
  end

  def p1Score
    @p1points +=1
  end

  def p2Score
    @p2points +=1
  end

  private

  attr_reader :player1, :player2

  def combine_score score1, score2
    [score1,score2].join "-"
  end

  def win_for player
    "Win for #{player}"
  end

  def advantage player
    "Advantage #{player}"
  end
end
