function len = pathlength(node,direction,opts)
arguments
	node				mtree	{mustBeSingleNode}
	direction			(1,1)	string	{mustBeMember(direction,["L","R","X","P","PARENT","NEXT"])}
	opts.doCount		(1,:)	string
	opts.dontCount		(1,:)	string	= ["COMMENT"]
	opts.includeFirst	(1,1)	logical	= 0
end
import mtreetools.validators.*

len = 0;
if ~opts.includeFirst
	node = node.(direction);
end

if isfield(opts,"doCount")
	iscountable = @(X) ismember(X.kind,opts.doCount) && ~ismember(X.kind,opts.dontCount);
else
	iscountable = @(X) ~ismember(X.kind,opts.dontCount);
end

while ~node.isempty
	if iscountable(node)
		len = len+1;
	end
	node = node.(direction);
end	

end