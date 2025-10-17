import mongoose from 'mongoose';
import dotenv from 'dotenv';
import Article from './models/Article.js';
import { articles } from './data/articles.js';

dotenv.config();

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URI);
    console.log('MongoDB Connected for Seeding...');
  } catch (err) {
    console.error(`Error: ${err.message}`);
    process.exit(1);
  }
};

const importData = async () => {
  await connectDB();
  try {
    console.log('Clearing existing article data...');
    await Article.deleteMany();
    console.log('Inserting new article data...');
    await Article.insertMany(articles);
    console.log('Data Imported Successfully!');
    process.exit();
  } catch (error) {
    console.error(`Error with data import: ${error}`);
    process.exit(1);
  }
};

importData();