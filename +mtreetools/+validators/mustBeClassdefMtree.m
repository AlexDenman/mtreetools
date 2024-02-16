function mustBeClassdefMtree(mt)


if ~isa(mt,"mtree")
	msg = compose("Input must be of type mtree, but is of type %s",class(mt));
	me = MException("mtreetools:validators:mustBeMtree",msg);
	throwAsCaller(me)
elseif string(mt.FileType)~="ClassDefinitionFile"
	msg = compose("Input must be a ClassDefinitionFile mtree, but has FileType %s", string(mt.FileType));
	me = MException("mtreetools:validators:mustBeClassdef",msg);
	throwAsCaller(me)
end

end