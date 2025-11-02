package com.example.test1.model;

import java.util.Date;

public class ChatMessage {
    private Long chatId;
    private Date cdate;
    private String message;
    private String senderId;
    private Long chatroomNo;
    
    // WebSocket 통신용 필드 (DB 저장 시 변환)
    private String sender;

    public ChatMessage() {}

    public ChatMessage(String sender, String message) {
        this.sender = sender;
        this.message = message;
    }

    public Long getChatId() {
        return chatId;
    }

    public void setChatId(Long chatId) {
        this.chatId = chatId;
    }

    public Date getCdate() {
        return cdate;
    }

    public void setCdate(Date cdate) {
        this.cdate = cdate;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    public Long getChatroomNo() {
        return chatroomNo;
    }

    public void setChatroomNo(Long chatroomNo) {
        this.chatroomNo = chatroomNo;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
        // sender를 senderId로도 설정 (호환성)
        if (this.senderId == null) {
            this.senderId = sender;
        }
    }
}

