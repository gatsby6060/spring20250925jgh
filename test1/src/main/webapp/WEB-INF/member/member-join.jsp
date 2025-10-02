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

            .phone {
                width: 40px;
            }
        </style>
    </head>

    <body>
        <div id="app">
            <!-- html 코드는 id가 app인 태그 안에서 작업 -->
            <div>
                <label>
                    아이디 :
                    <!-- checkFlg이 false일 때 입력 가능 -->
                    <input v-if="!checkFlg" v-model="id" type="text">
                    <!-- checkFlg이 true일 때 입력 불가 -->
                    <input v-else v-model="id" type="text" disabled>
                </label>
                <button @click="fnCheck">중복체크</button>
            </div>
            <div>
                <label>비밀번호 : <input type="password" v-model="pwd"></label>
            </div>
            <div>
                <label>비밀번호 확인 : <input type="password" v-model="pwd2"></label>
            </div>
            <div>
                이름 : <input v-model="name">
            </div>
            <div>
                주소 : <input v-model="addr" disabled><button @click="fnAddr">주소검색</button>
            </div>
            <div>
                핸드폰 번호 :
                <input class="phone" v-model="phone1"> -
                <input class="phone" v-model="phone2"> -
                <input class="phone" v-model="phone3">
            </div>
            <div v-if="!joinFlg">
                문자인증 : <input v-model="inputNum" :placeholder="timer">
                <template v-if="!smsFlg">
                    <button @click="fnSms">인증번호 전송</button>
                </template>
                <template v-else>
                    <button @click="fnSmsAuth">인증</button>
                </template>
            </div>
            <div v-else style="color : red;">
                문자인증이 완료되었습니다.
            </div>

            <div>
                성별 :
                <label><input type="radio" v-model="gender" value="M">남자</label>
                <label><input type="radio" v-model="gender" value="F">여자</label>
            </div>
            <div>
                가입 권한 :
                <select v-model="status">
                    <option value="A">관리자</option>
                    <option value="S">판매자</option>
                    <option value="C">소비자</option>
                </select>
            </div>

                    <div>
                        <th>파일첨부</th>
                        <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
                    </div>

            <div>
                <button @click="fnJoin">회원가입</button>
            </div>
            <!-- <div>
                {{timer}}
                <button @click="fnTimer">시작!</button>
            </div> -->
        </div> <!--app끝-->
    </body>

    </html>

    <script>

        function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            console.log(roadFullAddr);
            console.log(addrDetail);
            console.log(zipNo);
            window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
        }

        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    id: "",
                    pwd: "",
                    pwd2: "",
                    name: "",
                    addr: "",
                    phone1: "",
                    phone2: "",
                    phone3: "",
                    gender: "M",
                    status: "A",

                    checkFlg: false, //중복체크 여부
                    inputNum: "",
                    smsFlg: "",
                    timer: "",
                    count: 180,  // 3분
                    joinFlg: false, // 문자인증 유무
                    ranStr: "", // 문자인증 번호
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnCheck: function () {
                    let self = this;
                    let param = {
                        id: self.id,
                        // pwd: self.pwd
                    };
                    if (self.id.length < 4) { alert('아이디는 4자 이상으로 입력하세요.'); return; }
                    $.ajax({
                        url: "/member/check.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "true") {
                                alert("이미 사용중인 아이디입니다");
                            } else {
                                alert("사용 가능한 아이디입니다.");
                                self.checkFlg = true;
                            }
                            // alert(data.msg);
                            // alert(data.result);
                            // if (data.result == "success") {
                            //     location.href = "/main.do";
                            // }
                        }
                    });
                },
                fnAddr: function () {
                    window.open("/addr.do", "addr", "left=600, top=200, width=500, height=500");
                },
                fnResult(roadFullAddr, addrDetail, zipNo) {
                    let self = this;
                    self.addr = roadFullAddr;
                },
                fnSms: function () {
                    let self = this;
                    let param = {

                    };
                    $.ajax({
                        url: "/send-one",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            console.log(data);
                            if (data.res.statusCode == "2000") {
                                alert("문자전송완료");
                                self.ranStr = data.ranStr;
                                self.smsFlg = true;
                                self.fnTimer();
                            } else {
                                alert("잠시 후 다시 시도해주세요.");
                            }
                        }
                    });
                },

                fnTimer: function () {
                    let self = this;
                    let interval = setInterval(function () {
                        if (self.count == 0) {
                            clearInterval(interval);
                            alert("시간이 만료되었습니다!");
                        } else {
                            let min = parseInt(self.count / 60);
                            let sec = self.count % 60;

                            min = min < 10 ? "0" + min : min;
                            sec = sec < 10 ? "0" + sec : sec;

                            self.timer = min + " : " + sec;
                            self.count--;
                        }

                    }, 1000);
                },



                fnJoin: function () {
                    let self = this;
                    if (!self.checkFlg) {
                        alert("아이디 중복체크 확인 후 진행해주세요");
                        return;
                    }

                    //영문 대문자 또는 소문자로 시작하는 아이디, 길이는 4 ~ 10자         /^[A-Za-z]{4, 20}/
                    let idtest = /^[A-Za-z0-9]{5,10}$/.test(self.id);
                    if (!idtest) {//value가 입력한 값을 의미한다
                        alert('아이디는 숫자포함 총5~10글자만 허용됩니다.');
                        userid.focus();
                        return false
                    }
                

                    if (self.id.length < 5) {
                        alert("아이디는 5글자 이상이어야합니다.");
                        return;
                    }

                    //비밀번호는 6글자이상
                    if (self.pwd.length < 6 || self.pwd2.length < 6) {
                        alert("비밀번호는 6글자 이상으로 해야합니다.");
                        return;
                    }

                    //비밀번호 일치확인
                    if (self.pwd != self.pwd2) {
                        alert("비밀번호가 일치 하지 않습니다.");
                        return;
                    }

                    let reg = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,25}$/.test(self.pwd)
                    if (!reg) {
                        alert("비밀번호는 6자 이상, 숫자/문자 혼합을 권장합니다.");
                        return;
                    }

                    //이름 빈값X
                    if (self.name == "") {
                        alert("이름은 빈값입력이 안됩니다.");
                        return;
                    }

                    //이름정규식
                    let nameJ = /^[가-힣]{2,8}$/.test(self.name)
                    if (!nameJ) {
                        alert("한글은 문자만 최소2글자부터 최대8글자까지입니다.");
                        return;
                    }

                    //주소는 빈값X
                    if (self.addr == "") {
                        alert("주소도 빈값입력이 안됩니다.");
                        return;
                    }

                    //핸드폰 번호는 000-0000-0000 형태로 저장
                    if (self.phone1 == "" || self.phone2 == "" || self.phone3 == "") {
                        alert("휴대폰 번호도 빈값이 있으면 안됩니다. 입력해주세요")
                        return;
                    }

                    // let phonenumber = (self.phone1 + "-" + self.phone2 + "-" + self.phone3)
                    // let phonej = /^01(0|1|2|6|7|8|9|?)?([0-9]{3,4})?([0-9]{4})$/.test(phonenumber);
                    // if(!phonej){
                    //     alert("휴대폰 번호를 일반적 형식에 맞게 제대로 입력해주세요");
                    //     return;
                    // }

                    // 문자인증이 완료되지 않으면
                    // 회워가입 불가능(안내문구 출력)
                    // 잠시 주석처리 250930
                    // if (!self.joinFlg) {
                    //     alert("문자 인증을 진행해주세요");
                    //     return;
                    // }


                    // alert("서버 보내기 직전1");
                    let param = {

                        id: self.id,
                        pwd: self.pwd,
                        name: self.name,
                        addr: self.addr,
                        phone: self.phone1 + "-" + self.phone2 + "-" + self.phone3,
                        // phone: `${self.phone1}-${self.phone2}-${self.phone3}`,
                        gender: self.gender,
                        status: self.status,

                    };
                    // alert("서버 보내기 직전2");
                    $.ajax({
                        url: "/member/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {

                            console.log("회원가입하고 돌아온 data값" + JSON.stringify(data));    
                            var form = new FormData();
                            form.append("file1", $("#file1")[0].files[0]);
                            form.append("userId", data.userId); // 임시 pk
                            self.upload(form);



                                alert("가입되었습니다.");
                                // location.href = "/member/login.do"; 잠시 수석처리
                            } else {
                                alert("오류가 발생했습니다.");
                            }

                        }
                    });

                },




                fnSmsAuth: function () {
                    let self = this;
                    if (self.ranStr == self.inputNum) {
                        alert("문자인증이 완료되었습니다.");
                        self.joinFlg = true;
                    } else {
                        alert("문자인증에 실패했습니다.");
                    }
                },

                // 파일 업로드
                upload: function (form) {
                    var self = this;
                    $.ajax({
                        url: "/member/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (data) {
                            console.log(data);
                        }
                    });
                },


            }, // methods                
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                window.vueObj = this;
            }
        });

        app.mount('#app');
    </script>

    <script>



    </script>