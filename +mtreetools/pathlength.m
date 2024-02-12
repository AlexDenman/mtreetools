function len = pathlength(node,direction,opts)
arguments
	node				mtree	{mtreetools.mustBeSingleNode}
	direction			(1,1)	char	{mustBeMember(direction,'LPRX')}
	opts.doCount		(1,:)	string
	opts.dontCount		(1,:)	string	= ["COMMENT"]
	opts.includeFirst	(1,1)	logical	= 0
end

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