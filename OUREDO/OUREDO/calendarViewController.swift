//
//  calendarViewController.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/13.
//


import UIKit
import FSCalendar

class CalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource {


    @IBOutlet var calendarView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CalendarVC - viewDidLoad called")

        calendarView.scope = .week
        
        //날짜 값 한국어로 바꾸기
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 헤더의 날짜 포맷 설정
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendarView.appearance.headerTitleColor = UIColor.link

        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendarView.appearance.headerTitleAlignment = .center

        // 헤더 높이 설정
        calendarView.headerHeight = 40
        
        //주말은 색깔 바꾸기
        calendarView.appearance.titleWeekendColor = .red
        
        //헤더의 흐릿한 다음 원 또는 년 제거하기
        calendarView.appearance.headerMinimumDissolvedAlpha = 0
        
        // 달력의 평일 날짜 색깔
        calendarView.appearance.titleDefaultColor = .gray
        func calendarStyle(){

            //언어 한국어로 변경
                calendarView.locale = Locale(identifier: "ko_KR")
                
            
            //MARK: -상단 헤더 뷰 관련
            calendarView.headerHeight = 66 // YYYY년 M월 표시부 영역 높이
            calendarView.weekdayHeight = 41 // 날짜 표시부 행의 높이
            calendarView.appearance.headerMinimumDissolvedAlpha = 0.0 //헤더 좌,우측 흐릿한 글씨 삭제
            calendarView.appearance.headerDateFormat = "YYYY년 M월" //날짜(헤더) 표시 형식
            calendarView.appearance.headerTitleColor = .black //2021년 1월(헤더) 색
            calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24) //타이틀 폰트 크기
               
               
            //MARK: -캘린더(날짜 부분) 관련
            calendarView.backgroundColor = .white // 배경색
            calendarView.appearance.weekdayTextColor = .black //요일(월,화,수..) 글씨 색
            calendarView.appearance.titleWeekendColor = .black //주말 날짜 색
            calendarView.appearance.titleDefaultColor = .black //기본 날짜 색
                
                
                //MARK: -오늘 날짜(Today) 관련
            calendarView.appearance.todayColor = .clear //Today에 표시되는 선택 전 동그라미 색
            calendarView.appearance.todaySelectionColor = .none  //Today에 표시되는 선택 후 동그라미 색
                
                
                // Month 폰트 설정
            calendarView.appearance.headerTitleFont = UIFont(name: "NotoSansCJKKR-Medium", size: 16)
                
                
                // day 폰트 설정
            calendarView.appearance.titleFont = UIFont(name: "Roboto-Regular", size: 14)
        }
        
        
//        // 헤더의 날짜 포맷 설정
//        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
//
//        // 헤더의 폰트 색상 설정
//        calendarView.appearance.headerTitleColor = UIColor.link
//
//        // 헤더의 폰트 정렬 설정
//        // .center & .left & .justified & .natural & .right
//        calendarView.appearance.headerTitleAlignment = .left
//
//        // 헤더 높이 설정
//        calendarView.headerHeight = 45
//
//        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
//        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
    }
}
