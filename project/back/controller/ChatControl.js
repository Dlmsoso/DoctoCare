const ChatMessage = require('../models/ChatMessage');
const Patient = require('../models/Patient');

const allChatMessages = [
    // sender, recipient, content, timestamp
    new ChatMessage(1, 2, 'Hello', new Date()),
    new ChatMessage(2, 1, 'Hi', new Date()),
    new ChatMessage(1, 2, 'How are you?', new Date()),
    new ChatMessage(2, 1, 'Fine, thanks', new Date()),
]

const allPatients = [
    // id, first_name, last_name, email, password, id_secu, age, city, id_med, child
    new Patient(1, 'John', 'Doe', 'john.doe@gmail.com', '123456', '123456789012345', 30, 'Paris', 1, false),
    new Patient(2, 'Maxime', 'Ulmann', 'maxime.ulmann@gmail.com', 'test', '000000000000123', 22, 'Saint-Maur', 1, false),
    new Patient(3, 'Solène', 'Loveland', 'prout.prout@gmail.com', 'prout', '000000000000666', 8, 'Nul', 5, true),
]

const getAllChatMessage = (req, res) => {
    const chatMessages = allChatMessages;

    res.json(chatMessages);
}

const getChatMessagebySender = (req, res) => {
    const chatMessageId = req.params.id;
    const chatMessages = allChatMessages.filter(p => p.sender == chatMessageId);

    if (chatMessages === undefined) {
        res.status(404).send(`ChatMessage with id ${chatMessageId} not found.`);
        return;
    }

    // replace sender and receiver by their respective names
    chatMessages.forEach((chatMessage) => {
        const sender = allPatients.find(p => p.id == chatMessage.sender);
        const recipient = allPatients.find(p => p.id == chatMessage.recipient);

        chatMessage.sender = sender.first_name + ' ' + sender.last_name;
        chatMessage.recipient = recipient.first_name + ' ' + recipient.last_name;
    });

    res.json(chatMessages);
}

module.exports = { getAllChatMessage, getChatMessagebySender }