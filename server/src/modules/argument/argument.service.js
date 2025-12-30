const Argument = require('./argument.model');
const { buildTree } = require('../../utils/tree.util');

const createArgument = async (argumentBody) => {
    const argument = await Argument.create(argumentBody);
    return argument;
};

const getArgumentsByTopicId = async (topicId) => {
    const argumentList = await Argument.find({ topicId }).lean();
    return argumentList; // For now returning flat list, frontend can build tree or we can use buildTree(arguments)
};

const getLastArgumentByAuthor = async (authorId) => {
    const argument = await Argument.findOne({ authorId }).sort({ createdAt: -1 });
    return argument;
};

const getArgumentById = async (id) => {
    const argument = await Argument.findById(id);
    return argument;
};

const getLastArgumentByAuthorInTopic = async (authorId, topicId) => {
    const argument = await Argument.findOne({ authorId, topicId }).sort({ createdAt: -1 });
    return argument;
};

module.exports = {
    createArgument,
    getArgumentsByTopicId,
    getLastArgumentByAuthor,
    getArgumentById,
    getLastArgumentByAuthorInTopic,
};
