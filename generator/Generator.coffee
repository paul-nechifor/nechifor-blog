async = require 'async'
fs = require 'fs'
jade = require 'jade'
marked = require 'marked'
minifyHtml = require('html-minifier').minify
path = require 'path'
yaml = require 'js-yaml'

module.exports = class Generator
  constructor: (@info, @postsDir, @outDir, @templatesDir) ->
    @minifyHtmlOptions =
      removeComments: true
      collapseWhitespace: true
      caseSensitive: true
    @markdownVariables = {}
    marked.setOptions
      smartypants: true

  generate: (cb) ->
    fs.readdir @postsDir, (err, files) =>
      return cb err if err
      files = files.filter (f) -> f.indexOf('.md') is f.length - 3
      files = files.map (f) => @postsDir + '/' + f
      async.map files, @generatePost.bind(@), (err, @posts) =>
        return cb err if err
        index = new Index @
        index.write cb

  generatePost: (file, cb) ->
    post = new Post @, file
    post.generate (err) ->
      return cb err if err
      post.write (err) ->
        return cb err if err
        cb null, post

class Page
  constructor: (@gen, @template, @id) ->
    @locals = {gen: @gen, page: @}

  generate: (cb) -> cb 'not-implemented'

  write: (cb) ->
    templatePath = "#{@gen.templatesDir}/#{@template}.jade"
    jade.renderFile templatePath, @locals, (err, out) =>
      return cb err if err
      fs.writeFile "#{@gen.outDir}/#{@id}.html", out, cb

  hasCover: -> !!@cover

  getCoverClasses: -> 'cover cover' + @cover

  getCoverPath: -> @gen.info.app.paths.static + '/covers/' + @id + '.png'

class Post extends Page
  constructor: (gen, @file) ->
    super gen, 'post', path.basename @file, '.md'

  generate: (cb) ->
    fs.readFile @file, 'utf8', (err, str) =>
      return cb err if err
      middle = str.indexOf '---', 4
      @yamlData = str.substring 4, middle
      @markdown = str.substring middle + 4
      @processMarkup()
      cb()

  processMarkup: ->
    @info = yaml.safeLoad @yamlData
    @cover = @info.cover if @info.cover
    @markdown = @expandMarkdownVariables @markdown
    @html = marked @markdown
    @html = minifyHtml @html, @gen.minifyHtmlOptions

  expandMarkdownVariables: (text) ->
    for key, value of @gen.markdownVariables
      text = text.replace new RegExp('@@' + key + '@@', 'g'), value
    text

class Index extends Page
  constructor: (gen) ->
    super gen, 'index', 'index'
