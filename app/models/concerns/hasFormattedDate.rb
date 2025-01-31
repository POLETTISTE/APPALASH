module HasFormattedDate
  extend ActiveSupport::Concern

  def formatted_year
    I18n.l(date, format: "%Y") # Ex: "2023", "2024", "2025"
  end
  def formatted_month
    I18n.l(date, format: "%b").upcase # Ex: "JAN", "FEB", "MAR"
  end

  def formatted_day
    I18n.l(date, format: "%d") # Ex: "01", "02", "03"
  end
end