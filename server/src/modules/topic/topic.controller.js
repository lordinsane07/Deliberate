const httpStatus = require('http-status');
const Topic = require('./topic.model');

const getTopics = async (req, res) => {
    try {
        const topics = await Topic.find({ isActive: true });
        res.status(httpStatus.OK).send(topics);
    } catch (error) {
        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({ message: error.message });
    }
};

const getTopic = async (req, res) => {
    try {
        const topic = await Topic.findById(req.params.topicId);
        if (!topic) {
            return res.status(httpStatus.NOT_FOUND).send({ message: 'Topic not found' });
        }
        res.status(httpStatus.OK).send(topic);
    } catch (error) {
        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({ message: error.message });
    }
};

module.exports = {
    getTopics,
    getTopic,
};
