function strip_spoiler(s::AbstractString)
	reggy = r"(\|\|)(\w+)(\|\|)"
	outRaw = match(reggy,s)
	if outRaw == nothing
	 return throw()
	else
	 return outRaw[2]
	end
end

function prettyP_D(d::Dict)
		S = ""
		for (k,v) in d
			S = S*"$(k): $(v)\n"
		end
		return S
end

sort_dict(d::Dict) = Dict(sort(collect(d), by=x->x[2]))