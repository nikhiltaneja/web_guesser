require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

def check_guess(guess)
  if guess > (SECRET_NUMBER + 5)
    "Way too high!"
  elsif guess > SECRET_NUMBER
    "Too high!"
  elsif guess == SECRET_NUMBER
    "You got it right! The SECRET NUMBER is #{SECRET_NUMBER}"
  elsif guess < (SECRET_NUMBER - 5)
    "Way too low!"
  elsif guess < SECRET_NUMBER
    "Too low!"
  else
    "Error!"
  end
end


get '/' do 

  guess = params["guess"].to_i
  message = check_guess(guess)
  
  if message == "Way too low!" || message == "Way too high!"
    color = "red"
  elsif message == "Too low!" || message == "Too high!"
    color = "Salmon"
  elsif message == "You got it right! The SECRET NUMBER is #{SECRET_NUMBER}"
    color = "green"
  else
    color = "white"
  end

  erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :color => color}

end
