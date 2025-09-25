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
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
		<div>
			<input v-model="keyword" placeholder="검색어" >	
			<button @click="fnList">검색</button>
		</div>
		<!--검색버튼을 클릭하면 stu-list.dox를 호출하고 콘솔창에 {keyword:"입력한값"} 출력하기-->
    </div>
</body>
</html>


<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
				keyword : ""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
					keyword : self.keyword
				};
                $.ajax({
                    url: "stu-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {

                    }
                });
            },
			
			fnLogin: function () {
			            var userSearch = document.getElementById("userSearch").value;
			            

			            // 유효성 검사
			            if (!userSearch || "") {
			                alert("아이디와 비밀번호를 입력하세요.");
			                return;
			            }

			            // AJAX 요청
			            $.ajax({
			                url: "stu-list.dox", // 로그인 처리를 위한 URL
			                dataType: "json",
			                type: "POST",
			                data: {
			                    userSearch: userSearch,
			    
			                },
			                success: function(data) {
			                    console.log(data);
			                    if (data.result === "success") {
			                        // 로그인 성공 시 페이지 전환
			                        // location.href = "stu-list.do";
			                    } else {
			                        // 로그인 실패 시 경고 메시지 출력
			                        alert(data.message);
			                    }
			                },
			                error: function(xhr, status, error) {
			                    // 오류 처리
			                    alert("오류가 발생했습니다: " + error);
			                }
			            });
			        }
			
			
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>