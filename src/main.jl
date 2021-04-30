



const GAMES = Dict{Discord.Snowflake, Dict{String, UInt}}()


function bid_channel(c::Client, m::Message)
	
	println("Received message: $(m.content)")
	words = split(m.content)
	if length(words) < 2
        return reply(c, m, "Invalid !bid command.")
    end
	
	if length(words) == 3
		pChar = words[3]
	else
		pChar = m.author.username
	end
	
	
	extract = try
		 strip_spoiler(words[2])
	catch
		 #reply(c,m, "Its best to spoiler your amounts!") #too much clutter
		 extract = words[2]
	end
	
	bid = try
	     parse(UInt, extract)
	catch
		 return reply(c,m, " '$(words[2])' is an invalid amount! ")
	end
	
	if !haskey(GAMES,m.channel_id) 
		GAMES[m.channel_id] = Dict()
		reply(c,m,"Started Game!")
		reply(c,m, " ")
	end
	
	game = GAMES[m.channel_id]
	if !haskey(game,pChar * " ")
		reply(c,m,"Added $(pChar)'s bid")
	else
		reply(c,m,"Updated $(pChar)'s bid")
	end
	
	game[pChar * " "] = bid
	
	delete(c,m)
	
end

function bid_conclude(c::Client, m::Message)

	if !haskey(GAMES, m.channel_id)
		return reply(c, m, "No Game in Session!")
	end
	
	game = GAMES[m.channel_id]
	winBid = maximum(values(game))
	winners = [x for (x,y) in game if y == winBid]
	
	delete!(GAMES,m.channel_id)
	
	return reply(c,m,"The winner(s) are $(winners...)")
	
end
	



function start_bot_mine()

	c = Client(ENV["BBOT_TOKEN"];  presence=(game=(name="nothing", type=AT_GAME),), prefix = '!')


	add_command!(c, :echo, (c, m) -> reply(c, m, m.content); help="repeat a message")
	add_command!(c, :bid, bid_channel)
	add_command!(c, :fin, bid_conclude)
	
	# Log in to the Discord gateway.
	open(c)
	# Wait for the client to disconnect.
	wait(c)
end 
