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
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
        <script src="/js/page-change.js"></script>
        <style>
            table,
            tr,
            td,
            th {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 5px 10px;
                text-align: center;
            }

            th {
                background-color: beige;
            }

            tr:nth-child(even) {
                background-color: azure;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            {{sessionId}}님 환영합니다. 상세 보기 페이지
            {{bbsNum}}
            bbs의 add.jsp파일입니다.
            <div>
                <table>
                    <tr>
                        <th>제목</th>
                        <td>{{info.title}}</td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>{{info.userId}}</td>
                    </tr>
                    <tr>
                        <th>파일첨부</th>
                        <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td style=" width:500px; ">
                            <img v-for="item in fileList" :src="item.filePath"><br>
                            <br>
                            <!-- <div v-html="info.contents2"></div> -->
                            <div v-html="info.contents"
                                style="white-space: pre-line; text-align:left; min-height:200px; width:100%; padding:10px;">
                            </div>
                        </td>

                        <!-- <td>
                            <div id="editor" style="width:100%; height:200px; border:1px solid #ccc; padding:10px;">

                            </div>
                        </td> -->
                    </tr>
                    <tr>
                        <th>조회수</th>
                        <td>{{info.hit}}</td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td>{{info.cdatetime}}</td>
                    </tr>
                </table>
                <div>
                    <button @click="fnAdd">저장</button>
                </div>
                <div>
                    <button @click="fnUpate(info.bbsNum)">수정</button>
                </div>
            </div>

        </div>
    </body>

    </html>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    sessionId: "${sessionId}",
                    contents: "",
                    title: "",

                    bbsNum: "${bbsNum}", //request.getAttribute("test")......
                    // contents: "",//
                    info: "",
                    // commentList: [], //중요! for에서...뽑아서 돌리려면...
                    // sessionId: "${sessionId}",
                    // contents : "",///
                   
                    fileList: [],

                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnInfo: function () {
                    let self = this;
                    let param = {
                        bbsNum: self.bbsNum
                    };
                    $.ajax({
                        url: "/bbs/bbs-view.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            alert(JSON.stringify(data)); 
                            // alert(JSON.stringify(data)); //댓글 등록이나 삭제도 시간 나면 ㄱㄱ
                            // console.log(data.commentList); //요런 형식으로 찍어야 잘보임 얼럿창 보단 이게 나은듯

                            self.info = data.info;
                            // self.commentList = data.commentList;
                            self.fileList = data.fileList;
                        }
                    });
                },

                fnUpate: function (bbsNum) {
                    alert("/bbs/bbs-update.do로 bbsNum넘겨줌 " + bbsNum);
                    pageChange("/bbs/bbs-update.do", { bbsNum: bbsNum });
                },

            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnInfo();



                // Quill 에디터 초기화
                var quill = new Quill('#editor', {
                    theme: 'snow',
                    modules: {
                        toolbar: [
                            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                            ['bold', 'italic', 'underline'],
                            [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                            ['link', 'image'],
                            ['clean']
                        ]
                    }
                });

                // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                quill.on('text-change', function () {
                    self.contents = quill.root.innerHTML;
                });
            }
        });

        app.mount('#app');
    </script>