# GET home page.


exports.index = (req, res) ->
  res.render 'home', { pageTitle: 'Realtime Messaging Test' }