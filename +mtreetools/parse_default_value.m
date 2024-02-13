function [str,def] = parse_default_value(node)
%%
arguments (Input)
	node	mtree	{mustBeSingleNode}
end
arguments (Output)
	str
	def 
end
import mtreetools.validators.*
%%

funcnode = mtreetools.findfirst(node,"P",["FUNCTION","PROPERTIES"]);
if funcnode.iskind("FUNCTION")
	arg_ids = string(mtreetools.findall(funcnode.Ins,"X").stringvals);
	arg_ids = arg_ids(1:find(arg_ids==node.P.L.L.L.stringval)-1);
	ids_in_default = string(node.Tree.mtfind(Kind="ID").stringvals);
	arg_ids = intersect(arg_ids,ids_in_default);
else
	arg_ids = strings(1,0);
end

str = compose("@(%s) %s", strjoin(arg_ids,","), node.tree2str);
def = str2func(str);


%%
end