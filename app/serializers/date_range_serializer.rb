class DateRangeSerializer
  include FastJsonapi::ObjectSerializer
    def self.range_revenue(revenue)
      {
        data: {
          id: 'null',
          attributes: {
            revenue: revenue
          }
        }
      }
    end
end
