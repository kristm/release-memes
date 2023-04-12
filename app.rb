require 'rubygems'
require 'sinatra'
require 'dotenv'
require 'yaml'
require './helpers'

class App < Sinatra::Base

  DEPRACATION_NOTICE = "This feature has been depracated"

  configure do
    set :slack_incoming_url, ENV['SLACK_INCOMING_URL']
    set :slack_start_timer_token, ENV['SLACK_START_TIMER_TOKEN']
    set :slack_stop_timer_token, ENV['SLACK_STOP_TIMER_TOKEN']
    set :slack_enable_deploy_watch, ENV['SLACK_ENABLE_DEPLOY_WATCH']
    set :slack_deploy_qlearn_token, ENV['SLACK_DEPLOY_QLEARN_TOKEN']
    set :slack_deploy_api_token, ENV['SLACK_DEPLOY_API_TOKEN']
    set :slack_deploy_qlink_token, ENV['SLACK_DEPLOY_QLINK_TOKEN']
    set :slack_deploy_video_payment_token, ENV['SLACK_DEPLOY_VIDEO_PAYMENT_TOKEN']
    set :slack_deploy_qlink_react_token, ENV['SLACK_DEPLOY_QLINK_REACT_TOKEN']
    set :slack_deploy_microservices_token, ENV['SLACK_DEPLOY_MICROSERVICES_TOKEN']
    set :slack_channel, ENV['SLACK_CHANNEL']
    set :slack_username, ENV['SLACK_USERNAME']
    set :slack_avatar, ENV['SLACK_AVATAR']
  end

  helpers do
    include Helpers
  end

  get "/" do
    redirect "/memes/2022"
  end

  get "/memes" do
    redirect "/memes/2022"
  end

  get "/memes/:year" do
    memes = YAML.load_file("./views/#{params['year']}/memes.yaml")
    haml :"#{params['year']}/memes", :locals => { year: params['year'], collection: memes }
  end

  get "/check" do
    DEPRACATION_NOTICE
  end

  post "/stop" do
    if settings.slack_stop_timer_token == params['token']
      send_msg_to_slack ":tada::rocket::tada::rocket::tada::rocket::tada:"
      send_jp_holiday_notification_to_slack

      200
    end
  end
end
