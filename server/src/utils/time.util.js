// For now, let's stick to native Date or simple helpers

const addMinutes = (date, minutes) => {
    return new Date(date.getTime() + minutes * 60000);
};

module.exports = {
    addMinutes,
};
