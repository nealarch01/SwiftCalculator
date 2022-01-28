//
//  ContentView.swift
//  BasicCalculator
//
//  Created by Neal on 1/27/22.
//

import SwiftUI

struct ContentView: View {
    @State var isClear: Bool = true
    @State var currentInput: String = "0"
    @State var firstOperand: String = ""
    @State var secondOperand: String = ""
    @State var activeOperator: String = ""
    @State var isMultiplyActive: Bool = false
    @State var isDivideActive: Bool = false
    @State var isAddActive: Bool = false
    @State var isSubtractActive: Bool = false
    @State var wasResultGiven: Bool = false
    let button_height: CGFloat = 84
    let button_width: CGFloat = 84
    let button_corner_radius: CGFloat = 50
    let button_text_size: CGFloat = 28
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 10) {
                Spacer()
                HStack {
                    Spacer()
                    Text(currentInput)
                        .font(.system(size: 80))
                        .foregroundColor(Color.white)
                        .bold()
                        .padding(.trailing, 20)
                        .minimumScaleFactor(0.5)
                }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({
                    value in
                    if (value.translation.width < 0) {
                        removeFromOperand()
                    }
                }))
                .frame(height: 90)
                HStack { // first row (control buttons)
                    Button(action: {
                        clearInputOutput()
                    }, label: {
                        if isClear == true {
                            Text("AC")
                                .font(.system(size: button_text_size))
                                .bold()
                                .frame(width: button_width, height: button_height)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .opacity(0.8)
                                .cornerRadius(button_corner_radius)
                        } else {
                            Text("C")
                                .font(.system(size: button_text_size))
                                .bold()
                                .frame(width: button_width, height: button_height)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .opacity(0.8)
                                .cornerRadius(button_corner_radius)
                        }
                    }) // end of button
                    Button(action: {
                        setPositiveNegative()
                    }, label: {
                        Text("+/–")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .opacity(0.8)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: {
                        convertPercentage()
                    }, label: {
                        Text("%")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .opacity(0.8)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: { // divide button
                        setOperatorActive(operator_button_input: "/")
                    }, label: {
                        if (isDivideActive == true) {
                            Text("/")
                                .font(.system(size: button_text_size))
                                .bold()
                                .frame(width: button_width, height: button_width)
                                .foregroundColor(Color.orange)
                                .background(Color.white)
                                .cornerRadius(button_corner_radius)
                        } else {
                            Text("/")
                                .font(.system(size: button_text_size))
                                .bold()
                                .frame(width: button_width, height: button_width)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .cornerRadius(button_corner_radius)
                        }
                    })
                } // end of first row HStack
                .padding(5)
                HStack {
                    Button(action: {
                        buildOperand(button_input: "7")
                    }, label: {
                        Text("7")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: {
                        buildOperand(button_input: "8")
                    }, label: {
                        Text("8")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: {
                        buildOperand(button_input: "9")
                    }, label: {
                        Text("9")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: { // multiply button
                        setOperatorActive(operator_button_input: "*")
                    }, label: {
                        if(isMultiplyActive == true) {
                            Text("X")
                                .font(.system(size: button_text_size))
                                .bold()
                                .frame(width: button_width, height: button_width)
                                .foregroundColor(Color.orange)
                                .background(Color.white)
                                .cornerRadius(button_corner_radius)
                        } else {
                            Text("X")
                                .font(.system(size: button_text_size))
                                .bold()
                                .frame(width: button_width, height: button_width)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .cornerRadius(button_corner_radius)
                        }
                    })
                } // end of second row HStack
                .padding(5)
                HStack {
                    Button(action: {
                        buildOperand(button_input: "4")
                    }, label: {
                        Text("4")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: {
                        buildOperand(button_input: "5")
                    }, label: {
                        Text("5")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: {
                        buildOperand(button_input: "6")
                    }, label: {
                        Text("6")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: { // subtract / minus button
                        setOperatorActive(operator_button_input: "-") // NOTE: The display is a dash but the string argument is a hyphen
                    }, label: {
                        if(isSubtractActive == true) {
                            Text("–")
                                .font(.system(size: 36))
                                .bold()
                                .frame(width: button_width, height: button_width)
                                .foregroundColor(Color.orange)
                                .background(Color.white)
                                .cornerRadius(button_corner_radius)
                        } else {
                            Text("–")
                                .font(.system(size: 36))
                                .bold()
                                .frame(width: button_width, height: button_width)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .cornerRadius(button_corner_radius)
                        }
                    })
                } // end of third HStack
                .padding(5)
                HStack {
                    Button(action: {
                        buildOperand(button_input: "1")
                    }, label: {
                        Text("1")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    
                    Button(action: {
                        buildOperand(button_input: "2")
                    }, label: {
                        Text("2")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    
                    Button(action: {
                        buildOperand(button_input: "3")
                    }, label: {
                        Text("3")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: { // add button
                        setOperatorActive(operator_button_input: "+")
                    }, label: {
                        if(isAddActive == true) {
                            Text("+")
                                .font(.system(size: 36))
                                .bold()
                                .frame(width: button_width, height: button_width)
                                .foregroundColor(Color.orange)
                                .background(Color.white)
                                .cornerRadius(button_corner_radius)
                        } else {
                            Text("+")
                                .font(.system(size: 36))
                                .bold()
                                .frame(width: button_width, height: button_width)
                                .foregroundColor(Color.white)
                                .background(Color.orange)
                                .cornerRadius(button_corner_radius)
                        }
                    })
                } // end of 1,2,3,+
                .padding(5)
                HStack {
                    Button(action: {
                        buildOperand(button_input: "0")
                    }, label: {
                        Text("0")
                            .font(.system(size: button_text_size))
                            .bold()
                            .frame(width: 138, height: button_height, alignment: .leading)
                            .padding(.leading, 30)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(40)
                    })
                    Button(action: {
                        buildOperand(button_input: ".")
                    }, label: {
                        Text(".")
                            .font(.system(size: 44))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(button_corner_radius)
                    })
                    Button(action: { // equals button get the result
                        calculateResult()
                    }, label: {
                        Text("=")
                            .font(.system(size: 36))
                            .bold()
                            .frame(width: button_width, height: button_width)
                            .foregroundColor(Color.white)
                            .background(Color.orange)
                            .cornerRadius(button_corner_radius)
                    })
                }
            } // end of App View vertical stack
        }
    }
    
    
    func clearInputOutput() {
        currentInput = "0"
        isClear = true
        resetActiveButtons()
        firstOperand = ""
        secondOperand = ""
        activeOperator = ""
    }
    
    func setPositiveNegative() {
        // do something
        let firstIndex = currentInput.index(currentInput.startIndex, offsetBy: 0)
        if (currentInput[firstIndex] == "-") {
            currentInput.remove(at: firstIndex) // remove the first index
        }
        let updatedInput: String  = "-" + currentInput
        currentInput = updatedInput
    }
    
    func buildOperand(button_input: String) {
        // change to 12 once commas are added

        if(isMultiplyActive == true || isDivideActive == true || isAddActive == true || isSubtractActive == true) {
            currentInput = "" // clear the input
            resetActiveButtons()
        }
        
        if(wasResultGiven == true) {
            wasResultGiven = false
            currentInput = ""
        }
        
        if(currentInput.count > 9) {
            // do not allow any larger numbers to prevent integer overflow
            // print("Count limit exceeded")
            return;
        }

        if (currentInput == "0") {
            if (button_input == "0") {
                // print("Button input 0 detected")
                return
            } else if (button_input == ".") {
                currentInput = "0"
            } else {
                currentInput = ""
            }
        }
        if (button_input == ".") {
            if(currentInput.contains(".")) {
                // print("Second period input")
                return
            }
        }
        if (isClear == true) {
            isClear = false
        }
        currentInput = currentInput + button_input
    }
    
    func removeFromOperand() {
        if (currentInput == "0") {
           return
        }
        if(currentInput.count == 1) {
            currentInput = "0"
            return
        }
        currentInput.removeLast(1)
    }
    
    func setOperatorActive(operator_button_input: String) {
        let lastIndex = currentInput.index(currentInput.endIndex, offsetBy: -1)
        // incomplete input
        if (currentInput[lastIndex] == ".") {
            return;
        }
        firstOperand = currentInput
        resetActiveButtons()
        switch operator_button_input {
        case "*":
            activeOperator = "*"
            isMultiplyActive = true
        case "/":
            activeOperator = "/"
            isDivideActive = true
        case "+":
            activeOperator = "+"
            isAddActive = true
        case "-":
            activeOperator = "-"
            isSubtractActive = true
        default:
            activeOperator = "?"
        }
    }
    
    func convertPercentage() {
        let lastIndex = currentInput.index(currentInput.endIndex, offsetBy: -1)
        if(currentInput[lastIndex] == ".") {
            return
        }
        if(currentInput == "0" || currentInput.count > 9) {
            return
        }
        var result = Double(currentInput) ?? 0
        result = result / 100
        currentInput = String(result)
        // if the first operand was already set before percentage (operator button pressed before percentage)
        // then change firstOperand
        if(isMultiplyActive == true || isDivideActive == true || isAddActive == true || isSubtractActive == true) {
            firstOperand = currentInput
        }
    }
    
    // when the result button is pressed
    func calculateResult() {
        if (activeOperator == "" || activeOperator == "?") {
            return // don't do anything if no operator is selected
        }
        let lastIndex = currentInput.index(currentInput.endIndex, offsetBy: -1)
        if(currentInput[lastIndex] == ".") {
            return
        }
        secondOperand = currentInput
        let lhsOperand = Double(firstOperand) ?? 0
        let rhsOperand = Double(secondOperand) ?? 0
        switch activeOperator {
        case "*":
            currentInput = String(lhsOperand * rhsOperand)
        case "/":
            currentInput = String(lhsOperand / rhsOperand)
        case "+":
            currentInput = String(lhsOperand + rhsOperand)
        case "-":
            currentInput = String(lhsOperand - rhsOperand)
        default:
            // do nothing
            return
        }
        if (currentInput.count > 6) {
            let numToRemove = currentInput.count - 6
            currentInput.removeLast(numToRemove)
        }
        if(currentInput != "0" && currentInput.count >= 2) {
            let lastTwoChars = String(currentInput.suffix(2))
            if (lastTwoChars == ".0") {
                currentInput.removeLast(2)
            }
        }

        wasResultGiven = true
    }
    
    func resetActiveButtons() {
        isMultiplyActive = false
        isDivideActive = false
        isAddActive = false
        isSubtractActive = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
