function foundnode = findfirst(node,direction,kind,opts)
%%
arguments (Input)
	node		mtree	{mustBeSingleNode}
	direction	(1,1)	string	{mustBeMember(direction,["L","R","X","P","PARENT","NEXT"])}
	kind		(1,:)	string
	opts.includeFirst	(1,1)	logical	= 1
end
arguments (Output)
	foundnode	mtree
end
import mtreetools.validators.*
%%

foundnode = node;
while ~(foundnode.isempty || ismember(foundnode.kind,kind))
	foundnode = foundnode.(direction);
end

%%
end