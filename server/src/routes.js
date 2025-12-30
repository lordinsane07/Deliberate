const express = require('express');
const authRoute = require('./modules/auth/auth.routes');
const topicRoute = require('./modules/topic/topic.routes');
const argumentRoute = require('./modules/argument/argument.routes');
const reportController = require('./modules/report/report.controller'); // Report might be simple enough to not have a route file yet, or I should have created one.
// The user spec didn't list report.routes.js, so I'll mount the controller directly or create a route file inline here?
// Better practice: create a small router here if file is missing, or bind controller.

const router = express.Router();

router.use('/auth', authRoute);
router.use('/topics', topicRoute);
router.use('/arguments', argumentRoute);

// Report routes (inline or bind controller)
router.post('/reports', reportController.submitReport);

module.exports = router;
