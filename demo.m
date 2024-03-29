% Using included test function with a lot of silly arguments
file = which("arg_test_fun");

% Create mtree
mt = mtree(file,"-file","-comments");
%{
Basic info on mtree:
Each node may have up to 3 children, called "left", "right", and "next".
Each node has, at minimum, an index and a "kind".
Some nodes also have attached string values. This includes comments, all
literals including numeric, "ID" nodes such as function names, variable
names, etc., attribute nodes and more.

Certain kinds of information can always be found at a specific path
relative to some other node type. E.g. from an ARGUMENT node in an
arguments block, the default value (if one exists) will always be the right
child of that node, and the left child will always be a PROPTYPEDECL node.
From a PROPTYPEDECL node, the path to the first validator is always RRRL.
So from an ARGUMENT node, the path to the first validator is LRRRL.

%}

% For convenience, get table of nodes and info about them
nodes = mtreetools.get_node_table(mt);


% Testing the "parse_function_node" function, which currently only pulls
% basic info, my plan is to add a function above it that parses the
% function and then the arguments and builds a more complex output.
funcs = table;
funcs.idx = nodes.index(nodes.type=="function");
[funcs.name,funcs.typ] = deal(strings(height(funcs),1));
[funcs.ins, funcs.outs] = deal(cell(height(funcs),1));

for ii = 1:height(funcs)
	fnode = mt.select(funcs.idx(ii));
	[funcs.name(ii),funcs.ins{ii},funcs.outs{ii},funcs.typ(ii)] = mtreetools.parse_function_node(fnode);
end

% Testing the function for parsing PROPTYPEDECL nodes
args = nodes.index(nodes.kind=="PROPTYPEDECL");
argprops = cell(size(args));
for ii = 1:numel(args)
	argprops{ii} = mtreetools.parse_proptypedecl_node(mt.select(args(ii)));
end

