module Web::Views
  module MetaTags
    def meta_tag_description
      default_metas['description']
    end

    def meta_tag_image
      escape_url asset_url('meta-banner.jpg')
    end

    def meta_tag_page_title
      "#{default_metas['project_name']} - #{default_metas['baseline']}"
    end

    def meta_tag_site_name
      default_metas['project_name']
    end

    def meta_tag_title
      default_metas['project_name']
    end

    def meta_tag_twitter
      default_metas['twitter']
    end

    def meta_tag_url
      escape_url params.env['REQUEST_URI']
    end

    private

    def default_metas
      @default_metas ||= YAML.load_file(Hanami.root.join('config/meta_tags.yml'))
    end
  end
end
