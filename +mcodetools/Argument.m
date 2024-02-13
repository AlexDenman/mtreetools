classdef Argument
%%
properties (SetAccess = immutable)
	Name				(1,1)	string
	Keyword						string	{mustBeScalarOrEmpty}
	Class						meta.class
	Size
	ValidatorFunctions	(1,:)	cell	= cell(1,0)
	HasDefault			(1,1)	logical
	DefaultValue				= {}

	Attributes			(1,:)	string = []
	IsRequired			(1,1)	logical
	IsPositional		(1,1)	logical
	IsRepeating			(1,1)	logical
	IsOutput			(1,1)	logical

	IsProperty			(1,1)	logical
	ParentFunction				meta.method
end
%%
methods (Static)
	function arg = Argument(node,props)
		% Construct Argument object
		% Intended syntax is either:
		%	"A = Argument(node)"
		%	or "A = Argument(name1=value1,name2=value2, ...)"
		arguments (Input)
			node	mtree	...
				{...
				mustBeSingleNodeOrEmpty, ...
				mustBeNodeKind(node,["ARGUMENT","PROPTYPEDECL","EQUALS"]) ...
				} ...
				= mtree("")
			props.?mcodetools.Argument
		end
		import mtreetools.validators.*

		if isempty(node)
			for f = string(fieldnames(props)).'
				arg.(f) = props.(f);
			end
			return
		end
		switch string(node.kind)
			case "PROPTYPEDECL"
				node = node.P;
				if node.iskind("ARGUMENT"),		arg.IsProperty = false;
				elseif node.iskind("EQUALS"),	arg.IsProperty = true;
				else, error("PROPTYPEDECL node parent does not appear to be argument or property node")
				end
			case "ARGUMENT"
				arg.IsProperty = false;
			case "EQUALS"
				arg.IsProperty = true;
		end

		% First handle default value, because that is applicable in all
		% situations, including a class property with no PROPTYPEDECL.
		[arg.HasDefault,default_str,default_fun] = mtreetools.parse_default_value(node);
		if arg.HasDefault
			arg.DefaultValue = default_str;
			% Note: Currently parse_default_value returns the default as
			% a string and/or as a function handle, but not as a straight
			% value. If it changes to return a value, that value should
			% probably be modified using the declared type/size (if any),
			% to ensure it appears as it would inside the function when
			% called.
		end


		% Now we can return early if this is a class property with no
		% PROPTYPEDECL.
		propnode = node.L;
		if propnode.iskind("ID")
			arg.Name = propnode.stringval;
			return
		else
			argprops = mtreetools.parse_proptypedecl_node(propnode);
			arg.Name = argprops.argname;
			if argprops.iskwarg
				arg.Keyword = argprops.kwname;
			elseif argprops.isclassarg
				error("TODO: implement substitution of class arguments")
			end

			arg.Class = meta.class.fromName(argprops.type);
			arg.ValidatorFunctions = argprops.validators;
			arg.Size = argprops.dims;

			
			arg.IsPositional = argprops.ispositional;
			%TODO: add ability to get argument attributes from argument
			% block (Input / Output / Repeating)

			attrib = strings(1,0);

			if arg.IsRequired,		attrib = [attrib "Required"];		end
			if arg.IsPositional,	attrib = [attrib "Positional"];		end			
			if arg.IsRepeating,		attrib = [attrib "Repeating"];		end

			if		arg.IsOutput,	attrib = [attrib "Output"];
			elseif	arg.IsProperty,	attrib = [attrib "Property"];
			else,					attrib = [attrib "Input"];
			end

			arg.Attributes = attrib;			
		end
	end
end
%%
end