const httpStatus = require('http-status');
const argumentService = require('./argument.service');
const { cooldownDurations, MAX_ARGUMENT_DEPTH } = require('../../config/constants');

const createArgument = async (req, res) => {
    try {
        const { authorId, topicId, stance } = req.body;

        // Cooldown Check
        const lastArgument = await argumentService.getLastArgumentByAuthor(authorId);
        if (lastArgument) {
            const timeSinceLast = (Date.now() - new Date(lastArgument.createdAt).getTime()) / 1000;
            if (timeSinceLast < cooldownDurations.DEFAULT) {
                return res.status(httpStatus.TOO_MANY_REQUESTS).send({
                    message: `Please wait ${Math.ceil(cooldownDurations.DEFAULT - timeSinceLast)} seconds before posting again. Slow down and reflect.`,
                });
            }
        }

        // Depth Limit Check & Calculation
        let depth = 0;
        if (req.body.parentId) {
            const parent = await argumentService.getArgumentById(req.body.parentId);
            if (!parent) {
                return res.status(httpStatus.BAD_REQUEST).send({ message: 'Parent argument not found' });
            }
            depth = parent.depth + 1;

            if (depth > MAX_ARGUMENT_DEPTH) {
                return res.status(httpStatus.BAD_REQUEST).send({
                    message: `Maximum debate depth reached (${MAX_ARGUMENT_DEPTH}). Please start a new thread to continue this discussion.`
                });
            }
        }

        // Add calculated depth to body
        req.body.depth = depth;

        // Stance Switch Detection (Intellectual Honesty)
        // Check if user has a previous argument in this topic with a different stance
        if (topicId && stance) {
            const lastTopicArg = await argumentService.getLastArgumentByAuthorInTopic(authorId, topicId);
            // We only care if they had a previous stance AND it was different
            // Note: lastTopicArg might be the same as 'lastArgument' fetched above for cooldown, but strictly scoping to topic is safer/cleaner logic conceptually
            if (lastTopicArg && lastTopicArg.stance !== stance) {
                req.body.switchedFrom = lastTopicArg.stance;
            }
        }

        const argument = await argumentService.createArgument(req.body);
        res.status(httpStatus.CREATED).send(argument);
    } catch (error) {
        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({ message: error.message });
    }
};

const getArguments = async (req, res) => {
    try {
        const argumentList = await argumentService.getArgumentsByTopicId(req.query.topicId);
        res.status(httpStatus.OK).send(argumentList);
    } catch (error) {
        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({ message: error.message });
    }
};

module.exports = {
    createArgument,
    getArguments,
};
