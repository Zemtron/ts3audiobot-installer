#!/bin/bash

if ! lolcat -v COMMAND &> /dev/null 
then
wget https://github.com/busyloop/lolcat/archive/master.zip
apt-get install unzip
 unzip master.zip
 cd lolcat-master/bin
 apt-get install rubygems -y
 gem install lolcat
fi
if ! figlet -v COMMAND &> /dev/null 
then
 apt-get install -y figlet
fi
function Message() {
	echo -e "${@}" | lolcat -a -d 10
}
if ! mono --version COMMAND &> /dev/null 
then
 Message "So that the script works you have to install mono, so run Mono-Installer.sh"
 exit
fi
version="1.0"
updates_on="1"
if [ $updates_on -eq 1 ]; then
curl $timeout --head https://raw.githubusercontent.com/xElten/ts3audiobot-installer/master/version.php | head -n 1 | grep "HTTP/1.[01] [2].." > /dev/$
  	if [ $? = 1 ];
	then  printf "-"
	else
			sversion=$(wget https://raw.githubusercontent.com/xElten/ts3audiobot-installer/master/version.php -q -O -)
		if [ $sversion \> $version ];
			then printf "Neue Version verfügbar"
			sleep 2
			wget https://raw.githubusercontent.com/xElten/ts3audiobot-installer/master/ts3audiobot-$sversion.sh
			chmod +x ts3audiobot-$sversion.sh
			rm ts3audiobot-$version.sh
			./ts3audiobot-$sversion.sh $1
			sleep 1
			
			read -n 1
			clear
			$0
			exit 0
			else printf "Skript auf neustem Stand"
		fi
	fi
fi
clear
sleep 1.0
    figlet TS3AudioBOT | lolcat
    Message "#################################################################"
    
    Message "Options"


    echo ""
    Message "1.  TS3AudioBot | install"
    Message "2.  TS3AudioBot | start"
    Message "3.  TS3AudioBot | stop"
    
   

    echo ""
    Message "#################################################################"
    echo ""
    read -p  "Please enter a number: " ts3audio

	if [ "$ts3audio" = "1" ]; then
	clear
		Message "Teamspeak IP"
		read ip
		Message "Enter a nickname for the Bot"
		read name
		Message "Enter a servergroup id with which you want to control the bot"
		read servergroup
	 	clear
        Message "(10%) #"
        sleep 0.5
        clear
        Message "(20%) ##"
        sleep 0.5
        clear
        Message "(30%) ###"
        sleep 0.5
        clear
        Message "(40%) ####"
        sleep 0.5
        clear
        Message "(50%) #####"
        sleep 0.5
        clear
        Message "(60%) ######"
        sleep 0.5
        clear
        Message "(70%) #######"
        sleep 0.5
        clear
        Message "(80%) ########"
        sleep 0.5
        clear
        Message "(90%) #########"
        sleep 0.5
        clear
        Message "(100%) ##########"
        sleep 0.5
        clear
	mkdir /home/$name
	cd /home/$name
	apt-get install libopus-dev ffmpeg -y
	wget https://splamy.de/api/nightly/ts3ab/master/download
	mv download download.zip
	unzip download.zip
	sleep 1
cd /home/$name
screen -dm -S $name mono TS3AudioBot.exe
screen -X -S $name quit
echo "
# Rights declaration file
# For more information about syntax and structure see here:
# https://github.com/Splamy/TS3AudioBot/wiki/Rights

"\"+\"" = [
	# Basic stuff
	"\"cmd.help.*\"",
	"\"cmd.pm\"",
	"\"cmd.subscribe\"",
	"\"cmd.unsubscribe\"",
	"\"cmd.kickme.*\"",
	"\"cmd.version\"",
	
	# Getting song info
	"\"cmd.song\"",
	"\"cmd.repeat\"",
	"\"cmd.random\"",

	# Conditionals and basic scripting
	"\"cmd.if\"",
	"\"cmd.print\"",
	"\"cmd.rng\"",
	"\"cmd.eval\"",
	"\"cmd.take\"",
	"\"cmd.xecute\"",
	"\"cmd.getmy.*\"",
	"\"cmd.json.*\"",
	"\"cmd.bot.use\"",
	"\"cmd.rights.can\"",
]

# Admin rule
[[rule]]
	# Set your admin Group Ids here, ex: [ 13, 42 ]
	groupid = []
	# And/Or your admin Client Uids here
	useruid = [ "\"\"" ]
	# By default treat requests from localhost as admin
	ip = [ "\"127.0.0.1\"", "\"::1\"" ]

	"\"+\"" = "\"*\""

# Playing rights
[[rule]]
	# Set Group Ids you want to allow here, ex: [ 13, 42 ]
	groupid = [$servergroup]
	# And/Or Client Uids here, ex [ "\"uA0U7t4PBxdJ5TLnarsOHQh4/tY=\"", "\"8CnUQzwT/d9nHNeUaed0RPsDxxk=\"" ]
	useruid = []
	# Or remove groupid and useruid to allow for everyone

	"\"+\"" = [
		# Play controls
		"\"cmd.play\"",
		"\"cmd.pause\"",
		"\"cmd.stop\"",
		"\"cmd.seek\"",
		"\"cmd.volume\"",

		# Playlist management
		"\"cmd.list.*\"",
		"\"cmd.add\"",
		"\"cmd.clear\"",
		"\"cmd.previous\"",
		"\"cmd.next\"",
		"\"cmd.random.*\"",
		"\"cmd.repeat.*\"",

		# History features
		"\"cmd.history.add\"",
		"\"cmd.history.from\"",
		"\"cmd.history.id\"",
		"\"cmd.history.last\"",
		"\"cmd.history.play\"",
		"\"cmd.history.till\"",
		"\"cmd.history.title\"",
	]

	# Remove this if you want to allow users to save playlist locally
	"\"-\"" = [ "\"cmd.list.save\"" ]

" >> rights.toml
mkdir bots
cd /home/$name/bots
mkdir default
cd /home/$name/bots/default
echo "
#Starts the instance when the TS3AudioBot is launched.
run = true

[commands]

[commands.alias]

[connect]
#The server password. Leave empty for none.
server_password = { pw = "\"\"" }
#The default channel password. Leave empty for none.
channel_password = {  }
#Overrides the displayed version for the ts3 client. Leave empty for default.
client_version = {  }
#The address, ip or nickname (and port; default: 9987) of the TeamSpeak3 server
address = "\"$ip\""

[connect.identity]
#||| DO NOT MAKE THIS KEY PUBLIC ||| The client identity. You can import a teamspeak3 identity here too.
key = "\"\""
#The client identity offset determining the security level.
offset = 916

[reconnect]

[audio]
#When a new song starts the volume will be trimmed to between min and max.
#When the current volume already is between min and max nothing will happen.
#To completely or partially disable this feature, set min to 0 and/or max to 100.
volume = {  }

[playlists]

[history]

[events]

" >> bot.toml
cd /home/$name
echo "

#! IMPORTANT !
[bot]
#The bot will use the specified group to set/update the required permissions and add himself into it.
#You can set this field manually if you already have a preexisting group the bot should add himself to.
bot_group_id = 0
#Tries to fetch a cover image when playing.
generate_status_avatar = true
#Sets the description of the bot to the current song title.
set_status_description = true
#The language the bot should use to respond to users. (Make sure you have added the required language packs)
language = "\"en\""
#Starts the instance when the TS3AudioBot is launched.
run = false

[bot.commands]
#Defines how the bot tries to match your !commands. Possible types:
# - exact : Only when the command matches exactly.
# - substring : The shortest command starting with the given prefix.
# - ic3 : 'interleaved continuous character chain' A fuzzy algorithm similar to hamming distance but preferring characters at the start.
matcher = "\"ic3\""
#Defines how the bot handles messages which are too long for a single ts3 message. Options are:
# - split : The message will be split up into multiple messages.
# - drop : Does not send the message.
long_message = "\"Split\""
#Limits the split count for long messages. When for example set to 1 the message will simply be trimmed to one message.
long_message_split_limit = 1
#Enables colors and text highlights for respones.
color = true
#Limits the maximum command complexity to prevent endless loops.
command_complexity = 64

[bot.commands.alias]

[bot.connect]
#The server password. Leave empty for none.
server_password = { pw = "\"\"", hashed = false, autohash = false }
#The default channel password. Leave empty for none.
channel_password = { pw = "\"\"", hashed = false, autohash = false }
#Overrides the displayed version for the ts3 client. Leave empty for default.
client_version = { build = "\"\"", platform = "\"\"", sign = "\"\"" }
#The address, ip or nickname (and port; default: 9987) of the TeamSpeak3 server
address = "\"\""

channel = "\"\""
#The client badges. You can set a comma seperated string with max three GUID's. Here is a list: http://yat.qa/ressourcen/abzeichen-badges/
badges = "\"\""
#Client nickname when connecting.
name = "\"$name\""

[bot.connect.identity]
#||| DO NOT MAKE THIS KEY PUBLIC ||| The client identity. You can import a teamspeak3 identity here too.
key = "\"\""
#The client identity offset determining the security level.
offset = 0
#The client identity security level which should be calculated before connecting
#or -1 to generate on demand when connecting.
level = -1

[bot.reconnect]
ontimeout = ["\"1s\"", "\"2s\"", "\"5s\"", "\"10s\"", "\"30s\"", "\"1m\"", "\"5m\"", "\"repeat last\""]
onkick = []
onban = []
onerror = ["\"30s\"", "\"repeat last\""]
onshutdown = ["\"5m\""]

[bot.audio]
#When a new song starts the volume will be trimmed to between min and max.
#When the current volume already is between min and max nothing will happen.
#To completely or partially disable this feature, set min to 0 and/or max to 100.
volume = { default = 50.0, min = 25.0, max = 75.0 }
#The maximum volume a normal user can request. Only user with the 'ts3ab.admin.volume' permission can request higher volumes.
max_user_volume = 100.0
#Specifies the bitrate (in kbps) for sending audio.
#Values between 8 and 98 are supported, more or less can work but without guarantees.
#Reference values: 16 - very poor (~3KiB/s), 24 - poor (~4KiB/s), 32 - okay (~5KiB/s), 48 - good (~7KiB/s), 64 - very good (~9KiB/s), 96 - deluxe (~13KiB/s)
bitrate = 48
#How the bot should play music. Options are:
# - whisper : Whispers to the channel where the request came from. Other users can join with '!subscribe'.
# - voice : Sends via normal voice to the current channel. '!subscribe' will not work in this mode.
# - !... : A custom command. Use '!xecute (!a) (!b)' for example to execute multiple commands.
send_mode = "\"voice\""

[bot.playlists]

[bot.history]
#Enable or disable history features completely to save resources.
enabled = true
#Whether or not deleted history ids should be filled up with new songs.
fill_deleted_ids = true

[bot.events]
#Called when the bot is connected.
onconnect = "\"\""
#Called when the bot gets disconnected.
ondisconnect = "\"\""
#Called when the bot does not play anything for a certain amount of time.
onidle = "\"\""
#Specifies how long the bot has to be idle until the 'onidle' event gets fired.
#You can specify the time in the ISO-8601 format "\"PT30S\"" or like: 15s, 1h, 3m30s
idletime = "\"0s\""
#Called when the last client leaves the channel of the bot. Delay can be specified
onalone = "\"\""
#Specifies how long the bot has to be alone until the 'onalone' event gets fired.
#You can specify the time in the ISO-8601 format "\"PT30S\"" or like: 15s, 1h, 3m30s
alone_delay = "\"0s\""
#Called when the bot was alone and a client joins his channel. Delay can be specified.
onparty = "\"\""
#Specifies how long the bot has to be alone until the 'onalone' event gets fired.
#You can specify the time in the ISO-8601 format "\"PT30S\"" or like: 15s, 1h, 3m30s
party_delay = "\"0s\""

[configs]
#Path to a folder where the configuration files for each bot template will be stored.
bots_path = "\"bots\""
#Enable to contribute to the global stats tracker to help us improve our service.
#We do NOT send/store any IPs, identifiable information or logs for this.
#If you want to check how a stats packet looks like you can run the bot with 'TS3AudioBot --stats-example'.
#To disable contributing without config you can run the bot with 'TS3AudioBot --stats-disabled'. This will ignore the config value.
send_stats = true

[db]
#The path to the database file for persistent data.
path = "\"ts3audiobot.db\""

[factories]
#The default path to look for local resources.
media = { path = "\"\"" }

[tools]
#Path to the youtube-dl binary or local git repository.
youtube-dl = { path = "\"\"" }

#The path to ffmpeg.
[tools.ffmpeg]
path = "\"ffmpeg\""

[rights]
#Path to the permission file. The file will be generated if it doesn't exist.
path = "\"rights.toml\""

[plugins]
#The path to the plugins folder.
path = "\"plugins\""

[plugins.load]

[web]
#An array of all urls the web api should be possible to be accessed with.
hosts = ["\"*\""]
#The port for the web server.
port = 58913

[web.api]
#If you want to enable the web api.
enabled = true
#Limits the maximum command complexity to prevent endless loops.
command_complexity = 64
#See: bot.commands.matcher
matcher = "\"exact\""

[web.interface]
#If you want to enable the webinterface.
enabled = true
#The webinterface folder to host. Leave empty to let the bot look for default locations.
path = "\"\""

" >> ts3audiobot.toml

screen -dm -S $name mono TS3AudioBot.exe
fi
if [ "$ts3audio" = "2" ]; then
Message "Enter the name of the Bot"
read name
cd /home/$name
screen -dm -S $name mono TS3AudioBot.exe
fi
if [ "$ts3audio" = "3" ]; then
Message "Enter the name of the Bot"
read name
screen -X -S $name quit
fi