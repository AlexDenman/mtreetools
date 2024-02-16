function [property_defs] = scan_property_blocks(mt)
%% In: mtree from classdef file; out: property_defs (Nx1 struct array)
arguments (Input)
	mt	mtree	{mustBeClassdefMtree}
end
arguments (Output)
	property_defs	(:,1)	struct
end
import mtreetools.validators.*
%%

propnodes = mt.wholetree.mtfind(Kind="PROPERTIES").R;
nextprop = propnodes.X;
while ~nextprop.isempty
	propnodes = propnodes | nextprop;
	nextprop = nextprop.X;
end
propidx = propnodes.mtfind(Kind="EQUALS").indices;

property_defs = cell(1,numel(propidx));
for ii = 1:numel(property_defs)
	p = struct;
	node = propnodes.select(propidx(ii));
	if node.L.iskind("ID")
		p = struct(name=string(node.L.stringval),definition=struct.empty);
	elseif node.L.iskind("PROPTYPEDECL")
		proptypedecl = mtreetools.parse_proptypedecl_node(node.L);
		p = struct(name=proptypedecl.argname, definition=proptypedecl);
	else
		error(compose("Unexpected node kind (%s) encountered left of EQUALS node",node.L.kind))
	end
	p.default = mtreetools.parse_default_value(node.R,[]);
	property_defs{ii} = p;
end

property_defs = vertcat(property_defs{:});

%%
end