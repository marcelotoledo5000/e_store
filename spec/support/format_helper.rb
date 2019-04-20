module FormatHelper
  # Format datetime
  def formatted_date(date)
    Time.zone.at(date.to_datetime).strftime('%Y-%m-%dT%l:%M:%S%z')
  end
end
