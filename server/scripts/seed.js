const mongoose = require('mongoose');
const dotenv = require('dotenv');
const path = require('path');
const Topic = require('../src/modules/topic/topic.model');

// Load env vars
dotenv.config({ path: path.join(__dirname, '../.env') });

const seedTopics = [
    {
        title: 'Is AI Dangerous?',
        description: 'Debate the existential risks and safety alignment of Artificial General Intelligence.',
        createdBy: 'system',
        isActive: true,
    },
    {
        title: 'Remote Work vs Office',
        description: 'Is the future of work fully remote, hybrid, or back in the office?',
        createdBy: 'system',
        isActive: true,
    },
    {
        title: 'Pineapple on Pizza',
        description: 'The culinary world\'s most controversial topic.',
        createdBy: 'system',
        isActive: true,
    }
];

const seedDB = async () => {
    try {
        console.log('Connecting to MongoDB...');
        await mongoose.connect(process.env.MONGODB_URL, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log('Connected.');

        console.log('Clearing existing topics...');
        await Topic.deleteMany({});

        console.log('Seeding topics...');
        await Topic.insertMany(seedTopics);

        console.log('Database seeded successfully!');
        process.exit(0);
    } catch (error) {
        console.error('Error seeding database:', error);
        process.exit(1);
    }
};

seedDB();
