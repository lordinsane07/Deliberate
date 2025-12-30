const express = require('express');
const topicController = require('./topic.controller');

const router = express.Router();

router.get('/', topicController.getTopics);
router.get('/:topicId', topicController.getTopic);

module.exports = router;
