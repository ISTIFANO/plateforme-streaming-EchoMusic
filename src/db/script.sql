CREATE DATABASE EchoMusic;
USE EchoMusic;

CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL,
    role_description TEXT
) ENGINE=INNODB;

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
        role_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        FOREIGN KEY (role_id) REFERENCES Roles(id)

) ENGINE=INNODB;

CREATE TABLE artists (
    id INT PRIMARY KEY,
    artist_name VARCHAR(255) NOT NULL,
    biography TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE tracks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    duration VARCHAR(8) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    artist_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES artists(id)
) ENGINE=INNODB;

CREATE TABLE albums (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    artist_id INT NOT NULL,
    release_date DATE NOT NULL,
    cover_path VARCHAR(255),
    FOREIGN KEY (artist_id) REFERENCES artists(id)
) ENGINE=INNODB;

CREATE TABLE album_tracks (
    album_id INT NOT NULL,
    track_id INT NOT NULL,
    track_number INT NOT NULL,
    PRIMARY KEY (album_id, track_id),
    FOREIGN KEY (album_id) REFERENCES albums(id),
    FOREIGN KEY (track_id) REFERENCES tracks(id)
) ENGINE=INNODB;

CREATE TABLE playlists (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=INNODB;

CREATE TABLE playlist_tracks (
    playlist_id INT NOT NULL,
    track_id INT NOT NULL,
    position INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, track_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(id),
    FOREIGN KEY (track_id) REFERENCES tracks(id)
) ENGINE=INNODB;

CREATE TABLE tags (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL
) ENGINE=INNODB;

CREATE TABLE track_tags (
    track_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (track_id, tag_id),
    FOREIGN KEY (track_id) REFERENCES tracks(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
) ENGINE=INNODB;

CREATE TABLE follows (
    listener_id INT NOT NULL,
    artist_id INT NOT NULL,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (listener_id, artist_id),
    FOREIGN KEY (listener_id) REFERENCES users(id),
    FOREIGN KEY (artist_id) REFERENCES artists(id)
) ENGINE=INNODB;

CREATE TABLE favorites (
    user_id INT NOT NULL,
    track_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, track_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (track_id) REFERENCES tracks(id)
) ENGINE=INNODB;