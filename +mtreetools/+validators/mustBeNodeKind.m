function mustBeNodeKind(node,kind)

if ~isa(node,"mtree")
	msg = compose("Input must be of type mtree, but is of type %s",class(node));
	me = MException("mtreetools:validators:mustBeMtree",msg);
	throwAsCaller(me)
else
	nonmatched_kinds = setdiff(string(node.kinds), kind);
	if ~isempty(nonmatched_kinds)
		msg = compose("Node(s) must be of kind(s) [%s], but contains kind(s) [%s]",strjoin(kind,","),strjoin(nonmatched_kinds,","));
		me = MException("mtreetools:validators:mustBeNodeKind",msg);
		throwAsCaller(me)
	end
end

end