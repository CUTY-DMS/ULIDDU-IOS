//
//  mainViewVC.swift
//  OUREDO
//
//  Created by 박준하 on 2022/07/05.
//

import UIKit
import FSCalendar
import SwiftUI

class calendarVO: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                calendar.dataSource = self
                
                // 한달 단위(기본값)
                calendar.scope = .month
                // 일주일 단위
                calendar.scope = .week
        
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 헤더의 날짜 포맷 설정
        calendar.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendar.appearance.headerTitleColor = UIColor.link


        // 헤더 높이 설정
        calendar.headerHeight = 40
        
        //주말은 색깔 바꾸기
        calendar.appearance.titleWeekendColor = .red
        
        //헤더의 흐릿한 다음 원 또는 년 제거하기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
        // 달력의 평일 날짜 색깔
        calendar.appearance.titleDefaultColor = .gray
        func calendarStyle(){

            //언어 한국어로 변경
                calendar.locale = Locale(identifier: "ko_KR")
                
            
            //MARK: -상단 헤더 뷰 관련
            calendar.headerHeight = 66 // YYYY년 M월 표시부 영역 높이
            calendar.weekdayHeight = 41 // 날짜 표시부 행의 높이
            calendar.appearance.headerMinimumDissolvedAlpha = 0.0 //헤더 좌,우측 흐릿한 글씨 삭제
            calendar.appearance.headerDateFormat = "YYYY년 M월" //날짜(헤더) 표시 형식
            calendar.appearance.headerTitleColor = .black //2021년 1월(헤더) 색
            calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24) //타이틀 폰트 크기
               
               
            //MARK: -캘린더(날짜 부분) 관련
            calendar.backgroundColor = .white // 배경색
            calendar.appearance.weekdayTextColor = .black //요일(월,화,수..) 글씨 색
            calendar.appearance.titleWeekendColor = .black //주말 날짜 색
            calendar.appearance.titleDefaultColor = .black //기본 날짜 색
                
                
                //MARK: -오늘 날짜(Today) 관련
            calendar.appearance.todayColor = .clear //Today에 표시되는 선택 전 동그라미 색
            calendar.appearance.todaySelectionColor = .none  //Today에 표시되는 선택 후 동그라미 색
                
                
                // Month 폰트 설정
            calendar.appearance.headerTitleFont = UIFont(name: "NotoSansCJKKR-Medium", size: 16)
                
                
                // day 폰트 설정
            calendar.appearance.titleFont = UIFont(name: "Roboto-Regular", size: 14)
        }
    }
}


