/*
 * SQL Schema for FIM database
 * Copyright (C) 2015-2020, Wazuh Inc.
 *
 * This program is a free software, you can redistribute it
 * and/or modify it under the terms of GPLv2.
 */

CREATE TABLE IF NOT EXISTS entry_path (
    path TEXT NOT NULL,
    inode_id INTEGER,
    mode INTEGER,
    last_event INTEGER,
    scanned INTEGER,
    options INTEGER,
    checksum TEXT NOT NULL,
    PRIMARY KEY(path)
);

CREATE INDEX IF NOT EXISTS path_index ON entry_path (path);
CREATE INDEX IF NOT EXISTS inode_index ON entry_path (inode_id);

CREATE TABLE IF NOT EXISTS entry_data (
    dev INTEGER,
    inode INTEGER,
    size INTEGER,
    perm TEXT,
    attributes TEXT,
    uid INTEGER,
    gid INTEGER,
    user_name TEXT,
    group_name TEXT,
    hash_md5 TEXT,
    hash_sha1 TEXT,
    hash_sha256 TEXT,
    mtime INTEGER,
    PRIMARY KEY(dev, inode)
);

CREATE INDEX IF NOT EXISTS dev_inode_index ON entry_data (dev, inode);

CREATE TABLE IF NOT EXISTS registry_key (
    path TEXT NOT NULL,
    perm TEXT,
    uid INTEGER,
    gid INTEGER,
    user_name TEXT,
    group_name TEXT,
    mtime INTEGER,
    scanned INTEGER,
    checksum TEXT NOT NULL,
    arch INTEGER,

    PRIMARY KEY(path)
);

CREATE INDEX IF NOT EXISTS path_index ON registry_key (path);

CREATE TABLE IF NOT EXISTS registry_data (
    key_id INTEGER,
    name TEXT,
    type INTEGER,
    size INTEGER,
    hash_md5 TEXT,
    hash_sha1 TEXT,
    hash_sha256 TEXT,
    scanned INTEGER,
    last_event INTEGER,
    checksum TEXT NOT NULL,

    PRIMARY KEY(key_id, name)
    FOREIGN KEY (key_id) REFERENCES registry_key(rowid)
);

CREATE INDEX IF NOT EXISTS key_name_index ON registry_data (key_id, name);
