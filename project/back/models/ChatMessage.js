class ChatMessage {
    constructor(sender, recipient, content, timestamp) {
      this.sender = sender;
      this.recipient = recipient;
      this.content = content;
      this.timestamp = timestamp || new Date();
    }
  }
  
  module.exports = ChatMessage;