async = require 'async'
fs = require 'fs'
jade = require 'jade'
marked = require 'marked'
minifyHtml = require('html-minifier').minify
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
      goodFiles = files.filter (f) -> f[0] isnt '.'
      async.map goodFiles, @generatePost.bind(@), (err, @posts) =>
        return cb err if err
        @writeIndex cb

  generatePost: (file, cb) ->
    full = @postsDir + '/' + file
    id = file.split('.')[0]
    post = new Post @, id, full
    post.generate (err) ->
      return cb err if err
      cb null, post

  writeIndex: (cb) ->
    @writeJade 'index', {gen: @}, 'index', cb

  writeJade: (templateName, locals, id, cb) ->
    template = @templatesDir + '/' + templateName + '.jade'
    jade.renderFile template, locals, (err, out) =>
      return cb err if err
      fs.writeFile "#{@outDir}/#{id}.html", out, cb

class Post
  constructor: (@gen, @id, @file) ->

  generate: (cb) ->
    fs.readFile @file, 'utf8', (err, str) =>
      return cb err if err
      middle = str.indexOf '---', 4
      @yamlData = str.substring 4, middle
      @markdown = str.substring middle + 4
      @processMarkup cb

  processMarkup: (cb) ->
    @info = yaml.safeLoad @yamlData
    @markdown = @expandMarkdownVariables @markdown
    @html = marked @markdown
    @html = minifyHtml @html, @gen.minifyHtmlOptions
    @gen.writeJade @info.type, {post: @, gen: @gen}, @id, cb

  expandMarkdownVariables: (text) ->
    for key, value of @gen.markdownVariables
      text = text.replace new RegExp('@@' + key + '@@', 'g'), value
    text
