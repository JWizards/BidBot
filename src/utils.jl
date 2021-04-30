function strip_spoiler(s::AbstractString)
	reggy = r"(\|\|)(\w+)(\|\|)"
	outRaw = match(reggy,s)
	if outRaw == nothing
	 return throw()
	else
	 return outRaw[2]
	end
end