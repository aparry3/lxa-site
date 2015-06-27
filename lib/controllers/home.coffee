@HomeController = AppController.extend
    waitOn: ->
      return @subscribe "officers"
    data:
      officers: Officers.find {}
    onAfterAction: ->
      Meta.setTitle "Home"
