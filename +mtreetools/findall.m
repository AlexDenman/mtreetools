function foundnodes = findall(node,direction,kind,opts)
%%
arguments (Input)
	node		mtree	{mustBeSingleNode}
	direction	(1,1)	string	{mustBeMember(direction,["L","R","X","P","PARENT","NEXT"])}
	kind		(1,:)	string	= []
	opts.includeFirst	(1,1)	logical	= 1
end
arguments (Output)
	foundnodes	mtree
end
import mtreetools.validators.*
%%

foundnodes = node.select([]);

if ~opts.includeFirst
	node = node.(direction);
end

while ~node.isempty
	if isempty(kind) || any(node.kind==kind)
		foundnodes = foundnodes | node;
	end
	node = node.(direction);
end

%%
end