/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct AwardsView: View {
	@EnvironmentObject var flightNavigation: AppEnvironment
	
	var awards: [AwardInformation] {
		flightNavigation.awardList
	}
	
	private var activeAwards: [AwardInformation] {
		awards.filter { $0.awarded }
	}
	
	private var inactiveAwards: [AwardInformation] {
		awards.filter { !$0.awarded }
	}
	
	private var awardColoumns: [GridItem] {
		[GridItem(.adaptive(minimum: 150, maximum: 170))]
	}
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: awardColoumns) {
				AwardGrid(title: "Redeemed", awards: activeAwards)
				AwardGrid(title: "Redeem", awards: inactiveAwards)
			}
		}
		.padding()
		.navigationBarTitle("Your Awards")
	}
}

struct AwardGrid: View {
	var title: String
	var awards: [AwardInformation]
	
	var body: some View {
		Section {
			ForEach(awards, id: \.self) { award in
				NavigationLink(destination: AwardDetails(award: award)) {
					AwardCardView(award: award)
						.foregroundColor(.black)
						.aspectRatio(0.67, contentMode: .fit)
				}
			}
		} header: {
			Text(title)
				.font(.title)
				.foregroundColor(.black)
		}
	}
}

struct AwardsView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			AwardsView()
		}
		.previewDisplayName("Awards View")
		.environmentObject(AppEnvironment())
	}
}
