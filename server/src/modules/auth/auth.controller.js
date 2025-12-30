const httpStatus = require('http-status');
const authService = require('./auth.service');
const { successResponse, errorResponse } = require('../../utils/response.util');
// I should probably fix response.util or implement catchAsync logic inline or in a new util.
// For now, I'll implement a simple try-catch block or use a standard wrapper pattern.
// actually, I'll just write standard express handlers.

const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await authService.login(email, password);
        res.status(httpStatus.OK).send(user);
    } catch (error) {
        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({ message: error.message });
    }
};

const loginAnonymous = async (req, res) => {
    try {
        const result = await authService.loginAnonymous();
        res.status(httpStatus.OK).send(result);
    } catch (error) {
        res.status(httpStatus.INTERNAL_SERVER_ERROR).send({ message: error.message });
    }
};

module.exports = {
    login,
    loginAnonymous,
};
