const express = require('express');
const argumentController = require('./argument.controller');

const router = express.Router();

router.post('/', argumentController.createArgument);
router.get('/', argumentController.getArguments);

module.exports = router;
