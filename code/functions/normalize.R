# This function normalize the given vector with the input scale
normalize = function(x, from, to) {
	(x - min(x)) / max(x - min(x)) * (to - from) + from
}