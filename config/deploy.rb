require 'hipchat/capistrano'

set :hipchat_token, "jibcQFwKU0MurUIWUp0f3vAd30aBd8XWrF1uBimkcline"
set :hipchat_room_name, "Sample"
set :hipchat_enabled, true # set to false to prevent any messages from being sent
set :hipchat_announce, false # notify users
set :hipchat_color, 'yellow' #normal message color
set :hipchat_success_color, 'green' #finished deployment message color
set :hipchat_failed_color, 'red' #cancelled deployment message color
set :hipchat_message_format, 'html' # Sets the deployment message format, see https://www.hipchat.com/docs/api/method/rooms/message
set :hipchat_options, {
  :api_version  => "v2" # Set "v2" to send messages with API v2
}