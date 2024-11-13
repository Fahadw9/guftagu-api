-- Users Table
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(255) NOT NULL,
    userName VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Conversations Table
CREATE TABLE Conversations (
    id SERIAL PRIMARY KEY,
    isGroup BOOLEAN DEFAULT FALSE,
    groupName VARCHAR(255),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Messages Table
CREATE TABLE Messages (
    id SERIAL PRIMARY KEY,
    conversationId INT NOT NULL,
    senderId INT NOT NULL,
    content TEXT,
    sentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    isRead BOOLEAN DEFAULT FALSE,
    CONSTRAINT FK_SenderId_Message FOREIGN KEY (senderId) REFERENCES Users(id) ON DELETE CASCADE,
    CONSTRAINT FK_ConversationId FOREIGN KEY (conversationId) REFERENCES Conversations(id) ON DELETE CASCADE
);

-- Reactions Table with ON DELETE SET NULL
CREATE TABLE Reactions (
    id SERIAL PRIMARY KEY,
    userId INT NOT NULL,
    messageId INT NOT NULL,
    reaction VARCHAR(5) CHECK (reaction IN ('👍', '❤️', '😂', '😮', '😢')) NOT NULL,
    CONSTRAINT FK_UserId_Reaction FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE SET NULL,
    CONSTRAINT FK_MessageId_Reaction FOREIGN KEY (messageId) REFERENCES Messages(id)
);

-- Conversation_Members Table
CREATE TABLE Conversation_Members (
    conversationId INT NOT NULL,
    userId INT NOT NULL,
    isAdmin BOOLEAN DEFAULT FALSE,
    joinedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_ConversationId_Member FOREIGN KEY (conversationId) REFERENCES Conversations(id) ON DELETE CASCADE,
    CONSTRAINT FK_UserId_Member FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
    PRIMARY KEY (conversationId, userId)
);

-- Friends Table with ON DELETE CASCADE
CREATE TABLE Friends (
    id SERIAL PRIMARY KEY,
    senderId INT NOT NULL,
    receiverId INT NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending', 'accepted')) DEFAULT 'pending',
    CONSTRAINT FK_SenderId FOREIGN KEY (senderId) REFERENCES Users(id) ON DELETE CASCADE,
    CONSTRAINT FK_ReceiverId FOREIGN KEY (receiverId) REFERENCES Users(id) ON DELETE CASCADE
);

-- Groups Table with ON DELETE CASCADE
CREATE TABLE Groups (
    id SERIAL PRIMARY KEY,
    groupName VARCHAR(255) NOT NULL,
    creatorId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_CreatorId FOREIGN KEY (creatorId) REFERENCES Users(id) ON DELETE CASCADE
);
