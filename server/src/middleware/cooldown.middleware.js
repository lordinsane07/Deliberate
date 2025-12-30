const checkCooldown = (req, res, next) => {
    // TODO: Check if user is in cooldown period
    next();
};

module.exports = checkCooldown;
