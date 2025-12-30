const mongoose = require('mongoose');

const cooldownSchema = mongoose.Schema(
    {
        userId: {
            type: String,
            required: true,
            unique: true,
        },
        until: {
            type: Date,
            required: true,
        },
    },
    {
        timestamps: true,
    }
);

const Cooldown = mongoose.model('Cooldown', cooldownSchema);

module.exports = Cooldown;
