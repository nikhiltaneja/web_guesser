require 'sinatra'
require 'sinatra/reloader'

set :secret, rand(100)
set :guesses, 5

def check_guess(number, guess)
  if guess == number
    @color = "green"
    "You got it right! The SECRET NUMBER is #{number}."
  elsif guess > (number + 5)
    @color = "red"
    "Way too high!"
  elsif guess > number
    @color = "pink"
    "Too high!"
  elsif guess < (number - 5)
    @color = "red"
    "Way too low!"
  elsif guess < number
    @color = "pink"
    "Too low!"
  else
    @color = "white"
    "Error!"
  end
end

get '/' do 
  settings.guesses -= 1
  guess = params["guess"].to_i
  message = check_guess(settings.secret, guess)

  if settings.secret == guess || settings.guesses == 0
    reset_game
    message += "<br>A new number has been generated."
  end

  erb :index, :locals => {:secret => settings.secret, :message => message, :color => @color}
end

def reset_game
  settings.guesses = 5
  settings.secret = rand(100)
end
