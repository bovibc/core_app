//
//  CalendarView.swift
//  core_app
//
//  Created by Larissa Fazolin on 04/04/24.
//

import BackendLib
import SwiftData
import SwiftUI

struct CalendarView: View {
    @Environment(\.modelContext) private var context
    //TODO: retirar cycle service
    @State var cycleService: CycleService
    @Binding var date: Date {
        didSet {
            
        }
    }
    @State var cycle: Cycle

    var monthToPass = Calendar.current.component(.month, from: Date())
    var yearToPass = Calendar.current.component(.year, from: Date())
    
    init(cycleService: CycleService, date: Binding<Date>) {
        self.cycleService = cycleService
        self._date = date
        
        
    }
    
    static func getCycleByDate(cycles: [Cycle], date: Date) -> Cycle {
        
    }

    var body: some View {
        ScrollView {
            HStack {
                LazyVStack(alignment: .leading) {
                    // Greetings
                    Text("Hello, Julia!")
                        .font(.system(.title2))

                    LazyHStack {
                        // Calendar
                        CalendarComponent(month: monthToPass,
                                          year: yearToPass,
                                          date: $date)

                        LazyVStack(alignment: .leading) {
                            // Begin cycle
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 142, height: 78)

                            // Current cycle phase
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 317, height: 281)
                        }
                    }
                    .padding(.bottom, 32)

                    // Selected date
                    Text("Thursday, 14 March 2024")
                        .bold()
                        .font(.system(.title))

                    Text("Personal Records")
                        .font(.system(.title2))

                    LazyHStack(alignment: .top) {
                        LazyVStack {
                            SelectedFrame(cycle: cycleService.cycles.first!,
                                          context: context, selectionType: .symptons, date: Date())
                            SelectedFrame(cycle: cycleService.cycles.first!,
                                          context: context, selectionType: .mood, date: Date())
                            SexualActivityComponent(currentCycle: <#Cycle#>, currentDay: date)
                        }
                        LazyVStack {
                            LibidoIntensityFrame()
                            FlowPeriodIntensity()
                        }
                    }

                    Spacer()
                }
                .padding(.bottom, 150)
                .padding()
            }
        }
    }
}
