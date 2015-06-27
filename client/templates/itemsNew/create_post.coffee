AutoForm.hooks
  "items-new-form":
    onSuccess: (operation, result, template) ->
      toast "Post created successfully!"
      Router.go "dashboard"
