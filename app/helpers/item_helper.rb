module ItemHelper
    def post_code_string(dest)
        "〒#{dest.post_code.slice(0..2)}-#{dest.post_code.slice(3..6)}"
    end

    def address_string(dest)
        pref = JpPrefecture::Prefecture.find(dest.prefecture_code).name
        "#{pref}#{dest.city}#{dest.street_number}#{dest.building_name}"
    end

    def recipient_name(dest)
        "#{dest.dest_family_name} #{dest.dest_first_name}"
    end
end