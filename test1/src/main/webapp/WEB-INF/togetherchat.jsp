<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실시간 채팅</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .chat-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        #chatBox {
            width: 100%;
            height: 400px;
            border: 1px solid #ccc;
            overflow-y: auto;
            margin: 20px auto;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 5px;
            text-align: left;
        }
        .message-item {
            margin-bottom: 10px;
            padding: 8px;
            border-radius: 5px;
        }
        .message-sender {
            font-weight: bold;
            color: #007bff;
            margin-bottom: 3px;
        }
        .message-content {
            background: white;
            padding: 8px;
            border-radius: 5px;
            display: inline-block;
            max-width: 70%;
        }
        .input-container {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        #message {
            flex: 1;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        #sender {
            width: 120px;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        button {
            padding: 12px 20px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .status {
            margin-top: 10px;
            padding: 10px;
            border-radius: 5px;
            font-size: 12px;
        }
        .status.connected {
            background-color: #d4edda;
            color: #155724;
        }
        .status.disconnected {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="chat-container">
        <h2>실시간 채팅</h2>
        <div id="status" class="status disconnected">연결 중...</div>
        <div id="chatBox"></div>
        <div class="input-container">
            <input type="text" id="sender" placeholder="이름을 입력하세요" value="">
            <input type="text" id="message" placeholder="메시지를 입력하세요..." onkeypress="handleKeyPress(event)">
            <button onclick="sendMessage()">전송</button>
        </div>
    </div>

    <script>
        let stompClient = null;

        // WebSocket 연결 함수
        function connect() {
            let socket = new SockJS('/ws-chat'); // WebSocket 엔드포인트
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                console.log("WebSocket 연결 성공: " + frame);
                updateStatus(true);

                // 서버에서 메시지를 받을 구독 설정
                stompClient.subscribe('/topic/public', function (message) {
                    let chatMessage = JSON.parse(message.body);
                    showMessage(chatMessage);
                });
            }, function (error) {
                console.error("WebSocket 연결 실패: ", error);
                updateStatus(false);
            });
        }

        // 메시지 전송 함수
        function sendMessage() {
            let messageContent = document.getElementById("message").value;
            let sender = document.getElementById("sender").value || "익명";
            
            if (stompClient && messageContent.trim() !== "") {
                let chatMessage = {
                    sender: sender,
                    message: messageContent
                };
                stompClient.send("/app/sendMessage", {}, JSON.stringify(chatMessage));
                document.getElementById("message").value = "";
            } else if (!stompClient) {
                alert("WebSocket 연결이 되지 않았습니다.");
            }
        }

        // 메시지 출력 함수
        function showMessage(message) {
            let chatBox = document.getElementById("chatBox");
            let messageElement = document.createElement("div");
            messageElement.className = "message-item";
            
            let senderElement = document.createElement("div");
            senderElement.className = "message-sender";
            senderElement.textContent = message.sender || "익명";
            
            let contentElement = document.createElement("div");
            contentElement.className = "message-content";
            contentElement.textContent = message.message || message;
            
            messageElement.appendChild(senderElement);
            messageElement.appendChild(contentElement);
            chatBox.appendChild(messageElement);

            // 최신 메시지로 스크롤
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        // 상태 업데이트 함수
        function updateStatus(connected) {
            let statusElement = document.getElementById("status");
            if (connected) {
                statusElement.textContent = "✓ 연결됨";
                statusElement.className = "status connected";
            } else {
                statusElement.textContent = "✗ 연결 실패";
                statusElement.className = "status disconnected";
            }
        }

        // 엔터 키로 메시지 전송
        function handleKeyPress(event) {
            if (event.key === "Enter") {
                sendMessage();
            }
        }

        // 페이지 로드 시 WebSocket 연결
        window.onload = function() {
            connect();
        };

        // 페이지 종료 시 연결 해제
        window.onbeforeunload = function() {
            if (stompClient) {
                stompClient.disconnect();
            }
        };
    </script>
</body>
</html>

