const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const routes = require('./routes');
const { errorConverter, errorHandler } = require('./middleware/error.middleware');
const config = require('./config/env');

const app = express();

// Set security HTTP headers
app.use(helmet());

// Parse json request body
app.use(express.json());

// Parse urlencoded request body
app.use(express.urlencoded({ extended: true }));

// Enable cors
app.use(cors());
app.options('*', cors());

// Logger
if (config.env !== 'test') {
    app.use(morgan('combined'));
}

// API routes
app.use('/api/v1', routes);

// 404 handler
app.use((req, res, next) => {
    res.status(404).json({ message: 'Not found' });
});

// Error handling
app.use(errorConverter);
app.use(errorHandler);

module.exports = app;
