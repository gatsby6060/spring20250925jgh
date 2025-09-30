<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
        <script src="/js/page-change.js"></script>
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
            }

            th {
                background-color: beige;
            }

            input {
                width: 350px;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <table>
                <tr>
                    <th>이름</th>
                    <td>{{info.stuName}}</td>
                </tr>
                <tr>
                    <th>학과</th>
                    <td>{{info.stuDept}}</td>
                </tr>
                <tr>
                    <th>전체시험평균점수</th>
                    <td>{{info.enrAvg}}</textarea></td>
                </tr>
            </table>
            <button @click="fnUpate(info.stuNo)">수정</button>
        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    stuNo: "${stuNo}", //request.getAttribute("test")......
                    info: ""
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnView: function () {
                    let self = this;
                    let param = { //여기가 호출할때 파라미터 보내는 부분
                        stuNo: self.stuNo
                    };
                    $.ajax({
                        url: "stu-view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {

                            // alert("특정 1개 게시물이 조회되었습니다");    
                            console.log(data);
                            // alert(JSON.stringify(data));
                            self.info = data.info;

                        }
                    });
                },
                fnUpate : function(num){
                    // alert("수정버튼눌림");
                    pageChange("stu-update.do", {stuNo : num});
                },
               
            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnView();
            }
        });

        app.mount('#app');
    </script>