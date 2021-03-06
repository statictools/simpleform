defmodule Simpleform.Router do
  use Simpleform.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  #pipeline :form_api do
    #plug :accepts, ["html", "json"]
  #end

  pipeline :api do
    plug :accepts, ["json"]
  end

  #scope "/form/", Simpleform do
    #pipe_through :form_api # Use the minimal pipeline needed

    #post "/:id", External.MessageController, :create
  #end

  scope "/", Simpleform do
    pipe_through :browser # Use the default browser stack

    get "/", FormController, :index
    #get "/", PageController, :index

    get "/registration/", RegistrationController, :index
    post "/registration/", RegistrationController, :create

    get "/sessions/new", SessionController, :new
    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :destroy

    resources "/forms", FormController
    resources "/messages", MessageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Simpleform do
    #   pipe_through :api
    # end
end
