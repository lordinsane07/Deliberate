module.exports = {
    tokenTypes: {
        ACCESS: 'access',
        REFRESH: 'refresh',
        RESET_PASSWORD: 'resetPassword',
        VERIFY_EMAIL: 'verifyEmail',
    },
    roles: {
        USER: 'user',
        ADMIN: 'admin',
        MODERATOR: 'moderator',
    },
    argumentStances: {
        PRO: 'pro',
        CON: 'con',
    },
    reportReasons: {
        HARASSMENT: 'harassment',
        HATE_SPEECH: 'hateSpeech',
        SPAM: 'spam',
        MISINFORMATION: 'misinformation',
        OTHER: 'other',
    },
    cooldownDurations: {
        DEFAULT: 300, // 5 minutes in seconds
    },
    MAX_ARGUMENT_DEPTH: 6,
};
