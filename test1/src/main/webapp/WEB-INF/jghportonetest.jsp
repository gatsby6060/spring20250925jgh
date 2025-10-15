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
        <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
            <button @click="requestCertification">본인인증</button>

            <div v-if="result_data">
                <p>인증 성공 여부: {{ result_data.success ? '성공' : '실패' }}</p>
                <p v-if="result_data.success">IMP UID: {{ result_data.imp_uid }}</p>
            </div>
        </div>
    </body>

    </html>

    <script>
        // IMP 객체를 전역에서 사용하기 전에 미리 초기화하는 코드가 필요합니다. (v1 방식)
        // v1 방식: const IMP = window.IMP; 

        const app = Vue.createApp({
            data() {
                return {
                    // 상점 식별코드 (필수)
                    // v3는 Iamport.init('YOUR_IMP_CODE');가 필요없습니다.
                    // 대신 IMP.certification의 param에 'merchant_uid'와 같은 데이터를 넣습니다.
                    imp_code: "YOUR_IMP_CODE", // 실제 사용하실 아임포트 상점코드 (꼭 바꾸세요)
                    result_data: null // 인증 결과 저장용
                };
            },
            methods: {
                // 본인인증을 요청하는 메서드
                requestCertification: function () {
                    let self = this;

                    // IMP 객체 초기화 (v1 SDK를 사용하고 있으므로 이 코드는 필요합니다.)
                    // 아임포트 V1 SDK를 사용하고 있기 때문에, 상점 식별코드를 초기화해야 합니다.
                    // (v1과 v3의 SDK가 혼용되어 있어 문법을 맞추기 위해 초기화 코드를 추가합니다.)
                    const IMP = window.IMP;
                    IMP.init(self.imp_code);

                    IMP.certification(
                        {
                            // 필수 파라미터
                            merchant_uid: 'mid_' + new Date().getTime(), // 필수: 주문 고유 번호 또는 본인인증 고유 번호

                            // 선택 파라미터 (원하시면 추가)
                            company: 'Your Company Name', // 회사명
                            name: '홍길동', // 이름
                            phone: '010-1234-5678', // 전화번호
                            m_redirect_url: 'http://www.yourdomain.com/cert_callback', // 모바일에서 인증 완료 후 리디렉션될 URL

                        },
                        function (rsp) { // 콜백 함수
                            // 인증 성공/실패 여부에 관계없이 Vue data에 저장
                            self.result_data = rsp;

                            if (rsp.success) {
                                // [성공 시 로직]
                                alert('본인인증 성공! IMP UID: ' + rsp.imp_uid);
                                // TODO: rsp.imp_uid 또는 rsp.merchant_uid로 서버에 본인인증 검증 요청 (필수 보안 과정)
                            } else {
                                // [실패 시 로직]
                                alert('본인인증 실패! 에러 코드: ' + rsp.error_code + ' / 메시지: ' + rsp.error_msg);
                            }
                        }
                    );
                }
            }, // methods
            mounted() {
                // ...
            }
        });

        app.mount('#app');
    </script>