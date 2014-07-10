module.exports =
  changers:
    preRouter: (express, app) ->
      express.use app.rootHref, (req, res, next) ->
        req.url += '.html' unless req.url is '/'
        next()
