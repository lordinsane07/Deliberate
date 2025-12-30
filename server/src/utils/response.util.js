const successResponse = (res, statusCode, data, message) => {
    res.status(statusCode).json({
        status: 'success',
        message,
        data,
    });
};

const errorResponse = (res, statusCode, message) => {
    res.status(statusCode).json({
        status: 'error',
        message,
    });
};

module.exports = {
    successResponse,
    errorResponse,
};
