//
//  CalenderView.swift
//  LiftWell
//
//  Created by Chinthan Prasad on 5/8/23.
//

import SwiftUI

struct DateScrollerView: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: prevMonth){
                Image(systemName: "arrow.left").imageScale(.large).font(Font.title.weight(.bold))
            }
            Text(CalendarHelper().monthYearString(dateHolder.date))
                .foregroundStyle(.purple.gradient)
                .font(.custom("GillSans-SemiboldItalic", size: 40))
                .bold()
                .frame(maxWidth: .infinity)
            Button(action: nextMonth){
                Image(systemName: "arrow.right").imageScale(.large).font(Font.title.weight(.bold))
            }
            Spacer()
            
        }
    }
    
    func prevMonth(){
        dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
    }
    func nextMonth(){
        dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
    }
}


struct CalenderView: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    
    
    var body: some View {
        
        DateScrollerView().environmentObject(dateHolder).padding()
        dayOfWeekStack
        calendarGrid
    }
    
    var dayOfWeekStack: some View {
        HStack(spacing: 1){
            Text("Sun").dayOfWeekText()
            Text("Mon").dayOfWeekText()
            Text("Tue").dayOfWeekText()
            Text("Wed").dayOfWeekText()
            Text("Thu").dayOfWeekText()
            Text("Fri").dayOfWeekText()
            Text("Sat").dayOfWeekText()
        }
    }
    
    var calendarGrid: some View {
        

        
        VStack(spacing: 1){
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            
            ForEach(0..<6){
                row in
                HStack(spacing: 1){
                    ForEach(1..<8){
                        column in
                        let count = column + (row*7)
                        CalendarCell(count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth).environmentObject(dateHolder)
                    }
                }
            }
        }.frame(maxHeight: .infinity)
    }
    
    
}

struct MonthStruct {
    var monthType: MonthType
    var dayInt: Int
    func day() -> String {
        return String(dayInt)
    }
}

enum MonthType{
    case Previous
    case Current
    case Next
}


struct CalendarCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    var imageNames: [String] = ["rest_icon", "triceps_icon", "shoulder_icon", "biceps_icon", "leg_icon", "back_icon", "chest_icon"]
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
            
            if monthStruct().monthType == MonthType.Current {
                Text(monthStruct().day())
                    .font(.custom("GillSans-SemiboldItalic", size: 20))
                    .foregroundColor(.purple)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 5, y: 0)
                
                let index = (count - 1) % 7
                let imageName = imageNames[index]
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            } else {
                Text(monthStruct().day())
                    .font(.custom("GillSans-SemiboldItalic", size: 20))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 5, y: 0)
            }
        }
         
        
    }
    
    func monthStruct() -> MonthStruct {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if(count <= start){
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: MonthType.Previous, dayInt: day)
        } else if (count - start > daysInMonth) {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
        
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    }
    
}

struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView()
    }
}

extension Text {
    func dayOfWeekText() -> some View {
        self.frame(maxWidth: .infinity).padding(.top).foregroundStyle(.purple.gradient)
            .font(.custom("GillSans-SemiboldItalic", size: 20))
    }
}
