Router.route "/",
  name: "home"

Router.route "dashboard",
  name: "dashboard"

Router.route "/posts/create",
  name: "createPost"

Router.route "/brothers",
  name: "brothers"

Router.plugin "ensureSignedIn",
  only: ["dashboard"]
