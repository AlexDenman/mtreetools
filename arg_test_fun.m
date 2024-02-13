function Z = arg_test_fun(A,B,C,D,E,F,G)

%%

arguments (Input)
	A	
	B	char				{mustBeMember(B,'oneofthesecharacters')}
	C	(100,1)		string
	D	string				{mustBeMember(D,C),mustBeNonEmpty} = ["ABC" "DEF"]
	E	(1,1)		double	{mustBeInRange(E,0,100)}  = 5
end

arguments
	F.?matlab.graphics.axis.Axes
	G.tbl	(:,4)	table = table( ...
						size=[0,4], ...
						variabletypes=["int32","int32","int32","int32"], ...
						variablenames=["frame","row","col","offset"] ...
						)
	G.foo	(:,:,:)	char = char(randi(127,5,5,5)) + numel(D)
end

arguments (Output)
	Z	(1,1)	double
end



%%
Z = nargin;
end