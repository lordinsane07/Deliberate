const httpStatus = require('http-status');
const Report = require('./report.model');

const submitReport = async (req, res) => {
    try {
        const report = await Report.create(req.body);
        res.status(httpStatus.CREATED).send(report);
    } catch (error) {
        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({ message: error.message });
    }
};

module.exports = {
    submitReport,
};
