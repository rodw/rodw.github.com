fs                  = require 'fs'
path                = require 'path'
HOMEDIR             = path.join(__dirname,'..')
LIB_COV             = path.join(HOMEDIR,'lib-cov')
LIB_DIR             = if fs.existsSync(LIB_COV) then LIB_COV else path.join(HOMEDIR,'lib')
marked              = require 'meta-marked'
CommonDustjsHelpers = require('common-dustjs-helpers').CommonDustjsHelpers
klei_dust           = require 'klei-dust'
dust_helpers        = new CommonDustjsHelpers()
FileUtil            = require('inote-util').FileUtil
Util                = require('inote-util').Util
ObjectUtil          = require('inote-util').ObjectUtil
shelljs             = require 'shelljs'

CONTENT_DIR         = path.join(HOMEDIR,"content")
SITE_DIR            = path.join(HOMEDIR,"site")
TEMPLATE_DIR        = path.join(HOMEDIR,"templates")
DEFAULT_TEMPLATE    = "markdown.dust"
SNIPPET_TAG_TEMPLATE    = "snippets-by-tag.dust"
SNIPPET_INDEX_TEMPLATE    = "snippet-index.dust"

class Scratch
  snippet_list: []
  snippets_by_tag: {}
  
  main:()=>
    start = Date.now()
    @prep_site_dir ()=>
      dust_helpers.export_helpers_to(klei_dust.getDust())
      files = @list_files_in_directory CONTENT_DIR
      action = (file, index, list, next)=>
        @handle_input_file file, null, (err,dest)=>
          if err?
            console.error "ERROR while processing #{file}.", err
          else
            if Array.isArray(dest)
              for pair,i in dest
                if pair[0]?
                  console.error "ERROR while processing #{file} part #{i+1}.", pair[0]
                else
                  console.log "Generated #{pair[1]} from #{file} part #{i+1}."
            else if dest?
              console.log "Generated #{dest} from #{file}."
            else
              console.log "File #{file} processed. No file output (yet)."
          next()
      Util.for_each_async files, action, ()=>
        @process_snippets ()=>
          finish = Date.now()
          elapsed = (finish - start)/1000
          console.log "DONE.\nElapsed time: #{elapsed} seconds."
      
  process_snippets:(callback)=>
    unless @snippet_list?.length > 0
      callback()
    else
      # generate individual snippet pages
      action = (snippet,index,list,next)=>
        snippet.permalink = "/snippets/#{snippet.slug}.html"
        @render_dust_to_file null, snippet, (err,dest)=>
          if err?
            console.error "ERROR while processing snippet:",err
          else
            console.log "Generated #{dest} from collected snippet."
          next()
      Util.for_each_async @snippet_list, action, ()=>
        # generate snippet tag pages
        tags = Object.keys(@snippets_by_tag)
        action = (tag,index,list,next)=>
          ctx = ObjectUtil.shallow_clone(@make_default_context())
          ctx.tag_name = tag
          ctx.active_tab = 'snippets'
          ctx.snippet_count = @snippets_by_tag[tag].length
          ctx.snippets = @snippets_by_tag[tag]
          ctx.slug = "tag-#{tag}"
          ctx.source_file = @snippets_by_tag[tag][0]?.source_file
          @render_dust_to_file SNIPPET_TAG_TEMPLATE, ctx, (err, dest)=>
            if err?
              console.error "ERROR while processing tag:",tag,err
            else
              console.log "Generated #{dest} from collected snippets for tag #{tag}."
            next()
        Util.for_each_async tags, action, ()=>
          # generate tag index page
          keys = Object.keys(@snippets_by_tag).sort()
          tags = []
          for key in keys
            tags.push {name:key,count:@snippets_by_tag[key].length}
          ctx = ObjectUtil.shallow_clone(@make_default_context())
          ctx.tags = tags
          ctx.active_tab = 'snippets'
          ctx.slug = "site/snippets/index"
          ctx.snippet_count = @snippet_list.length
          ctx.tag_count = keys.length
          @render_dust_to_file SNIPPET_INDEX_TEMPLATE, ctx, (err, dest)=>
            if err?
              console.error "ERROR while processing snippet index.",err
            else
              console.log "Generated #{dest} as tag index from collected snippets."
            callback()
      
  handle_input_file:(file,base_context,callback)=>
    base_context = @make_default_context(base_context)
    base_context = ObjectUtil.shallow_clone(base_context)
    @markdown_from_file file, (err, markdown)=>
      if markdown?.meta?.file_type is 'snippet'
        @handle_snippet_file file, base_context, markdown._raw, callback
      else if markdown?.meta?.file_type is 'delimited'
        @markdown_list_from_delimited_string markdown._raw, (err,results)=>
          shared_context = results?[0]?.meta?.context
          if shared_context?
            for n,v of shared_context
              base_context[n] = v
          results.shift()
          base_context.content = results.map (r)->r.html
          @generate_single_file_from_source file, base_context, markdown, callback
      else
        @generate_single_file_from_source file, base_context, markdown, callback

  handle_snippet_file:(file, base_context, raw_text, callback)=>
    # convert source file to markdown list and base context
    @markdown_list_from_delimited_string raw_text, (err,markdowns)=>
      shared_context = markdowns?[0]?.meta?.context
      if shared_context?
        for n,v of shared_context
          base_context[n] = v
      markdowns.shift()
      # generate markdown documents
      contexts = []
      action = (markdown,index,list,next)=>
        @generate_dust_context_from_parsed_markdown file, base_context, markdown, (err, ctx)=>
          if err?
            console.error "ERROR: #{err} WHILE PROCESSING THE FOLLOWING MARKDOWN OBJECT",JSON.stringify(markdown)
          else
            contexts.push ctx
          next()
      Util.for_each_async markdowns, action, ()=>
        # snippet contexts to master list for later processing
        for context in contexts
          @snippet_list.push context
          if context?.tags?.length > 0
            for tag in context?.tags
              @snippets_by_tag[tag] ?= []
              @snippets_by_tag[tag].push context
          else
            @snippets_by_tag.untagged ?= []
            @snippets_by_tag.untagged.push context
        console.log "Added #{contexts.length} snippets parsed from #{file}."
        callback()
    
  generate_multiple_files_from_source:(file, base_context, raw_text, callback)=>
    base_context = @make_default_context(base_context)
    parts = @split_delimited_string_into_parts(raw_text)
    base = parts.shift()
    @markdown_from_string base, (err, markdown)=>
      shared_context = markdown?.meta?.context
      if shared_context?
        for n,v of shared_context
          base_context[n] = v
      results = []
      first_error = null
      action = (text, index, list, next)=>
        @markdown_from_string text, (err, markdown)=>
          if err?
            first_error ?= err
            results.push [err,null]
            next()
          else
            @generate_single_file_from_source file, base_context, markdown, (err,dest)=>
              if err?
                first_error ?= err
              results.push [err,dest]
              next()
      Util.for_each_async parts, action, ()=>
        callback first_error, results
          
  generate_single_file_from_source:(file, base_context, markdown, callback)=>
    @generate_dust_context_from_parsed_markdown file, base_context, markdown, (err, context)=>
      if err?
        callback(err)
      else
        @render_dust_to_file null, context, callback

  render_dust_to_file:(template,context,callback)=>
    dest = @to_dest(context)
    @render_dust template, context, (err,content)=>
      if err?
        callback(err)
      else
        @write_to_file dest, content, (err)=>
          if err?
            callback err, null
          else
            callback null, dest
                
  generate_dust_context_from_parsed_markdown:(source_file,base_context,markdown,callback)=>
    base_context ?= {}
    base_context = ObjectUtil.shallow_clone base_context
    if markdown?.meta?
      for k,v of markdown.meta
        base_context[k] = v
    base_context.content ?= markdown.html if markdown?.html?
    base_context.source_file = source_file
    callback null, base_context
            
  # clean and recreates default `site` directory based on contents of `web/public`
  prep_site_dir:(callback)=>
    console.log "Removing existing files from './site' directory."
    FileUtil.rmdir "site"
    console.log "Seeding './site' directory with files from './web/public'."
    shelljs.cp '-r', 'web/public/*', 'site'
    callback()

  #############################################################################
  ## UTILITIES
  #############################################################################
  
  _format_time:(dt)->
    dt ?= new Date()
    buf = ""
    h = ((dt.getHours() + 11) % 12 + 1)
    buf += h
    buf += ":"
    m = dt.getMinutes()
    if m < 10
      m = "0#{m}"
    buf += m
    buf += " "
    if dt.getHours() > 12
      buf += "PM"
    else
      buf += "AM"
    return buf
  
  _format_date:(dt)->
    dt ?= new Date()
    buf = "#{dt.getUTCDate()} "
    switch dt.getUTCMonth()
      when  0
        buf += "Jan"
      when  1
        buf += "Feb"
      when  2
        buf += "Mar"
      when  3
        buf += "Apr"
      when  4
        buf += "May"
      when  5
        buf += "Jun"
      when  6
        buf += "Jul"
      when  7
        buf += "Aug"
      when  8
        buf += "Sep"
      when  9
        buf += "Oct"
      when 10
        buf += "Nov"
      when 11
        buf += "Dec"
    buf += " #{dt.getUTCFullYear()}"
    return buf
    
  make_default_context:(context={})=>
    context.YEAR = (new Date()).getFullYear()
    context.NOW = (new Date())
    context.YEAR = context.NOW.getUTCFullYear()
    context.DATE_FORMATTED = @_format_date(context.NOW)
    context.TIME_FORMATTED = @_format_time(context.NOW)
    return context

  # determines the proper destination file for the given metadata
  to_dest:(context)=>
    if context?.slug?
      slug = path.join(path.dirname(context.source_file),context.slug)
      return @_slug_to_dest(slug)
    else
      return @_src_to_dest(context.source_file)
    
  # identifies the proper destination file for the given slug value
  _slug_to_dest:(slug)=>
    dest = path.join(SITE_DIR,path.relative(CONTENT_DIR,slug))
    unless /\.[a-z]+/i.test dest
      dest += ".html"
    return dest

  # identifies the proper destination file for the given source file
  _src_to_dest:(src)=>
    dest = path.join(SITE_DIR,path.relative(CONTENT_DIR,src))
    dest = path.join(path.dirname(dest),"#{path.basename(dest,".md")}.html")
    return dest

  # returns a recursive directory listing
  list_files_in_directory:(dir)=>
    results = []
    fs.readdirSync(dir).forEach (file)=>
      file = path.join(dir,file)
      stat = fs.statSync file
      if stat?.isDirectory()
        results = results.concat(@list_files_in_directory(file))
      else if /\.md$/.test file
        results.push file
    return results
    
  split_delimited_string_into_parts:(raw_text)=>
    delimiter = /\n=====+\n/
    parts = raw_text.split delimiter
    return parts

  # returns a meta-markdown result object parsed from the given file
  markdown_from_file:(file,callback)=>
    fs.readFile file, (err,buffer)=>
      if err?
        callback(err)
      else
        @markdown_from_string buffer, callback
  
  # returns a meta-markdown result object parsed from the given string or buffer
  markdown_from_string:(buffer,callback)=>
    source = buffer.toString()
    markdown = marked source.trim(), {}
    markdown._raw = source
    callback null, markdown

  # returns a list of meta-markdown result objects parsed the delimited parts of the given string
  markdown_list_from_delimited_string:(raw_text,callback)=>
    results = []
    parts = @split_delimited_string_into_parts(raw_text)
    action = (part,index,list,next)=>
      @markdown_from_string part, (err, markdown)=>
        results.push markdown
        next()
    Util.for_each_async parts, action, ()=>
      callback null, results

  # generate the dust output from the given template text and context object
  render_dust:(template,context,callback)=>
    if context?.date?
      context.date = @_format_date(context.date)
    template ?= context?.template ? DEFAULT_TEMPLATE
    template = path.join(TEMPLATE_DIR,template)
    klei_dust.dust template, context, callback

  write_to_file:(dest,content,callback)=>
    FileUtil.mkdir path.dirname(dest)
    fs.writeFile dest,content,callback

scratch = new Scratch()
scratch.main()
    
