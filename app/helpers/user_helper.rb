module UserHelper
    def months_collection
      ["01","02","03","04","05","06","07","08","09","10","11","12"]
    end

    def years_collection
      current_year = Date.today.year
      years_collection_list = []
      for y in 0..10 do
          years_collection_list << {yy: (current_year + y - 2000).to_s, yyyy: (current_year + y).to_s}
      end
      years_collection_list
    end

    def card_brands
      { "logo/visa.svg":            {"height": "20", "width": "49"},
        "logo/master-card.svg":     {"height": "20", "width": "34"},
        "logo/saison-card.svg":     {"height": "20", "width": "30"},
        "logo/jcb.svg":             {"height": "20", "width": "32"}, 
        "logo/american_express.svg":{"height": "20", "width": "21"},
        "logo/dinersclub.svg":      {"height": "20", "width": "32"},
        "logo/discover.svg":        {"height": "20", "width": "32"},
      }
    end

end  