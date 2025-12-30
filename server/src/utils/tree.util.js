const buildTree = (flatList) => {
    const map = {};
    const roots = [];

    flatList.forEach((node, i) => {
        map[node.id] = i; // Map ID to index in original list
        flatList[i].children = []; // Initialize children
    });

    flatList.forEach((node) => {
        if (node.parentId && map[node.parentId] !== undefined) {
            flatList[map[node.parentId]].children.push(node);
        } else {
            roots.push(node);
        }
    });

    return roots;
};

module.exports = {
    buildTree,
};
