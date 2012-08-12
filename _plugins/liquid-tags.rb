module Jekyll
  class RenderTimeTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
    end

    def render(context)
      Time.now.strftime("%l:%M %p on %d %B %Y")
    end
  end
end

Liquid::Template.register_tag('rendertime', Jekyll::RenderTimeTag)

module Jekyll
  module EscapeSlugFilter
    def escape_slug(input)
      return input.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase
    end
  end
end

Liquid::Template.register_filter(Jekyll::EscapeSlugFilter)
