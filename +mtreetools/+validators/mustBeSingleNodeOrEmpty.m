function mustBeSingleNodeOrEmpty(node)

if ~isa(node,"mtree")
	msg = compose("Input must be of type mtree, but is of type %s",class(node));
	me = MException("mtreetools:validators:mustBeMtree",msg);
	throwAsCaller(me)
elseif node.count>1
	msg = compose("Input must be a single mtree node, but contains %i nodes",node.count);
	me = MException("mtreetools:validators:mustBeSingleNode",msg);
	throwAsCaller(me)
end

end