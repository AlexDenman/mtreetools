function mustBeNodeKind(node,kind)
mtreetools.mustBeSingleNode(node)
assert(any(node.kind==kind), compose("Node must be of kind %s",kind))
end