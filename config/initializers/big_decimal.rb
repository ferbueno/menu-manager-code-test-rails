require 'bigdecimal'

class BigDecimal
  def as_json(options = nil) #:nodoc:
    if finite?
      # Rounding to 6 decimals as a precaution for precision
      to_f.round(6)
    else
      NilClass
    end
  end

  def to_json(*args)
    as_json.to_json(*args)
  end
end
