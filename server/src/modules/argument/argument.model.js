const mongoose = require('mongoose');
const { argumentStances } = require('../../config/constants');

const argumentSchema = mongoose.Schema(
    {
        topicId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Topic',
            required: true,
        },
        content: {
            type: String,
            required: true,
        },
        authorId: {
            type: String, // Or ObjectId if User model exists in DB
            required: true,
        },
        parentId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Argument',
            default: null,
        },
        stance: {
            type: String,
            enum: [argumentStances.PRO, argumentStances.CON],
            required: true,
        },
        confidence: {
            type: String,
            enum: ['low', 'medium', 'high'],
            default: 'medium',
        },
        depth: {
            type: Number,
            default: 0,
        },
        switchedFrom: {
            type: String, // 'pro' or 'con' if the user switched stance in this chain
            enum: ['pro', 'con', null],
            default: null,
        },
    },
    {
        timestamps: true,
    }
);

const Argument = mongoose.model('Argument', argumentSchema);

module.exports = Argument;
