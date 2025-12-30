const Cooldown = require('./cooldown.model');
const { addMinutes } = require('../../utils/time.util');
const { cooldownDurations } = require('../../config/constants');

const setCooldown = async (userId, durationSeconds = cooldownDurations.DEFAULT) => {
    const until = addMinutes(new Date(), durationSeconds / 60);
    return Cooldown.updateOne(
        { userId },
        { userId, until },
        { upsert: true }
    );
};

const checkCooldown = async (userId) => {
    const cooldown = await Cooldown.findOne({ userId });
    if (cooldown && cooldown.until > new Date()) {
        return true;
    }
    return false;
};

module.exports = {
    setCooldown,
    checkCooldown,
};
