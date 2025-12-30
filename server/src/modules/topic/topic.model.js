const mongoose = require('mongoose');
// Plugins import removed as the file does not exist.
// const { toJSON, paginate } = require('../../models/plugins');

const topicSchema = mongoose.Schema(
    {
        title: {
            type: String,
            required: true,
            trim: true,
        },
        description: {
            type: String,
            required: true,
            trim: true,
        },
        createdBy: {
            type: String,
            required: true,
        },
        isActive: {
            type: Boolean,
            default: true,
        },
    },
    {
        timestamps: true,
    }
);

// topicSchema.plugin(toJSON);
// topicSchema.plugin(paginate);

const Topic = mongoose.model('Topic', topicSchema);

module.exports = Topic;
