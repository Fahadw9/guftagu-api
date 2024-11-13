-- Users Table
CREATE TABLE Users (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
    userName VARCHAR(255) NOT NULL,
    fullName VARCHAR(255) NOT NULL,
);

-- Conversations Table
CREATE TABLE Conversations (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    isGroup BOOLEAN DEFAULT FALSE,
    groupName VARCHAR(255),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Messages Table
CREATE TABLE Messages (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    conversationId uuid NOT NULL,  -- Changed to UUID
    senderId uuid NOT NULL,        -- Changed to UUID
    content TEXT,
    sentAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    isRead BOOLEAN DEFAULT FALSE,
    CONSTRAINT FK_SenderId_Message FOREIGN KEY (senderId) REFERENCES Users(id) ON DELETE CASCADE,
    CONSTRAINT FK_ConversationId FOREIGN KEY (conversationId) REFERENCES Conversations(id) ON DELETE CASCADE
);

-- Reactions Table with ON DELETE SET NULL
CREATE TABLE Reactions (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    userId uuid NOT NULL,           -- Changed to UUID
    messageId uuid NOT NULL,        -- Changed to UUID
    reaction VARCHAR(5) CHECK (reaction IN ('👍', '❤️', '😂', '😮', '😢')) NOT NULL,
    CONSTRAINT FK_UserId_Reaction FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE SET NULL,
    CONSTRAINT FK_MessageId_Reaction FOREIGN KEY (messageId) REFERENCES Messages(id)
);

-- Conversation_Members Table
CREATE TABLE Conversation_Members (
    conversationId uuid NOT NULL,  -- Changed to UUID
    userId uuid NOT NULL,          -- Changed to UUID
    isAdmin BOOLEAN DEFAULT FALSE,
    joinedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_ConversationId_Member FOREIGN KEY (conversationId) REFERENCES Conversations(id) ON DELETE CASCADE,
    CONSTRAINT FK_UserId_Member FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
    PRIMARY KEY (conversationId, userId)
);

-- Friends Table with ON DELETE CASCADE
CREATE TABLE Friends (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    senderId uuid NOT NULL,        -- Changed to UUID
    receiverId uuid NOT NULL,      -- Changed to UUID
    status VARCHAR(20) CHECK (status IN ('pending', 'accepted')) DEFAULT 'pending',
    CONSTRAINT FK_SenderId FOREIGN KEY (senderId) REFERENCES Users(id) ON DELETE CASCADE,
    CONSTRAINT FK_ReceiverId FOREIGN KEY (receiverId) REFERENCES Users(id) ON DELETE CASCADE
);

-- Groups Table with ON DELETE CASCADE
CREATE TABLE Groups (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    groupName VARCHAR(255) NOT NULL,
    creatorId uuid NOT NULL,       -- Changed to UUID
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_CreatorId FOREIGN KEY (creatorId) REFERENCES Users(id) ON DELETE CASCADE
);
