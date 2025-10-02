<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        #board table,  tr,  td,  th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
        }
        th{
            background-color: beige;
        }
        input{
            width: 350px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         {{sessionId}}님 환영합니다. 상세 보기 페이지입니다!
            <table id="board">
                <tr>
                    <th>제목</th>
                    <td>{{info.title}}</td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>{{info.userId}}</td>
                </tr>
                <tr>
                    <th>조회수</th>
                    <td>{{info.cnt}}</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <img v-for="item in fileList" :src="item.filePath"><br>
                        {{info.contents}}
                    </td>
                </tr>
            </table>
            <!-- <div>--------이하 댓글부분-------</div> -->
            <hr>
            <table id = "comment">
                <tr v-for="item in commentList">
                    <th>{{item.nickName}}</th>
                    <td>{{item.contents}}</td>
                    <td><button>삭제</button></td>
                    <td><button>수정</button></td>
                </tr>
            </table>
            <hr>
            <table id = "input">
                <th>댓글 입력</th>
                <td>
                    <textarea cols="40" rows="4" v-model="contents"></textarea>
                </td>
                <td>
                    <button @click="fnCommentAdd">저장</button>
                </td>
            </table>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                boardNo : "${boardNo}", //request.getAttribute("test")......
                title: "",
                userId: "",
                // contents: "",//
                info: "",
                commentList: [], //중요! for에서...뽑아서 돌리려면...
                sessionId: "${sessionId}",
                contents : "",///
                fileList: [],
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = { 
                    boardNo : self.boardNo
                };
                $.ajax({
                    url: "board-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        
                        // alert(JSON.stringify(data)); //댓글 등록이나 삭제도 시간 나면 ㄱㄱ
                        console.log(data.commentList); //요런 형식으로 찍어야 잘보임 얼럿창 보단 이게 나은듯
                        
                        self.info = data.info;
                        self.commentList = data.commentList;
                        self.fileList = data.fileList;
                    }
                });
            },
            fnCommentAdd: function () {
                let self = this;
                let param = { 
                    boardNo : self.boardNo,
                    id : self.sessionId,
                    contents : self.contents,
                };
                $.ajax({
                    url: "/comment/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.msg);
                        self.contents = "";
                        self.fnInfo();
                    }
                });
            },
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>