<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--<script type="text/javascript" src="/js/cw/jquery-ui.js"></script>--%>
<link rel="stylesheet" href="/css/cw/workspace/icono.min.css" />
<link rel="stylesheet" href="/css/cw/workspace-new.css?v=<%=System.currentTimeMillis() %>" />

<link rel="stylesheet" href="/js/cw/crop/cropper.min.css">

<script src="/js/exif/exif.js"></script>
<%-- CryptoJS 관련 --%>
<script src="/js/hash/core-min.js"></script>
<script src="/js/hash/md5-min.js"></script>
<script src="/js/hash/lib-typedarrays-min.js"></script>
<%-- CryptoJS 관련 --%>
<script src="/js/cw/crop/cropper.min.js"></script>


<style>
    <%-- common --%>
    .flex { display: flex; }.alignItems { align-items: center; }.spaceBetween { justify-content: space-between}

    .width100per { width: 100%; }

    .mt10 { margin-top: 10px; }.mt15 { margin-top: 15px; }.mt20 { margin-top: 20px; }.mt50 { margin-top: 50px; }
    .mb5 { margin-bottom: 5px; }.mb10 { margin-bottom: 10px; }.mb15 { margin-bottom: 15px; }.mb20 { margin-bottom: 20px; }
    <%-- /common --%>

    <%-- header --%>
    .cw-guide { height: 100%; }
    .cw-guide span i { font-size: 1.1rem; vertical-align: top; }
    #virticalSlash { margin: 0px 6px; }
    <%-- /header--%>

    <%-- work space --%>
    #displayImage { width: 100%;max-width: 100%; }
    #camera-btn > a { font-size: 1rem; }
    #camera-btn > a > i { font-size: 1.1rem; }
    #imageList { list-style: none; margin: 1rem 0;}
    #imageList > li { position: relative; display: flex; justify-content: space-between; align-items: center; padding: .5rem 0; border-top: 1px solid #eee; }
    #imageList > li canvas {height: 50px !important;max-width: 75px;}
    #imageList > li:last-child { border-bottom: 1px solid #eee; }
    .image-container {display: block; }
    .clear {clear: both;}
    .ui.form .inline.fields .field { width: 50%; }
    .modals.dimmer .ui.scrolling.modal { margin: 0; }
    .labelingModalWrapper,
    .reTakeModalWrapper{ position: absolute; top: 0; left: 0; z-index: 9999; width: 100%; height: 200vh; display: flex; justify-content: center; background-color: rgba(0, 0, 0, 0.81); }

    .CHECK-END { position: absolute; width: 100%; height: 100%; }
    .REJECT-MSG { font-size: 14px; border: 1px solid #eee; padding: 1rem; color: #db2828; border-radius: 4px; background-color: #f8f8f9; margin-top: 1rem; }
    .REJECT-MSG p { margin: 0 0 0.5em; }

    label.category-item { letter-spacing: -0.45px; white-space: nowrap; }

    <%-- / work space --%>
</style>
<!-- Loader -->
<div class="ui dimmer" id="dimmer">
    <div class="ui massive text loader">
        <h3>Loading</h3>
    </div>
</div>

<div id="cw-workspace" class="new-workspace">

    <div class="one-line-notice marquee" style="display:none;"><p id="one-line-text"></p></div>

    <div class="new-con">

        <%-- header row --%>
        <div class="ui header-row grid row">

            <div class="twelve wide column">

                <span class="cw-guide flex alignItems" data-type="work">
                    <span><i class="question circle icon grey" style="margin-right: 0.05rem;letter-spacing: -0.35px;"></i><span>작업 가이드</span></span>
                    <span id="virticalSlash">|</span>
                    <span id="inquiry" tabindex="0"><i class="envelope icon grey" style="margin-right: 0.05rem;letter-spacing: -0.35px;"></i> 문의하기</span>
				</span>

            </div>

            <c:if test="${pageType eq 'work'}">
                <div class="four wide column">
                    <div class="ui right floated main menu work-info">
                        <div class="item">
                            <span id="taskNum">0</span>
                        </div>
                    </div>
                </div>
            </c:if>


        </div>

        <c:if test="${pageType eq 'work'}">
            <!-- ######################### 자가진단 START ############################## -->
            <div class="self-test-row" style="display:none;">
                <div class="ui segment center">
                    <strong>${cwMember.nickname}</strong>님 자가진단 (<span id="guide_item_no"></span>/<span id="guide_max_no"></span>)
                </div>

                <h2 class="ui header">
                    <i class="question icon"></i>
                    <div class="content">
                        보기 및 문제
                    </div>
                </h2>

                <div class="self-test-space">
                    <div class="column">
                        <div class="ui raised segment">
                            <a class="ui red ribbon label">보기</a>
                            <div class="self-test-text ui message">

                            </div>
                            <a class="ui blue ribbon label">문제</a>
                            <div class="self-test-question ui success message">

                            </div>
                        </div>
                    </div>

                    <h2 class="ui header">
                        <i class="pencil alternate icon"></i>
                        <div class="content">
                            정답
                        </div>
                    </h2>
                    <div class="ui segment self-test-answers">

                    </div>
                </div>

                <div class="ui bottom attached warning message">
                    <i class="warning icon"></i>
                    자가진단 미통과 시에는 해당 작업을 참여하지 못합니다.
                </div>
            </div>

            <!-- ######################## 자가진단 END ############################### -->
        </c:if>

        <!-- 작업 영역 -->
        <div class="">
            <!-- ######################### WORK SPACE ############################ -->

            <div class="" style="padding-top:30px">
                <div class="image-container">
                    <%--                    <img id="displayImage" src="">--%>
                </div>
                <div class="clear">
                </div>
                <div class="flex spaceBetween width100per mt15">
                    <div for="select-upload-file" id="camera-btn" class="camera-btn">
                        <a class="ui red button" data-value="0">
                            <i class="camera retro icon"></i><span>사진찍기</span>
                        </a>
                        <input id="select-upload-file" class="select-upload-file hide" type="file" accept="image/*" capture="camera" data="*/">

                    </div>
                    <button class="ui green button" id="onCropperBtn" disabled="disabled"><i class="crop icon"></i>바운딩하기</button>

                    <button id="doCrop" class="ui button green hide"><i class="check circle icon"></i></i>바운딩완료</button>
                    <button id="doEditCrop" class="ui button hide"><i class="check circle icon"></i></i>수정완료</button>
                </div>



                <div id="area"></div>

                <ul id="imageList" class="width100per"></ul>

            </div>

            <!-- ######################### WORK SPACE ############################ -->

            <div class="flex spaceBetween width100per mt50">
                <button class="ui button btn-done" id="btn-done">작업종료</button>
                <button class="ui button black" id="btn-save-file" disabled="disabled">다음</button>
            </div>

            <!-- 작업반려 메시지  -->
            <c:if test="${pageType eq 'work'}">
                <div id="reject-area" class="ui form">
                    <div class="field">
                        <label style="font-size:1em;">※ 작업반려사유</label>
                        <textarea id='reject-reason' rows="2" readonly="readonly"></textarea>
                    </div>
                </div>
                <div id="checkRejectMsg" style="margin-top:20px;"></div>
            </c:if>

            <%--            <c:if test="${pageType eq 'work'}">--%>
            <%--                <div id="workingArea" class="ui form">--%>
            <%--                    <div class="field rejectArea">--%>
            <%--                        <label style="font-size:1em;">※ 작업반려사유</label>--%>
            <%--                        <textarea class="rejectReasonStr" rows="3"></textarea>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </c:if>--%>
        </div>
        <!-- ######################## BUTTONS START ############################### -->
        <div class="ui bottom-button-row grid row">
            <div class="ui wide column text-right btn-group"
                 data-work-buttons='[]'
                 data-check-buttons='[]'
                 data-monitor-buttons='[]'>
            </div>
        </div>
        <!-- ######################## BUTTONS END ############################### -->


        <%-- 이미지 라벨링 모달 --%>
        <div class="labelingModalWrapper hide">
            <div class="ui modal LABELING">
                <i class="close icon" data-value="LABELING"></i>
                <div class="header">
                    이미지 카테고리 구분
                </div>
                <div class="image content">
                    <%--<div class="ui medium image">--%>
                    <%--<img src="/images/avatar/large/chris.jpg">--%>
                    <%--</div>--%>
                    <div class="description">

                        <div class="ui top attached tabular menu">
                            <a class="item active" data-tab="first">소형 제품</a>
                            <a class="item" data-tab="second">대형 제품</a>
                            <a class="item" data-tab="third">기타</a>
                        </div>
                        <div class="ui bottom attached tab segment active LABEL-ITEMS" data-tab="first" data-value="SMALL"></div>
                        <div class="ui bottom attached tab segment LABEL-ITEMS" data-tab="second" data-value="LARGE"></div>
                        <div class="ui bottom attached tab segment LABEL-ITEMS" data-tab="third" data-value="ETC"></div>
                    </div>
                </div>
                <div class="actions">
                    <div class="ui black deny button" data-value="LABELING">
                        CANCLE
                    </div>
                    <div class="ui positive right labeled icon button LABELING-OK" data-value="labelingOK">
                        OK
                        <i class="checkmark icon"></i>
                    </div>
                </div>
            </div>
        </div>
        <%-- /이미지 라벨링 모달--%>

        <%-- 재촬영 화인용 모달 --%>
        <div class="reTakeModalWrapper hide">
            <div class="ui modal reTake">
                <i class="close icon" data-value="RETAKE"></i>
                <div class="header">
                    <i class="info circle icon red"></i>
                </div>
                <div class="image content">
                    <%--<div class="ui medium image">--%>
                    <%--<img src="/images/avatar/large/chris.jpg">--%>
                    <%--</div>--%>
                    <div class="description">
                        <div class="ui header">사진을 다시 촬영하면 <br> 기존 작업내역이 모두 삭제됩니다.</div>
                        <%--<p>We've grabbed the following image from the <a href="https://www.gravatar.com" target="_blank">gravatar</a> image associated with your registered e-mail address.</p>--%>
                        <%--<p>Is it okay to use this photo?</p>--%>
                    </div>
                </div>
                <div class="actions">
                    <div class="ui black deny button" data-value="RETAKE">
                        CANCLE
                    </div>
                    <div class="ui positive right labeled icon button" data-value="reTakeOK">
                        OK
                        <i class="checkmark icon"></i>
                    </div>
                </div>
            </div>
        </div>
        <%-- / 재촬영 화인용 모달 --%>

    </div>
</div>

<!-- 기초 타입 -->
<input type="hidden" name="projectId" id="projectId" value="${projectId}">
<input type="hidden" name="taskId" id="taskId" value="${taskId}">
<input type="hidden" name="dataId" id="dataId" value="${dataId}">
<input type="hidden" name="workUser" id="workUser" value="${workUser}">
<input type="hidden" name="checkUser" id="checkUser" value="${checkUser}">

<input type="hidden" name="fileHash" id="fileHash">
<!-- 페이지 타입 -->
<input type="hidden" id="pageType" value="${pageType}">
<input type="hidden" name="checkerId" id="checkerId" value="${checkerId}"> <!-- 모니터링 검수자 분류 -->

<script>

    var fileJsonData;

    var cropper;
    var tempInfo;
    var mode;
    var saveFlag = false;
    var workNext = false;
    var category = [];
    var categories = {
        "발코니/베란다": {
            "idx": 0,
            "name": "발코니/베란다",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선 청소기", "유선 청소기", "로봇청소기", "리모콘"],
                "LARGE": ["드럼세탁기", "전자동세탁기", "건조기", "서랍", "카펫", "실내자전기", "선풍기"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "욕실": {
            "idx": 1,
            "name": "욕실",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "스피커", "헤어드라이어", "리모콘"],
                "LARGE": ["드럼세탁기", "전자동세탁기", "건조기", "서랍", "욕조", "세면대", "변기", "샤워기"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "침실": {
            "idx": 2,
            "name": "침실",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "사운드바", "스피커", "프린터", "노트북", "마우스", "키보드", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어", "리모콘", "커피머신"],
                "LARGE": ["티비(모니터포함)", "스탠드에어컨", "벽걸이에어컨", "시스템에어컨", "건조기", "의류관리기", "공기청정기", "가습기", "침대", "화장대", "스탠드옷걸이", "옷장", "서랍", "놀이매트", "책상", "의자", "책장", "소파", "TV 장식장", "카펫", "피아노", "실내자전기", "선풍기"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "옷방": {
            "idx": 3,
            "name": "옷방",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "스피커", "노트북", "마우스", "키보드", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어", "리모콘"],
                "LARGE": ["스탠드에어컨", "벽걸이에어컨", "시스템에어컨", "건조기", "의류관리기", "공기청정기", "가습기", "화장대", "스탠드옷걸이", "옷장", "서랍", "책상", "의자", "책장", "소파", "카펫", "피아노", "실내자전기", "선풍기"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "식사실": {
            "idx": 4,
            "name": "식사실",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "스피커", "무선 청소기", "유선 청소기", "로봇청소기", "리모콘", "조리기구"],
                "LARGE": ["냉장고", "오븐", "전자레인지", "공기청정기", "가습기", "서랍", "카펫", "선풍기", "테이블", "싱크볼", "커피머신", "토스터기", "밥솥"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "현관": {
            "idx": 5,
            "name": "현관",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "사운드바", "스피커", "프린터", "노트북", "마우스", "키보드", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어", "리모콘"],
                "LARGE": ["티비(모니터포함)", "냉장고", "오븐", "전자레인지", "식기세척기", "스탠드에어컨", "벽걸이에어컨", "시스템에어컨", "드럼세탁기", "전자동세탁기", "건조기", "의류관리기", "공기청정기", "가습기", "화장대", "스탠드옷걸이", "옷장", "서랍", "놀이매트", "책상", "의자", "책장", "소파", "TV 장식장", "카펫", "피아노", "실내자전기", "선풍기", "테이블", "커피머신", "조리기구", "토스터기", "밥솥"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "아이방": {
            "idx": 6,
            "name": "아이방",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "사운드바", "스피커", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어"],
                "LARGE": ["티비(모니터포함)", "스탠드에어컨", "벽걸이에어컨", "시스템에어컨", "건조기", "의류관리기", "공기청정기", "가습기", "스탠드옷걸이", "옷장", "서랍", "놀이매트", "소파", "리모콘", "피아노", "실내자전기", "선풍기"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "주방": {
            "idx": 7,
            "name": "주방",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "스피커", "무선 청소기", "유선 청소기", "로봇청소기", "리모콘"],
                "LARGE": ["티비(모니터포함)", "냉장고", "오븐", "전자레인지", "인덕션", "식기세척기", "시스템에어컨", "공기청정기", "가습기", "서랍", "카펫", "피아노", "실내자전기", "선풍기", "싱크볼", "커피머신", "조리기구", "토스터기", "밥솥"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "거실": {
            "idx": 8,
            "name": "거실",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "사운드바", "스피커", "프린터", "노트북", "마우스", "키보드", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어", "리모콘"],
                "LARGE": ["티비(모니터포함)", "냉장고", "오븐", "전자레인지", "스탠드에어컨", "벽걸이에어컨", "시스템에어컨", "건조기", "의류관리기", "공기청정기", "가습기", "스탠드옷걸이", "서랍", "놀이매트", "책상", "의자", "책장", "소파", "TV 장식장", "카펫", "피아노", "실내자전기", "선풍기", "커피머신", "토스터기"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "서재/공부방": {
            "idx": 9,
            "name": "서재/공부방",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "사운드바", "스피커", "프린터", "노트북", "마우스", "키보드", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어", "리모콘"],
                "LARGE": ["티비(모니터포함)", "스탠드에어컨", "벽걸이에어컨", "시스템에어컨", "공기청정기", "가습기", "스탠드옷걸이", "옷장", "서랍", "놀이매트", "책상", "의자", "책장", "소파", "카펫", "피아노", "실내자전기", "선풍기", "커피머신"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "다용도실": {
            "idx": 10,
            "name": "다용도실",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "스피커", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어", "리모콘"],
                "LARGE": ["냉장고", "오븐", "전자레인지", "식기세척기", "드럼세탁기", "전자동세탁기", "건조기", "의류관리기", "스탠드옷걸이", "서랍", "카펫", "커피머신", "조리기구", "토스터기", "밥솥"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "실내": {
            "idx": 11,
                "name": "실내",
                "items": {
                "SMALL": ["태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "사운드바", "스피커", "프린터", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어", "조리기구"],
                "LARGE": ["공기청정기", "가습기", "침대", "화장대", "스탠드옷걸이", "옷장", "서랍", "놀이매트", "책상", "책장", "소파", "TV 장식장", "카펫", "피아노", "실내자전기", "커피머신", "냉장고", "오븐", "전자레인지", "인덕션", "식기세척기", "드럼세탁기", "전자동세탁기", "테이블", "싱크볼", "토스터기", "밥솥", "욕조", "세면대", "샤워기", "변기", "스탠드에어컨", "벽걸이에어컨", "시스템에어컨", "건조기", "의류관리기"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        },
        "실내_원본": {
            "idx": 12,
            "name": "실내_원본",
            "items": {
                "SMALL": ["스마트폰", "태블릿", "스마트워치", "무선이어폰", "헤드폰", "VR기기", "무선충전기", "사운드바", "스피커", "프린터", "노트북", "마우스", "키보드", "무선 청소기", "유선 청소기", "로봇청소기", "헤어드라이어", "리모콘", "조리기구"],
                "LARGE": ["티비(모니터포함)", "공기청정기", "가습기", "침대", "화장대", "스탠드옷걸이", "옷장", "서랍", "놀이매트", "책상", "의자", "책장", "소파", "TV 장식장", "카펫", "피아노", "실내자전기", "선풍기", "커피머신", "냉장고", "오븐", "전자레인지", "인덕션", "식기세척기", "드럼세탁기", "전자동세탁기", "테이블", "싱크볼", "토스터기", "밥솥", "욕조", "세면대", "샤워기", "변기", "스탠드에어컨", "벽걸이에어컨", "시스템에어컨", "건조기", "의류관리기"],
                "ETC": ["사람", "강아지", "고양이"]
            }
        }

    };

    var exceptedItem = ["스마트폰", "티비(모니터포함)", "노트북", "마우스", "키보드", "의자", "리모콘", "선풍기"];

    var taskName = "${prjNm}";


    window.onload = function () {

        $('.menu .item').tab();

        $(".image-container").css("max-height", $(window).height()*0.75 );


        // 자동옵션 삽입
        var opt = '${workConfig}';
        if ( opt ) {
            opt = JSON.parse(opt);
        }

        // 작업객체 생성
        cw = new crowdworks(opt);

        // 공용 데이터 로드 후, 별개 데이터 준비구간 재정의
        cw.ready = function (pageType, json, jsonCont, jsonValue, jsonData) {

            try{ cropper.destroy(); }catch(e){ }

            $(".image-container").height("auto");

            // semantic ui checkbox bug
            $('.ui.checkbox').checkbox();
            let tabDOM = $('.LABEL-ITEMS');

            if( categories[taskName] ) {
                if ( json.data.progStateCd === "CHECK_REJECT" ) {

                    for (let i = 0; i < jsonData['label-list'].length; i++) {
                        if ( exceptedItem.indexOf(jsonData['label-list'][i]['label']) > -1 ) {
                            category = categories["실내_원본"]["items"];
                            break;
                        } else {
                            category = categories[taskName]["items"];
                            break;
                        }
                    }

                } else {
                    category = categories[taskName]["items"];
                }
            } else {
                category = categories["현관"]["items"];
            }


            let displayImage = $('<img id="displayImage">');
            resetWorkspace();

            if ( json.data.progStateCd === "WORK_ING") {

                // alert('11111');

                fileJsonData = { "fileId": "", "label-list": [] };

                // resetWorkspace();

                displayImage.attr('src', "/images/noimage.jpg");
                $('.image-container').append(displayImage);

                setCategory(tabDOM, workNext);

            } else if ( json.data.progStateCd === "CHECK_REJECT" ) {

                cw.loader(true);

                console.log( 'datas: ', pageType, json, jsonCont, jsonValue, jsonData );

                $('#camera-btn > a').attr('data-value', 1);
                $('#camera-btn > a > span').text('다시찍기');



                fileJsonData = jsonData;
                setCategory(tabDOM, workNext);

                // 이미지 표시
                // let $displayImage = $('#displayImage');

                if(fileJsonData["fileId"]){

                    $('#onCropperBtn').attr('disabled', false);

                    displayImage.attr('src', '/cw/file/getSource.do?type=result&srcId=' + fileJsonData["fileId"]);

                    displayImage.one('load', function () {
                        var data = [];

                        for (let i = 0; i < fileJsonData['label-list'].length; i++) {

                            var lable_data = {};
                            lable_data.box = fileJsonData['label-list'][i]['box'];
                            lable_data.crop = fileJsonData['label-list'][i]['crop'];
                            lable_data.label = fileJsonData['label-list'][i]['label'];
                            lable_data.state = fileJsonData['label-list'][i]['state'];


                            let canvas = document.createElement('canvas');
                            canvas.width = lable_data.box['width']
                            canvas.height = lable_data.box['height']
                            let canvasCtx = canvas.getContext('2d');

                            canvasCtx.drawImage(displayImage[0], lable_data.box['x'], lable_data.box['y'], lable_data.box["width"], lable_data.box["height"], 0, 0,  lable_data.box["width"], lable_data.box["height"]);

                            let $li = $('<li></li>');
                            let $div = $('<div></div>');
                            let $ADD_LABEL = $("<button class='ui button green ADD-LABEL' style='padding:10px 15px;font-size:0.95rem;max-width: 100px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;'><i class='tag icon' style='margin: 0 0.1em 0 -0.2em;'></i> " + lable_data.label + "</button>");
                            let $EDIT_LABEL = $("<button class='ui button EDIT-LABEL' style='padding:10px 15px;font-size:0.95rem;'>영역수정</button>");
                            let $DELETE_ITEM = $("<button class='ui button DELETE-ITEM red' style='padding:10px 15px;font-size:0.95rem;'>삭제</button>");

                            if ( lable_data.state === 'CHECK_END' ) {
                                let $checkEndDiv = $('<div class="CHECK-END"></div>');
                                $li.prepend($checkEndDiv);
                                $li.css('opacity', 0.25);
                            }

                            $li.prepend($div);
                            $div.append($ADD_LABEL, $EDIT_LABEL, $DELETE_ITEM);
                            $li.data("data", lable_data );
                            $("#imageList").append($li);
                            $li.prepend(canvas);

                            $('#camera-btn > a').removeClass('disabled');
                            buttonEnabled(true);
                            $('#btn-save-file').attr('disabled', false);

                            data.push(lable_data);

                        }

                        $('.image-container').data("data-crop" ,data);

                        // #imageList 에 라벨링 목록 뿌려주기


                        $('.image-container').append(displayImage);

                        cropper = new Cropper( $('#displayImage').get(0) , {
                            ready() {
                                cw.loader(false);
                            },
                            autoCrop:false,
                            aspectRatio: NaN,
                            zoomable: true,
                            viewMode: 1,
                            dragMode: 'move',
                            modal: false,
                            autoCropArea: 0.3,
                            zoomOnWheel: false,
                            crop(event) {
                            },
                        });

                    });


                }else{
                    cw.loader(false);
                    displayImage.attr('src', "/images/noimage.jpg");
                    $('.image-container').append(displayImage);
                }


                $("#imageList").before('<div class="REJECT-MSG"><p><b><i class="exclamation circle icon"></i>반려사유</b></p><p>' + json.data.rejectReason + '</p></div>');


            }




        };

        // 이벤트 바인딩 구간 재정의
        cw.bind = function () {
            let $displayImage = $("#displayImage");


            cw.action.work_next = function () {

                // if ( !$("#fileHash").val() ) {
                //     alert("파일을 등록해 주세요");
                //     cw.loader(false);
                //     return;
                // }
                if ( saveFlag == false ) {
                    cw.loader(true);
                    saveFlag = true;
                    setTimeout(function () {
                        saveFileData();
                    }, 500);
                }
            };


            cw.action.check_end = function () {
                if ( isCrop[0] == "true" ) {
                    uploadCroped();
                } else {
                    checkStart();
                }

            };

            cw.action.work_stop = function() {

                location.href = "cw://finish";

                return false;

            };


            $('#btn-save-file').on('click', function () {

                category = [];
                workNext = true;

                if ( ($('.ADD-LABEL').length !== $('.ADD-LABEL > i').length) ) {
                    alert('모든 라벨링을 완료해주세요.');
                    return false;
                }

                if ( $('.ADD-LABEL > i').length < 2 ) {
                    alert('최소 2개 이상 바운딩을 해주세요.');
                    return false;
                }

                cw.action.work_next();

            });


            // 1. 사진찍기
            $("#camera-btn > a").on("click", function () {

                // console.log( "$('#camera-btn > a'): ", $('#camera-btn > a').data('value') )

                // 다시찍기
                if ( $("#camera-btn > a").data('value') !== 0 ) {

                    $('.ui.modal.reTake').css('display', 'block');
                    $('.ui.modal.reTake').css('top', ( document.documentElement.clientHeight - 212 ) / 2);
                    $('.reTakeModalWrapper').removeClass('hide');
                    window.scroll(0, 0);

                } else {

                    $('#select-upload-file').click();

                }

            });

            // 5. 라벨링
            $("#imageList").on("click" , ".ADD-LABEL" , function(){

                $('.labelingModalWrapper').removeClass('hide');
                $('.ui.modal.LABELING').css('display', 'block');

                let x
                document.documentElement.clientHeight < 600 ? x = 0.45 : x = 0.55;

                // alert(x);

                // modal css set
                $('.scrolling').css("height", document.documentElement.clientHeight * x);

                $('.modals.dimmer .ui.scrolling.modal').css('margin', 0);
                $('.ui.modal.LABELING').css('position', 'fixed');
                $('.ui.modal.LABELING').css('top', '10px');

                $(".ADD-LABEL.selected").removeClass("selected");
                $(this).addClass("selected");

            });

            // 6. 영역수정
            $("#imageList").on("click" , ".EDIT-LABEL" , function(){

                console.log("data", $('#displayImage').data("data"));

                buttonEnabled(false);
                var li = $(this).closest("li");
                console.log("data" , li.data);

                $("#imageList li.selected").removeClass("selected");
                li.addClass("selected");
                $('#onCropperBtn').hide();
                $('#doEditCrop').removeClass('hide');

                cropper.crop();
                var data = li.data("data");
                if(!data){
                    data = $('#displayImage').data("data")[li.index()];
                }
                cropper.setCanvasData(data.crop);
                cropper.setData(data.box);

                $('#camera-btn > a').addClass('disabled');

            });

            // 7. 삭제
            $("#imageList").on("click" , ".DELETE-ITEM" , function(){

                let _uuid = $(this).closest('li').data('uuid');
                if ( confirm("삭제하시겠습니까?") ) {
                    $(this).closest('li').remove();

                    fileJsonData['label-list'] = fileJsonData['label-list'].filter(function( obj ) {
                        return obj.uuid !== _uuid.toString();
                    });

                    console.log( fileJsonData['label-list'] );

                    if ( $('#imageList > li').length === 0 ) {

                        $('#btn-save-file').attr('disabled', true);

                    }

                    if ( $('#imageList > li').length < 3 ) {

                        $('#onCropperBtn').attr('disabled', false)

                    }

                }

            });



            // 모달 OK 버튼 처리
            $('.positive').on('click', function () {

                // 다시찍기 OK
                if ( $(this).data('value') === 'reTakeOK' ) {

                    $displayImage.attr("src", "/images/noimage.jpg");
                    $('#imageList > li').remove();
                    fileJsonData['label-list'] = [];
                    $('#onCropperBtn').attr('disabled', true);

                    $('.ui.modal.reTake').css('display', 'none');
                    $('.reTakeModalWrapper').addClass('hide');

                    $('.REJECT-MSG').remove();

                    $('#select-upload-file').click();

                }

                // 이미지 카테고리 수집 OK
                if ( $(this).data('value') === 'labelingOK' ) {

                    var li = $(".ADD-LABEL.selected").closest("li");

                    let checkedLabelValue = $('input[type="radio"]').filter(":checked").val();

                    if ( checkedLabelValue === undefined ) {
                        alert('라벨을 선택해주세요.');
                        return false;
                    }

                    var data = li.data("data");

                    if(!data){
                        data = $('#displayImage').data("data")[li.index()];
                    }

                    data['label'] = checkedLabelValue;
                    li.data("data",data);

                    var btnLabel = li.find(".ADD-LABEL");

                    btnLabel.addClass('green');
                    btnLabel.html('<i class="tag icon" style="margin: 0 0.1em 0 -0.2em;"></i> ' + checkedLabelValue);
                    btnLabel.attr('active', false)


                    $('.labelingModalWrapper').addClass('hide');
                    $('.ui.modal.LABELING').css('display', 'none');

                    resetLabelingModal();

                }

            });

            // 2. 사진찍기
            $('#select-upload-file').change(
                function () {

                    if ( this.files.length === 0 ) {
                        // $displayImage.attr("src", "/images/noimage.jpg");
                        $("#fileHash").val("");
                        $('#select-upload-file').val(null);
                        cw.loader(false);
                        return false;
                    }

                    cw.loader(true);

                    for (var i = 0; i < this.files.length; i++) {

                        var reader = new FileReader();

                        var file = this.files[i];
                        var fileType = file.type;

                        var typeCheck = false;
                        if ( true ) {

                            reader.addEventListener(
                                'load',
                                function () {

                                    var wordArray = CryptoJS.lib.WordArray.create(this.result);
                                    var md5hash = CryptoJS.MD5(wordArray);
                                    //$('#md5').text(md5hash);

                                    $("#fileHash").val("" + md5hash + "");

                                    //reader.readAsDataURL(file);
                                    var preview_reader = new FileReader();
                                    preview_reader.readAsDataURL(file);
                                    preview_reader.onload = function () {

                                        var image = new Image();
                                        image.src = preview_reader.result;
                                        image.onload = function () {

                                            if ( this.width < 640 || this.height < 640 ) {
                                                // $displayImage.attr("src", "/images/noimage.jpg");
                                                $("#fileHash").val("");
                                                $('#select-upload-file').val(null);
                                                alert("이미지의 해상도가 너무 낮습니다. 640x640 이상으로 해주세요.");
                                                cw.loader(false);
                                            } else {

                                                $.ajax({
                                                    url: '/cw/working/task/file-hash-check.do',
                                                    type: 'get',
                                                    dataType: 'json',
                                                    cache: false,
                                                    data: {
                                                        taskId: '${taskId}',
                                                        hsv: $("#fileHash").val(),
                                                        fileName: "fileName"
                                                    },


                                                    beforeSend: function (xhr) {

                                                        xhr.setRequestHeader("mid", mid);
                                                        xhr.setRequestHeader("deviceId", deviceId);
                                                        xhr.setRequestHeader("launchToken", launchToken);
                                                        xhr.setRequestHeader("platform", platform);
                                                        xhr.setRequestHeader("os", os);
                                                        xhr.setRequestHeader("app_ver", app_ver);

                                                    },

                                                    success: function (json) {


                                                        if ( json.result === 'OK' ) {

                                                            fileJsonData["fileId"] = false;

                                                            $("#camera-btn a").data('value', 1);
                                                            $('#camera-btn > a > span').text('다시찍기');


                                                            $('#displayImage').attr("src", preview_reader.result).show();
                                                            $('#onCropperBtn').prop('disabled', false);

                                                            $('.REJECT-MSG').remove();
                                                            $('#imageList > li').remove();

                                                            let maxHeight = $(window).height()*0.75;

                                                            EXIF.getData(file, function() {
                                                                var orientation = EXIF.getTag(this, "Orientation");
                                                                var imageWidth = imageWidth = EXIF.getTag(this, "PixelXDimension");;
                                                                var imageHeight = imageHeight = EXIF.getTag(this, "PixelYDimension");

                                                                if(!imageWidth){
                                                                    imageWidth = EXIF.getTag(this, "ImageWidth");
                                                                }
                                                                if(!imageHeight){
                                                                    imageHeight = EXIF.getTag(this, "ImageHeight");
                                                                }

                                                                var _h = 0;

                                                                if(orientation != 1 ){
                                                                    _h = Math.min( maxHeight , $(".image-container").width() * imageWidth / imageHeight );
                                                                    $(".image-container").height( _h);
                                                                }else{
                                                                    _h = Math.min(maxHeight , $(".image-container").width() * imageHeight / imageWidth )
                                                                    $(".image-container").height( _h);
                                                                }

                                                                try{
                                                                    cropper.destroy();
                                                                }catch(e){

                                                                }

                                                                cropper = new Cropper( $('#displayImage').get(0) , {
                                                                    ready() {
                                                                        var _data = cropper.getImageData();
                                                                        $('#onCropperBtn').hide();
                                                                        $('#doCrop').removeClass('hide');

                                                                        cw.loader(false);
                                                                    },
                                                                    aspectRatio: NaN,
                                                                    zoomable: true,
                                                                    viewMode: 1,
                                                                    dragMode: 'move',
                                                                    modal: false,
                                                                    autoCropArea: 0.3,
                                                                    zoomOnWheel: false,
                                                                    crop(event) {
                                                                    },
                                                                });
                                                            });



                                                        } else {

                                                            $('#displayImage').attr("src", "/images/noimage.jpg");
                                                            $("#fileHash").val("");
                                                            $('#select-upload-file').val(null);

                                                            alert(json.msg);
                                                            cw.loader(false);

                                                        }
                                                    },

                                                    error: function () {

                                                        // $displayImage.attr("src", "/images/noimage.jpg");
                                                        $("#fileHash").val("");
                                                        $('#select-upload-file').val(null);
                                                        cw.loader(false);
                                                        alert("파일 확인 오류 입니다.\n다시 선택해 주세요.");

                                                    }
                                                });


                                            }
                                        };

                                    }

                                });

                            reader.readAsArrayBuffer(file);

                        } else {

                            // $displayImage.attr("src", "/images/noimage.jpg");
                            $("#fileHash").val("");
                            $('#select-upload-file').val(null);
                            alert("jpg파일을 올려야합니다.");

                            cw.loader(false);
                            return false;

                        }

                    }

                });


            // 3. 바운딩박스 활성화
            $('#onCropperBtn').on('click', function () {

                if ( !isAvailableAddImage() ) {
                    alert('바운딩은 최대 3개까지만 가능합니다.');
                    cw.loader(false);
                    return false;
                }

                $('#camera-btn > a').addClass('disabled');

                $('#onCropperBtn').hide();
                $('#doCrop').removeClass('hide');

                let displayImage = document.querySelector('#displayImage');

                cropper.crop();
                buttonEnabled(false);

            });


            // 4. 등록 완료
            $('#doCrop').on('click', function () {
                cw.loader(true);
                let _uuid = uuid();

                setTimeout(function(){



                    let croppedCanvas = cropper.getCroppedCanvas({
                        fillColor: '#fff',
                        imageSmoothingEnabled: true,
                        imageSmoothingQuality: 'high',
                    });

                    $('#doCrop').addClass('hide');
                    $('#onCropperBtn').show();

                    let $li = $('<li></li>');
                    let $div = $('<div></div>');
                    let $ADD_LABEL = $("<button class='ui button ADD-LABEL' style='padding:10px 15px;font-size:0.95rem;max-width: 100px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;'>라벨링</button>");
                    let $EDIT_LABEL = $("<button class='ui button EDIT-LABEL' style='padding:10px 15px;font-size:0.95rem;'>영역수정</button>");
                    let $DELETE_ITEM = $("<button class='ui button DELETE-ITEM red' style='padding:10px 15px;font-size:0.95rem;'>삭제</button>");

                    $li.prepend($div);
                    $div.append($ADD_LABEL, $EDIT_LABEL, $DELETE_ITEM);
                    $("#imageList").append($li);
                    $li.prepend(croppedCanvas);

                    var lable_data = {};
                    lable_data.box = cropper.getData();
                    lable_data.crop = cropper.getCanvasData();
                    lable_data.label = "";
                    lable_data.state = "WORK";

                    $li.data("data", lable_data);

                    $('#camera-btn > a').removeClass('disabled');
                    $('#btn-save-file').attr('disabled', false);
                    buttonEnabled(true);

                    cropper.clear();
                    cropper.reset();
                    cw.loader(false);

                },100)
            });


            // 수정완료
            $('#doEditCrop').on('click', function () {

                cw.loader(true);

                setTimeout(function(){

                    $('#doEditCrop').addClass('hide');
                    $('#onCropperBtn').show();

                    var li = $("#imageList li.selected");
                    var data = li.data("data");
                    data.box = cropper.getData();
                    data.crop = cropper.getCanvasData();

                    li.data("data",data);

                    let croppedCanvas = cropper.getCroppedCanvas({
                        fillColor: '#fff',
                        imageSmoothingEnabled: true,
                        imageSmoothingQuality: 'high',
                    });
                    $(li).find("canvas").remove();
                    $(li).prepend(croppedCanvas);
                    cropper.clear();
                    cropper.reset();

                    buttonEnabled(true);
                    $('#camera-btn > a').removeClass('disabled');

                    cw.loader(false);

                },100);

            });





            // modal X icon, 취소 버튼
            $('i.close, .deny').on('click', function () {

                if ( $(this).data('value') === "LABELING" ) {

                    resetLabelingModal();

                }

                if ( $(this).data('value') === "RETAKE" ) {

                    $('.ui.modal.reTake').css('display', 'none');
                    $('.reTakeModalWrapper').addClass('hide');

                }

            });

            $("#btn-done").bind("click",function(){
                if(confirm("작업을 종료 하시겠습니까?")){
                    cw.action.work_stop();
                }
            })

        };

        // 페이지 초기화
        cw.reset = function () {
            $(':focus').blur(); // 모든 포커스 해제
            $('#question').html('');
            $('#answer').html('');
            $('.selected').removeClass('selected');
            return false;
        };

        // 데이터 추출
        cw.getWorkData = function () {

            // 저장할 데이터

            // 리턴데이터
            var result = {};

            var workObjectNumber = 1;

            fileJsonData['label-list'] = [];

            $("#imageList li").each(function(index,documentElement){
                var data = $(this).data("data");
                data.box.rotate = 0;
                fileJsonData['label-list'].push(data);
            });

            workObjectNumber = $("#imageList li").length;

            if (!workObjectNumber) {
                result.success = false;
                result.msg = "선택된 값이 없습니다.";
            }
            else {
                result.success = true;
            }

            result.jsonData = JSON.stringify(fileJsonData);		// 필수

            result.workObjectNumber = workObjectNumber;	 	// 오브젝트 단위에서는 1, 안줄경우 기본이 1로 저장된다.

            return result;
            // 검수에서 jsonData overWrite시에는 workObjectNumber까지 변경하진 않는다.
        };

        // 작업 시작
        cw.run();

    };

    function isAvailableAddImage() {
        if ( $('#imageList > li').length < 3 ) {
            return true
        } else {
            return false;
        }
    }

    function get_page_title() {
        var result = {};
        result.type = "text";
        result.value = "${prjNm}";
        result.isBack = true;
        result.url = 'HOME';
        return JSON.stringify(result);
    }


    function saveFileData() {

        if (fileJsonData["fileId"]) {
            $('#camera-btn > a').attr('data-value', 0);
            $('.REJECT-MSG').remove();
            $('#displayImage').remove();
            realSaveData();
            return;
        }

        var file = $("#select-upload-file")[0].files[0];
        var formData = new FormData();
        formData.append("result_data", file);
        formData.append("taskId", $('#taskId').val());
        /* formData.append("dataId", $('#dataIdx').val()); */
        formData.append("dataId", $('#dataId').val());
        var hash = {}
        hash[file.name] = $("#fileHash").val();
        formData.append("hsv", JSON.stringify(hash));

        $.ajax({
            url: '/cw/working/task/result-file-rotate.do',
            type: 'POST',
            dataType: 'json',
            cache: false,
            async: false,
            contentType: false,
            processData: false,
            data: formData,
            beforeSend: function (xhr) {

                xhr.setRequestHeader("mid", mid);
                xhr.setRequestHeader("deviceId", deviceId);
                xhr.setRequestHeader("launchToken", launchToken);
                xhr.setRequestHeader("platform", platform);
                xhr.setRequestHeader("os", os);
                xhr.setRequestHeader("app_ver", app_ver);
            },

            success: function (json) {
                if ( json.result === 'OK' ) {


                    if ( !json.data[0] ) {
                        alert("예기치 못한 오류가 발생하였습니다.");
                        location.reload();
                        saveFlag = false;
                    }

                    fileJsonData["fileId"] = json.data[0];

                    // resetWorkspace();
                    $('#displayImage').remove();
                    realSaveData();

                } else {
                    alert(json.msg);
                    cw.loader(false);
                    saveFlag = false;
                }

            },

            error: function (json) {
                alert(json.msg);
                cw.loader(false);
                saveFlag = false;

            }
        });

    }

    function realSaveData() {

        let data = {};
        if ( cw.mode === 'normal' ) {
            data = cw.getWorkData();
            data.workObjectNumber;
            // if ( data.workObjectNumber === 0 ) {
            //     alert('[!!]오브젝트 수가 정의 되지 않았습니다.');
            //     saveFlag = false;
            //     return false;
            // }

            if ( !cw.action.validation_data(data) ) {
                saveFlag = false;
                return false;
            }


            data.problemYn = 0;
        }

        cw.saveData(function () {
            if ( cw.options.reloadAfterWork ) {
                location.reload();
            } else {
                saveFlag = false;
                cw.assignGetData();
            }
        }, data);

        console.log('타니???: ', data);

    }

    function resetLabelingModal() {
        $('.labelingModalWrapper').addClass('hide');
        $('.ui.modal.LABELING').css('display', 'none');
        $('input[type="radio"]').prop('checked', false);
        $('.description > .menu > .item').removeClass('active');
        $('.description > .menu > .item').first().addClass('active');
        $('.tab').removeClass('active');
        $('.tab').each(function() {
            if ($(this).data('tab') === 'first') {
                $(this).addClass('active');
            }
        });
    };

    function resetWorkspace() {
        $("#camera-btn a").data('value', 0);
        $('#camera-btn > a > span').text('사진찍기');
        $('#onCropperBtn').prop('disabled', true);
        // $("#displayImage").attr("src", "/images/noimage.jpg");
        $("#imageList li").remove();
        $('#btn-save-file').attr('disabled', true);
    };

    function buttonEnabled(bool) {
        if ( bool ) {
            $("#imageList button").removeAttr("disabled", "disabled");
            $('#btn-save-file').removeAttr("disabled", "disabled");
        } else {
            $("#imageList button").attr("disabled", "disabled");
            $('#btn-save-file').attr("disabled", "disabled");
        }
    };

    function uuid() {
        function s4() {
            return ((1 + Math.random()) * 0x10000 | 0).toString(16).substring(1);
        }

        return s4();
    };

    function setCategory(tabDOM, workNext) {

        if (!workNext) {

            // 이미지 카테고리 구분 라벨 추가
            tabDOM.each(function (index, item) {

                let $this = $(this);

                let radioBtnHTML = '<div class="ui form">\n' +
                    '<div class="scrolling content" style="max-height: unset;"><div class="inline fields">';

                for (let i = 0; i < category[$this.data('value')].length; i++) {

                    let id = $this.data('value') + i;

                    radioBtnHTML += '<div class="field" style="margin:1em 0;">\n' +
                        '<div class="ui radio checkbox">\n' +
                        '<input type="radio" name="item" value="' + category[$this.data('value')][i] + '" id="' + id + '">\n' +
                        '<label for="' + id + '">' + category[$this.data('value')][i] + '</label>\n' +
                        '</div>\n' +
                        '</div>';

                }

                radioBtnHTML += '</div></div></div>';

                $this.append(radioBtnHTML);
                radioBtnHTML = '';

            })
        }

    }

</script>
<script type="text/javascript" src="/js/cw/workspace/cw-workspace.js?v=<%=System.currentTimeMillis() %>">/* 공통 스크립트 */</script>
