//
//  StepperView.swift
//  Test task Effective Mobile
//
//  Created by Илья Синицын on 12.10.2022.
//

import SwiftUI

struct StepperView: View {
    var text: Int
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int
    let onIncrement: (() -> Void)?
    let onDecrement: (() -> Void)?
    @State private var valueChanged = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 26)
                    .frame(width: 26, height: 68)
                    .foregroundColor(Color(UIColor(red: 0.158, green: 0.156, blue: 0.262, alpha: 1).cgColor))
                
                VStack(alignment: .center, spacing: 0) {
                    Button {
                        decrement()
                    } label: {
                        Image("minus")
                            .frame(width: 25, height: 22)
                    }
                    .buttonStyle(.borderless)
                    .foregroundColor(.white)
                    
                    Text(text.description)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Button {
                        increment()
                    } label: {
                        Image("plus")
                            .frame(width: 25, height: 22)
                    }
                    .buttonStyle(.borderless)
                    .foregroundColor(.white)
                }
            }
        }
        .frame(width: 26, height: 68)
        .onAppear() {
            if value < range.lowerBound {
                value = range.lowerBound
            } else if value > range.upperBound {
                value = range.upperBound
            }
        }
    }
    
    func decrement() {
        if value > range.lowerBound {
            value -= step
            valueChanged = true
        }
        if value < range.lowerBound {
            value = range.lowerBound
        }
        if let onDecrement = onDecrement {
            if valueChanged {
                onDecrement()
                valueChanged = false
            }
        }
    }

    func increment() {
       if value < range.upperBound {
           value += step
           valueChanged = true
       }
       if value > range.upperBound {
           value = range.upperBound
       }
       if let onIncrement = onIncrement {
           if valueChanged {
               onIncrement()
               valueChanged = false
           }
       }
   }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
