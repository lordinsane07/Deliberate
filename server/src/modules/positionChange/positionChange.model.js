const mongoose = require('mongoose');
const { argumentStances } = require('../../config/constants');

const positionChangeSchema = mongoose.Schema(
    {
        userId: {
            type: String,
            required: true,
        },
        topicId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Topic',
            required: true,
        },
        previousStance: {
            type: String,
            enum: [argumentStances.PRO, argumentStances.CON],
            required: true,
        },
        newStance: {
            type: String,
            enum: [argumentStances.PRO, argumentStances.CON],
            required: true,
        },
        reason: {
            type: String,
            required: true,
        },
    },
    {
        timestamps: true,
    }
);

const PositionChange = mongoose.model('PositionChange', positionChangeSchema);

module.exports = PositionChange;
