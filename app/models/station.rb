class Station < ActiveRecord::Base
  belongs_to :city
  has_many   :trips_started, :class_name => "Trip", :foreign_key => "start_station_id"
  has_many   :trips_ended,   :class_name => "Trip", :foreign_key => "end_station_id"
  validates  :name, presence: true
  validates  :city, presence: true
  validates  :dock_count, presence: true
  validates  :installation_date, presence: true

  def self.average_bikes_per_station
    average(:dock_count).round(0).to_i
  end

  def self.with_most_bikes
    where(dock_count: maximum(:dock_count)).order(:name)
  end

  def self.with_fewest_bikes
    where(dock_count: minimum(:dock_count)).order(:name)
  end

end
