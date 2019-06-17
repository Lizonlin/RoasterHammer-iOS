//
//  RoastersUI.swift
//  RoasterHammer
//
//  Created by Thibault Klein on 6/16/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import SwiftUI

struct RoastersView: View {
    @EnvironmentObject private var roastersData: RoastersInteractor

    var body: some View {
        NavigationView {
            List {
                ForEach(roastersData.roasters) { roaster in
                    RoasterRow(roaster: roaster)
                }
            }
            .navigationBarTitle(Text("Rosters"), displayMode: .large)
            .navigationBarItems(leading:
                PresentationButton(
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .accessibility(label: Text("User Profile"))
                        .padding(),
                    destination: AccountUI()
                )
            )
        }
        .onAppear {
            self.roastersData.getRoasters()
        }
    }
}

#if DEBUG
struct RoastersUI_Previews : PreviewProvider {
    static var previews: some View {
        RoastersView()
    }
}
#endif
