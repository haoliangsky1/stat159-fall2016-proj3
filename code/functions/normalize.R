# This function normalize the given vector with the input scale
normalize = function(x, from=0, to=100) {
	(x - min(x, na.rm =T)) / max(x - min(x, na.rm=T), na.rm=T) * (to - from) + from
}