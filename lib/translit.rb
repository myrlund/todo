class Translit
  ASCII_APPROXIMATIONS = {
    198 => "AE",
    208 => "D",
    216 => "O",
    222 => "Th",
    223 => "ss",
    230 => "ae",
    240 => "d",
    248 => "o",
    254 => "th"
  }.freeze

  class << self
    # Sanitizes and dasherizes string to make it safe for URL's.
    #
    # Example:
    #
    #   slug.normalize('This... is an example!') # => "this-is-an-example"
    #
    # Note that the Unicode handling in ActiveSupport may fail to process some
    # characters from Polish, Icelandic and other languages.
    def normalize(slug_text)
      return "" if slug_text.nil? || slug_text == ""
      ActiveSupport::Multibyte.proxy_class.new(slug_text.to_s).normalize(:kc).
        gsub(/[\W]/u, ' ').
        strip.
        gsub(/\s+/u, '-').
        gsub(/-\z/u, '').
        downcase.
        to_s
    end

    # Remove diacritics (accents, umlauts, etc.) from the string. Borrowed
    # from "The Ruby Way."
    def strip_diacritics(string)
      a = ActiveSupport::Multibyte.proxy_class.new(string || "").normalize(:kd)
      a.unpack('U*').inject([]) { |a, u|
        if ASCII_APPROXIMATIONS[u]
          a += ASCII_APPROXIMATIONS[u].unpack('U*')
        elsif (u < 0x300 || u > 0x036F)
          a << u
        end
        a
      }.pack('U*')
    end
  end
end

class String
  def urlify
    Translit.normalize(Translit.strip_diacritics(self))
  end
end
