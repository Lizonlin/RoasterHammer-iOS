//
//  RoasterUI.swift
//  RoasterHammer
//
//  Created by Thibault Klein on 6/18/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import SwiftUI
import RoasterHammer_Shared

struct RoasterUI : View {
    @ObjectBinding var roastersData: RoasterInteractor

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(roastersData.roaster.detachments) { detachment in
                    DetachmentRow(roastersData: self.roastersData, detachment: detachment)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarTitle(Text(roastersData.roaster.name))
        .navigationBarItems(trailing:
            PresentationButton(
                Image(systemName: "plus")
                    .imageScale(.large)
                    .accessibility(label: Text("Add Detachment"))
                    .padding(),
                destination: ArmiesView(roastersData: roastersData)
            )
        )
        .onAppear {
            self.roastersData.getRoasterDetails()
        }
    }
}

struct DetachmentNameView: View {
    let detachment: DetachmentResponse

    var body: some View {
        HStack {
            Text(detachment.name)
                .font(.headline)
                .padding()

            Spacer()

            Text("\(detachment.totalCost) points")
                .font(.headline)
                .padding()
        }
    }
}

struct DetachmentRow: View {
    @ObjectBinding var roastersData: RoasterInteractor
    let detachment: DetachmentResponse

    var body: some View {
        VStack(alignment: .leading) {
            DetachmentNameView(detachment: detachment)

            DetachmentRoleListView(roastersData: roastersData, detachment: detachment)
                .frame(height: listHeight(forDetachment: detachment))
        }
    }

    private func listHeight(forDetachment detachment: DetachmentResponse) -> Length {
        let rolesHeight = Length(detachment.roles.count * 44)
        let unitsHeight = Length(detachment.totalUnits * 44)

        return rolesHeight + unitsHeight
    }
}

struct DetachmentRoleListView: View {
    @ObjectBinding var roastersData: RoasterInteractor
    let detachment: DetachmentResponse

    var body: some View {
        List {
            ForEach(detachment.roles) { role in
                Section(header: self.makeHeader(detachment: self.detachment, role: role)) {
                    ForEach(role.units) { selectedUnit in
                        NavigationButton(destination: EditUnitView(rosterData: self.roastersData,
                                                                   selectedUnit: selectedUnit,
                                                                   detachment: self.detachment),
                                         onTrigger: { () -> Bool in
                                            self.roastersData.selectedUnit = selectedUnit
                                            return true
                        }) {
                            Text(selectedUnit.unit.name)
                        }
                    }
                }
            }
        }
    }

    private func makeHeader(detachment: DetachmentResponse, role: RoleResponse) -> some View {
        let unitFilters = UnitFilters(armyId: "\(detachment.army.id)", unitType: role.name)
        let destination = UnitsView(
            unitsData: RoasterHammerDependencyManager
                .shared
                .unitsBuilder()
                .buildDataStore(filters: unitFilters,
                                detachmentId: detachment.id,
                                unitRoleId: role.id),
            roastersData: roastersData)

        return HeaderAndNavigationButtonHeader(text: role.name,
                                               buttonTitle: "Add",
                                               destination: destination)
    }
}

//#if DEBUG
//struct RoasterUI_Previews : PreviewProvider {
//    static var previews: some View {
//        RoasterUI()
//    }
//}
//#endif
