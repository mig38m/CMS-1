galleriesCtrl = require("../../controllers/gallery/galleries")

module.exports = (app, prefix) ->
  #REST
  app.get(prefix + "/galleries", galleriesCtrl.all)
  app.post(prefix + "/galleries", galleriesCtrl.create)
  app.get(prefix + "/galleries/:id", galleriesCtrl.get)
  app.put(prefix + "/galleries/:id", galleriesCtrl.update)
  #app.del(prefix + "/galleries/:id", galleriesCtrl.del)
  app.post(prefix + "/galleries/:id", galleriesCtrl.addPhoto)