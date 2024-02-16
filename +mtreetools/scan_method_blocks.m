function [method_defs] = scan_method_blocks(mt)
%%
arguments (Input)
	mt	mtree	{mustBeClassdefMtree}
end
arguments (Output)
	method_defs	(1,:)	struct
end
import mtreetools.validators.*
%%

method_nodes = mt.wholetree.mtfind(Kind="FUNCTION").indices;
proto_nodes = mt.mtfind(Kind="PROTO").indices;
method_defs = arrayfun(@(X) mtreetools.parse_function_node(mt.select(X)), [method_nodes(:); proto_nodes(:)]);


%%
end