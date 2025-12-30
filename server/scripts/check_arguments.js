const mongoose = require('mongoose');
const dotenv = require('dotenv');
const path = require('path');
const Argument = require('../src/modules/argument/argument.model');

// Load env vars
dotenv.config({ path: path.join(__dirname, '../.env') });

const checkArgs = async () => {
    try {
        await mongoose.connect(process.env.MONGODB_URL, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log('Connected to MongoDB.');

        const args = await Argument.find({});
        console.log(`Found ${args.length} arguments.`);
        console.log(JSON.stringify(args, null, 2));

        process.exit(0);
    } catch (error) {
        console.error('Error:', error);
        process.exit(1);
    }
};

checkArgs();
