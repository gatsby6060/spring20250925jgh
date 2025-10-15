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
            <div v-if="!authFlg">
                <div>
                    <label>아이디 : <input v-model="userId"></label>
                </div>
                <div>
                    <label>이름 : <input v-model="name"></label>
                </div>
                <div>
                    <label>번호 : <input v-model="phone" placeholder="-를 제외하고 입력해주세요."></label>
                </div>
                <div>
                    <button @click="fnAuth">인증</button>
                </div>
            </div>
            <div v-else>
                <div>
                    <label>비밀번호 : <input v-model="pwd1" type="password"></label>
                </div>
                <div>
                    <label>비밀번호 확인 : <input v-model="pwd2" type="password"></label>
                </div>
                <div>
                    <button @click="fnChangePwd">비밀번호 수정</button>
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
                    authFlg: false,
                    userId: "",
                    name: "",
                    phone: "",
                    pwd1: "",
                    pwd2: "",
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnAuth: function () {
                    let self = this;
                    console.log("공백 제거 전 ==> ", self.userId);
                    console.log("공백 제거 후 ==> ", self.userId.trim());

                    console.log(self.userId);
                    // self.authFlg = true;

                    // 일단 뭐 다 넘겨볼 예정jgh xml에서의 #값하고 동일해야할듯
                    let param = {
                        // authFlg: self.authFlg,
                        userId: self.userId.trim(), //.trim() 이 함수는 중간에 공백은 제거 못함
                        name: self.name.trim(),
                        phone: self.phone.trim(),
                        pwd: self.pwd,
                    };
                    // alert("인증버튼 눌림");
                    // alert("서버로 보낼 파람 값" + JSON.stringify(param));
                    $.ajax({
                        url: "/member/auth.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert(JSON.stringify(data));
                            console.log(data);
                            if (data.result == "success") { //식빵 이거 문자임 '' 붙여야함
                                alert("인증되었습니다. 다음 페이지 단계 보이게 하기 authFlg = true");
                                self.authFlg = true
                            } else {
                                alert("사용자 정보를 찾을 수 없습니다. 다음 페이지 안!!!! 보이게 하기 authFlg = false");
                                self.authFlg = false
                            }
                        }
                    });
                },
                fnUpdatePwd: function () {
                    let self = this;

                    //비밀번호는 6글자이상
                    if (self.pwd.length < 6 || self.pwd2.length < 6) {
                        alert("비밀번호는 6글자 이상으로 해야합니다.");
                        return;
                    }

                    //비밀번호 일치확인
                    if (self.pwd1 != self.pwd2) {
                        alert("비밀번호가 일치 하지 않습니다.");
                        return;
                    }

                    // 일단 뭐 다 넘겨볼 예정jgh xml에서의 #값하고 동일해야할듯
                    let param = {
                        authFlg: self.authFlg,
                        userId: self.id,
                        name: self.nm,
                        phone: self.phoneNo,
                        pwd: self.pwd1,
                    };
                    alert("서버로 보낼 파람 값" + JSON.stringify(param));
                    $.ajax({
                        url: "/member/updatepwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert(JSON.stringify(data));
                            console.log(data);
                            if (data.result == 'success') {
                                alert("해시화암호로 변경완료");
                                location.href = "/member/login.do"; //잠시 수석처리
                            } else {
                                alert("해시화암호로 변경실패");
                            }
                        }
                    });
                },

                fnChangePwd: function () {
                    let self = this;

                    //비밀번호 일치확인
                    if (self.pwd1 != self.pwd2) {
                        alert("비밀번호가 다릅니다!");
                        return;
                    }

                    let param = {
                        id: self.userId.trim(),
                        userId: self.userId.trim(),
                        pwd: self.pwd1,
                    };
                    alert("서버로 보낼 파람 값" + JSON.stringify(param));
                    $.ajax({
                        url: "/member/pwd.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            // alert(JSON.stringify(data));
                            console.log(data);
                            if (data.result == 'success') {
                                // alert("변경되었습니다.");
                                alert(data.msg);
                                // location.href = "/member/login.do"; //잠시 수석처리
                            } else {
                                // alert("오류가 발생했습니다.");
                                alert(data.msg);
                            }
                        }
                    });
                },



            }, // methods
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
            }
        });

        app.mount('#app');
    </script>