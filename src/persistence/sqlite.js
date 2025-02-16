const sqlite3 = require('sqlite3').verbose();
const fs = require('fs');
const path = require('path');

// ✅ Cloud Run requires SQLite database to be in /tmp
const DB_PATH = process.env.SQLITE_DB_LOCATION || path.join('/tmp', 'todo.db');

let db;

function init() {
    return new Promise((resolve, reject) => {
        db = new sqlite3.Database(DB_PATH, (err) => {
            if (err) return reject(err);
            console.log(`✅ Using SQLite database at ${DB_PATH}`);

            db.run(
                'CREATE TABLE IF NOT EXISTS todo_items (id TEXT PRIMARY KEY, name TEXT, completed INTEGER)',
                (err) => {
                    if (err) return reject(err);
                    resolve();
                }
            );
        });
    });
}

async function teardown() {
    return new Promise((resolve, reject) => {
        if (db) {
            db.close((err) => {
                if (err) return reject(err);
                resolve();
            });
        } else {
            resolve();
        }
    });
}

module.exports = { init, teardown };
