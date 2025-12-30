const httpStatus = require('http-status');
const PositionChange = require('./positionChange.model');

const recordPositionChange = async (req, res) => {
    try {
        const positionChange = await PositionChange.create(req.body);
        res.status(httpStatus.CREATED).send(positionChange);
    } catch (error) {
        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({ message: error.message });
    }
};

module.exports = {
    recordPositionChange,
};
