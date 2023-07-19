//
//  ContentView.swift
//  ColorViewSliderSUI
//
//  Created by Наталья Миронова on 19.07.2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var redSladerValue = Double.random(in: 0...255)
	@State private var blueSladerValue = Double.random(in: 0...255)
	@State private var greenSladerValue = Double.random(in: 0...255)
	
	@State private var alertPresented = false
	
	@FocusState var isInputActive: Bool
	
	var body: some View {
		ZStack {
			Color.blue.opacity(0.7)
				.ignoresSafeArea()
			VStack {
				Rectangle()
					.cornerRadius(CGFloat(50))
					.frame(height: 200)
					.foregroundColor(Color(red: redSladerValue / 255, green: greenSladerValue / 255, blue: blueSladerValue / 255))
					.overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.white, lineWidth: 4))
					.padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
				VStack {
					ColorSliderView(value: $redSladerValue, color: .red)
					ColorSliderView(value: $blueSladerValue, color: .blue)
					ColorSliderView(value: $greenSladerValue, color: .green)
				}
				.focused($isInputActive)
				.toolbar {
					ToolbarItemGroup(placement: .keyboard) {
						
						Spacer()
						
						Button("Done", action: checkUserValue)
							.alert("Заголовок", isPresented: $alertPresented) {
								Button("Ok") {}
							} message: {
								Text("Некорректное значение! Введите число от 0 до 255.")
							}
					}
				}
				Spacer()
			}
			.padding()
		}
	}
	
	private func checkUserValue() {
		isInputActive = false
		//	alertPresented.toggle()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct ColorSliderView: View {
	
	@Binding var value: Double
	
	let color: Color
	
	var body: some View {
		HStack {
			Text("\(lround(value))")
				.frame(width: 35)
			Slider(value: $value, in: 0...255, step: 1)
				.accentColor(color)
			TextField("", value: $value, formatter: NumberFormatter())
				.textFieldStyle(.roundedBorder)
				.frame(width: 50)
				.keyboardType(.numberPad)
		}
	}
}

