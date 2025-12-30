const mongoose = require('mongoose');
const { reportReasons } = require('../../config/constants');

const reportSchema = mongoose.Schema(
    {
        reporterId: {
            type: String,
            required: true,
        },
        reportedContentId: {
            type: String,
            required: true,
        },
        reportedUserId: {
            type: String, // Or ObjectId
            required: true,
        },
        reason: {
            type: String,
            enum: Object.values(reportReasons),
            required: true,
        },
        description: {
            type: String,
        },
    },
    {
        timestamps: true,
    }
);

const Report = mongoose.model('Report', reportSchema);

module.exports = Report;
