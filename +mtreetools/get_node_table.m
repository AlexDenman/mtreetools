function nodes = get_node_table(mt)
%%
arguments (Input)
	mt	(1,1)	mtree
end
arguments (Output)
	nodes	table
end
%%
nodes = table;
nodes.index	= reshape(mt.indices,[],1);
nodes.kind	= reshape(string(mt.kinds),[],1);
%%
nodes.type = strings(mt.count,1);

kind_types = [
	"CLASSDEF"		"classdef"
	"METHODS"		"methods block"
	"FUNCTION"		"function"
	"PROPERTIES"	"properties block"
	"ARGUMENTS"		"arguments block"
	"ARGUMENT"		"argument"
	"PROPTYPEDECL"	"argument properties"
	"COMMENT"		"comment"
	"ATTRIBUTES"	"block attributes"
	"ATTR"			"attribute"
	];

for k = kind_types.'
	nodes.type(mt.kinds==k(1)) = k(2);
end

%%

funcprops = mt.select(nodes.index(nodes.type=="function")).L;
nodes.type(funcprops.indices) = "function definition";

nodes.type(funcprops.Parent.R.indices) = "function body start";

func_ins = funcprops.R.R;
while ~func_ins.isempty
	nodes.type(func_ins.indices) = "function input";
	func_ins = func_ins.Next;
end

func_outs = funcprops.L;
while ~func_outs.isempty
	nodes.type(func_outs.indices) = "function output";
	func_outs = func_outs.Next;
end

%%

treeprop_types = [
	"Fname"		"function name"
	"ArgumentInitialization"	"argument default value"
	"ArgumentValidation"		"argument properties"
	"VarName"					"argument name"
	"VarNamedClass"				"class argument"
	"VarNamedField"				"argument field"
	"VarType"					"argument type"
	"VarDimensions"				"argument dims"
	"VarValidators"				"argument validators"
	
	];

for p = treeprop_types.'
	nodes.type(mt.(p(1)).indices) = p(2);
end



% mt.select(nodes.index(nodes.

%%

nodes.lineno = reshape(mt.lineno,[],1);
nodes.colno = reshape(mt.charno,[],1);
nodes.charno = reshape(mt.position,[],1);
nodes.str	= reshape(string(mt.stringvals),[],1);

nodes.parent	= zeros(mt.count,1,"int32");
nodes.left		= zeros(mt.count,1,"int32");
nodes.right		= zeros(mt.count,1,"int32");
nodes.next		= zeros(mt.count,1,"int32");
getidx = @(X) max([0,X.indices]);
for ii = 1:mt.count
	nodes.parent(ii) =	getidx(mt.select(ii).Parent);
	nodes.left(ii) =	getidx(mt.select(ii).L);
	nodes.right(ii) =	getidx(mt.select(ii).R);
	nodes.next(ii) =	getidx(mt.select(ii).Next);
end

%%
end