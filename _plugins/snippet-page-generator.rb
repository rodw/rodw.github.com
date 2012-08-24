require 'yaml'
DEBUG = true
VERBOSE = DEBUG && false

module Jekyll

  class SnippetPageGenerator < Generator
    safe true
    priority :low
    def generate(site)
      site.write_snippet_pages
    end
  end

  class Site
    def write_snippet_pages
      DEBUG && puts("writing snippet pages")
      snippet_source_glob = File.join( self.source, self.config['snippet']['source']['dir'], self.config['snippet']['source']['glob']  )
      snippet_index_dest_dir = self.config['snippet']['dest']['index']['dir']
      snippet_tag_dest_dir = self.config['snippet']['dest']['tag']['dir']
      snippet_page_dest_dir = self.config['snippet']['dest']['page']['dir']
      list = []
      Dir.glob(snippet_source_glob) do |file|
        process_snippet_file( list, file )
      end

      DEBUG && puts("writing snippet tag pages")
      by_tag = organize_snippets_by_tag(list)
      # write each tag page
      by_tag.each_pair { |tag,snippets| 
        snippet_page = SnippetTagPage.new(self, self.source, snippet_tag_dest_dir, tag, snippets)
        snippet_page.render(self.layouts, site_payload)
        snippet_page.write(self.dest)
        self.pages << snippet_page
      }

      DEBUG && puts("writing individual snippet pages")
      # write each snippet page
      list.each { |snippet| 
        if(snippet.slug) 
          snippet_page = SnippetPage.new(self, self.source, snippet_page_dest_dir, snippet)
          snippet_page.render(self.layouts, site_payload)
          snippet_page.write(self.dest)
          self.pages << snippet_page
        end
      }

      DEBUG && puts("writing overall index page")
      # write overall index page
      index_page = SnippetIndexPage.new(self, self.source, snippet_index_dest_dir, by_tag)
      index_page.render(self.layouts, site_payload)
      index_page.write(self.dest)
      self.pages << index_page
      DEBUG && puts("done writing snippet pages")
    end

    def process_snippet_file(container,filename)
      DEBUG && puts("processing snippet datafile #{filename}")
      buffer = nil
      last_frontmatter = nil
      last_bodycontent = nil
      File.readlines(filename).each do |line|
        VERBOSE && puts("processing line: #{line}")
        if SNIPPET_DELIM =~ line 
          last_bodycontent = buffer
          fm = YAML.parse(last_frontmatter).to_ruby unless last_frontmatter.nil? || last_frontmatter.empty?
          container.push( Snippet.new(fm, last_bodycontent) ) unless last_bodycontent.nil? || last_bodycontent.empty?  || (!fm.nil? && fm['draft'])

          buffer = nil
          last_frontmatter = nil
          last_bodycontent = nil

        elsif SNIPPET_YAML_DELIM =~ line
          last_frontmatter = buffer
          buffer = nil
          last_bodycontent = nil
        else 
          unless buffer.nil?
            # buffer += "\n"
          else
            buffer = ''
          end
          buffer += line
        end
      end
      unless buffer.nil? || buffer.empty?
        last_bodycontent = buffer
        fm = YAML.parse(last_frontmatter).to_ruby unless last_frontmatter.nil? || last_frontmatter.empty?
        container.push( Snippet.new(fm, last_bodycontent) ) unless last_bodycontent.nil? || last_bodycontent.empty? || (!fm.nil? && fm['draft'])
      end
      DEBUG && puts("done processing snippet datafile #{filename}")
    end

    def organize_snippets_by_tag(list)       
      DEBUG && puts("organizing snipppets by tag")
      by_tag = {}
      list.each { |snippet|
        snippet.tags.each { |tag| 
          by_tag[tag] = [] if by_tag[tag].nil?
          by_tag[tag].push(snippet)
        }
      }
      return by_tag       
    end

  end

  class SnippetPage < Page
    def initialize(site, base, snippet_dir, snippet)
      DEBUG && puts("Initializing SnippetPage for #{snippet.title}.")
      @base = base
      @site = site
      @dir  = snippet_dir
      @name = snippet.slug.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase + ".md" 

      self.process(@name)

      if(snippet.content) 
        DEBUG && puts("snippet #{snippet.title} was already rendered")
      else
        DEBUG && puts("rendering snippet #{snippet.title}")
        self.content = snippet.body
        self.render({},{})
        snippet.content = self.output
      end
      self.data = {}

      self.data['title'] = snippet.title
      #self.data['description'] = ""
      self.data['layout'] = 'snippet-page'
      self.data['snippet'] = snippet
      DEBUG && puts("done initializing snippetpage.")
    end
  end

  SNIPPET_DELIM = /^####*\s*$/
  SNIPPET_YAML_DELIM = /^\^\^\^\^*\s*$/

  class SnippetTagPage < Page
    def initialize(site, base, snippet_dir, tag, snippets)
      DEBUG && puts("Initializing SnippetTagPage for #{tag}.")
      @base = base
      @site = site
      @dir  = snippet_dir
      @name = tag.label.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase + ".md" 
      self.process(@name)

      DEBUG && puts("about to render #{snippets.size} snippets")
      self.data = {}
      snippets.each { |snippet| 
        if(snippet.content) 
          DEBUG && puts("snippet #{snippet} was already rendered")
        else
          DEBUG && puts("rendering snippet #{snippet}")
          self.content = snippet.body
          self.render({},{})
          snippet.content = self.output
        end
      }       
      DEBUG && puts("rendered.")

      self.data = {}
      self.data['title'] = "#{snippets.size} #{tag.label} snippets"
      self.data['description'] = "Snippets tagged #{tag.label}"
      self.data['layout'] = 'snippet-tag'
      self.data['snippets'] = snippets
      self.data['snippet-count'] = snippets.size
      DEBUG && puts("done initializing page.")
    end
  end


  class SnippetIndexPage < Page
    def initialize(site, base, snippet_dir, snippets_by_tag)
      @base = base
      @site = site
      @dir  = snippet_dir
      @name = "index.md"
      self.process(@name)

      self.data = {}
      self.data['title'] = "Snippets"
      self.data['layout'] = 'snippet-index'

      tags = []
      snippets_by_tag.keys.sort.each { |tag|
        tags.push( { 'label'=>tag.label, 'count'=>snippets_by_tag[tag].size, 'link'=>tag.id } )
      }
      self.data['tags'] = tags

      one,two,three = tags.each_slice(  (tags.size/3.0).round ).to_a
      self.data['tags-one'] = one
      self.data['tags-two'] = two
      self.data['tags-three'] = three

      self.data['snippets'] = snippets_by_tag
    end
  end


  class SnippetTag
    include Comparable  
    attr_accessor :label, :id

    def initialize(label)
      @label = label
      @id = escape_slug(@label)
    end
    
    def escape_slug(input)
      return input.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase
    end

    def hash
      @id.hash
    end

    def to_liquid
      { "label" => @label, "id" => @id }
    end

    def to_s 
      "<SnippetTag:#{@id}:#{@label}}>"
    end

    def <=>(o)  
      self.class == o.class ? (id <=> o.id) : nil  
    end  

    def eql?(o)  
      self.class.equal?(o.class) && @id == o.id
    end  

    alias == eql?  

  end

  class Snippet

    attr_reader :tags, :body, :title, :slug
    attr_accessor :content
  
    def initialize(frontmatter,bodycontent)
      @frontmatter = frontmatter
      @tags = []
      @body = bodycontent
      unless(@frontmatter.nil?) 
        @slug = @frontmatter['slug']
        @title = @frontmatter['title']
        unless(@frontmatter['tags'].nil?)
          raw = @frontmatter.to_a
          @frontmatter['tags'].to_a.each { |tag| 
            @tags.push(SnippetTag.new(tag)) unless tag.to_s.strip.length == 0
          }
        end
      end 
    end

    def to_liquid
      map = { "title" => @title, "body" => @body, "content" => @content }.deep_merge(@frontmatter)
      map['tags'] = []
      @tags.each { |tag|
        map['tags'].push( tag.to_liquid )
      }
      return map
    end
  end

end
DEBUG && puts("snippet-page-generator loaded")
