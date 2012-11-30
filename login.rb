require "pry"
require "mongo"
require "json"
require "symbolmatrix"
require "sinatra/base"
require "haml"
require "rack/flash"


class Login < Sinatra::Base

set :haml, :format => :html5
enable :sessions
use Rack::Flash

  get '/' do
    @flash = flash[:notice]
    haml :index
  end

  post '/resultat' do
    session[:username] = params[:inputUsername]
    session[:email] = params[:inputEmail]
    session[:password] = params[:inputPassword]
    session[:inputPasswordConfirm] = params[:inputPasswordConfirm]
    session[:session_id] = env['rack.session']['session_id']

    to_be_inserted = { "login" => session[:username], "email" => session[:email], "password" => session[:password] }
    
    if session[:password] == session[:inputPasswordConfirm] && not_in_db?
      session[:mongo_id] = coll.insert(to_be_inserted)
      redirect '/resultat'
    else
      #binding.pry
      flash[:notice] = "password doesnt match or email is already_in_db !!"
      redirect '/'
    end
    #binding.pry
  end

  get '/resultat' do

    @username = session[:username]
    @email = session[:email]
    @password = session[:password]
    @passwordConfirm = session[:inputPasswordConfirm]
    
    @test = coll.find_one("_id" => session[:mongo_id])
    @parsedTest = SymbolMatrix.new(@test)

    #binding.pry
    haml :resultat
  end

helpers do
  def client
    client ||= Mongo::Connection.new("mongocfg1.fetcher")
  end
  def db
    db ||= client["test"]
  end
  def coll
    coll ||= db["users"]
  end
  def not_in_db?
    coll.find_one( "email" => session[:email] ).nil?
  end
end


end
