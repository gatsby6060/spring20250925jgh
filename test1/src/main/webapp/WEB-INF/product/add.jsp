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
            이화면은 음식(프로덕트) add.jsp화면임

            <div>
                음식 종류(한식, 중식, 양식...)
                <select v-model="menuPart">
                    <option value="">선택하세요</option>
                    <template v-for="menu in menuList">
                        <option v-if="menu && menu.depth == 1" :value="menu.menuNo">
                            {{menu.menuName}}
                        </option>
                    </template>
                </select>
            </div>

            <div>
                이름 : <input v-model="foodName">
            </div>
            <div>
                설명 : <textarea v-model="foodInfo" cols="20" rows="4"></textarea>
            </div>
            <div>
                가격 :
                <input class="phone" v-model="price">
            </div>

            <div>
                <th>이미지 파일첨부</th>
                <td><input type="file" id="file1" name="file1" accept=".jpg, .png"></td>
            </div>

            <div>
                <button @click="fnAdd">음식 입력</button>
            </div>

        </div> <!--app끝-->
    </body>

    </html>

    <script>



        const app = Vue.createApp({
            data() {
                return {
                    // 변수 - (key : value)
                    menuPart: "",
                    foodName: "",
                    foodInfo: "",
                    price: "",
                    menuList: [],
                    //foodKind: "",
                };
            },
            methods: {
                // 함수(메소드) - (key : function())
                fnAdd: function () {
                    let self = this;

                    //비밀번호는 6글자이상
                    // if (self.pwd.length < 6 || self.pwd2.length < 6) {
                    //     alert("비밀번호는 6글자 이상으로 해야합니다.");
                    //     return;
                    // }

                    //이름 빈값X
                    // if (self.name == "") {
                    //     alert("이름은 빈값입력이 안됩니다.");
                    //     return;
                    // }

                    //이름정규식
                    // let nameJ = /^[가-힣]{2,8}$/.test(self.name)
                    // if (!nameJ) {
                    //     alert("한글은 문자만 최소2글자부터 최대8글자까지입니다.");
                    //     return;
                    // }

                    // alert("서버 보내기 직전1");
                    let param = {

                        menuPart: self.menuPart,
                        foodName: self.foodName,
                        foodInfo: self.foodInfo,
                        price: self.price,

                    };
                    // alert("서버 보내기 직전2");
                    $.ajax({
                        url: "/product/add.dox",
                        dataType: "json",
                        type: "POST",
                        data: param,
                        success: function (data) {
                            if (data.result == "success") {

                                console.log("회원가입하고 돌아온 data값" + JSON.stringify(data));
                                var form = new FormData();
                                form.append("file1", $("#file1")[0].files[0]);
                                form.append("foodNo", data.foodNo); // 음식 번호
                                self.upload(form);



                                alert("입력 되었습니다.");
                                // location.href = "/member/login.do"; 잠시 수석처리
                            } else {
                                alert("오류가 발생했습니다.");
                            }

                        }
                    });

                },


                // 파일 업로드
                upload: function (form) {
                    var self = this;
                    $.ajax({
                        url: "/product/fileUpload.dox"
                        , type: "POST"
                        , processData: false
                        , contentType: false
                        , data: form
                        , success: function (data) {
                            console.log(data);
                        }
                    });
                },

                // 메뉴 목록 가져오기
                fnGetMenuList: function () {
                    var self = this;
                    $.ajax({
                        url: "/product/list.dox", //이것도 가능한데 선생님은 아래로 하심
                        // url: "/product/menu.dox", //251014새로 작성
                        dataType: "json",
                        type: "POST",
                        data: {},
                        success: function (data) {
                            console.log("메뉴 목록:", data);
                            self.menuList = data.menuList || [];
                        }
                    });
                },

            }, // methods                
            mounted() {
                // 처음 시작할 때 실행되는 부분
                let self = this;
                self.fnGetMenuList();
            }
        });

        app.mount('#app');
    </script>

    <script>



    </script>