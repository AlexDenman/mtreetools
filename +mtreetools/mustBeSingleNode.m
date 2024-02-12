function mustBeSingleNode(node)
mustBeA(node,"mtree")
assert(node.count==1, "Node must be single-node subtree")
end