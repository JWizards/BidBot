

function start_bot_mine()

	c = Client("ODM1OTEzMjgzOTU2NjM3Nzc4.YIWW6Q.LqhJhPalzIZZpG4UxUmasMRmj2I"; presence=(game=(name="with Discord.jl", type=AT_GAME),))

	function handler(c::Client, e::MessageCreate)
		# Display the message contents.
		println("Received message: $(e.message.content)")
		# Add a reaction to the message.
		create(c, Reaction, e.message, '👍')
	end

	# Add the handler.
	add_handler!(c, MessageCreate, handler)
	# Log in to the Discord gateway.
	open(c)
	# Wait for the client to disconnect.
	wait(c)
end 