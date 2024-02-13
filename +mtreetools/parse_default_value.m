function [hasdefault,str,def] = parse_default_value(node)
%%
arguments (Input)
	node	mtree	{mustBeSingleNode,mustBeNodeKind(node,["ARGUMENT","EQUALS"])}
end
arguments (Output)
	hasdefault	(1,1)	logical
	str			string	{mustBeScalarOrEmpty}
	def					function_handle
end
import mtreetools.validators.*
%%

%{
Not currently implemented: Detecting if default is a simple expression like
string(missing) and if so just returning the value itself. If the
expression is not detected as using any other inputs as arguments (below),
then one option is to just evaluate the resulting function handle, but this
leaves the possibility that the default value expression could contain
arbitrary function calls with unknown side effects, so I didn't do that.

def_node_kinds = unique(string(defnode.Tree.kinds));
<unfinished>
%}

%%
defnode = node.R;
hasdefault = ~defnode.isempty;
if ~hasdefault
	str = string.empty;
	def = function_handle.empty;
	return
end


funcnode = mtreetools.findfirst(defnode,"P",["FUNCTION","PROPERTIES"]);
if funcnode.iskind("FUNCTION")
	arg_ids = string(mtreetools.findall(funcnode.Ins,"X").stringvals);
	arg_ids = arg_ids(1:find(arg_ids==defnode.P.L.L.L.stringval)-1);
	ids_in_default = string(defnode.Tree.mtfind(Kind="ID").stringvals);
	arg_ids = intersect(arg_ids,ids_in_default);
else
	arg_ids = strings(1,0);
end

str = string(defnode.tree2str);
def = str2func(compose("@(%s) %s", strjoin(arg_ids,","), str));

%%
end