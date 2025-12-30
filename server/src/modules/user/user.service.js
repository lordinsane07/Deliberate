const httpStatus = require('http-status');
const User = require('./user.model');

const createUser = async (userBody) => {
    if (userBody.email && await User.isEmailTaken(userBody.email)) {
        throw new Error('Email already taken');
    }
    if (await User.isAliasTaken(userBody.alias)) {
        throw new Error('Alias already taken');
    }
    return User.create(userBody);
};

const getUserById = async (id) => {
    return User.findById(id);
};

const getUserByEmail = async (email) => {
    return User.findOne({ email });
};

module.exports = {
    createUser,
    getUserById,
    getUserByEmail,
};
