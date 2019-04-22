module FormatHelper
  # Format datetime to '%Y-%m-%dT%l:%M:%S%z' => '20190420T00:00:00-0000'
  def formatted_date(date)
    Time.zone.at(date.to_datetime).strftime('%Y-%m-%dT%l:%M:%S%z')
  end

  # Format currency to xx.dd => '13.60'
  def formatted_currency(currency)
    format('%.2f', currency)
  end
end
