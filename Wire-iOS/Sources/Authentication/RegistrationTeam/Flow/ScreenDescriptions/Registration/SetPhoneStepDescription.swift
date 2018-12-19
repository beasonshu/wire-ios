//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

class SetPhoneStepSecondaryView: TeamCreationSecondaryViewDescription {
    let views: [ViewDescriptor]
    let learnMore: ButtonDescription

    weak var actioner: AuthenticationActioner?

    init() {
        self.learnMore = ButtonDescription(title: "team.email.button.learn_more".localized, accessibilityIdentifier: "learn_more_button")
        let useEmailButton = ButtonDescription(title: "registration.register_by_email".localized, accessibilityIdentifier: "register_by_email_button")
        self.views = [useEmailButton]

        useEmailButton.buttonTapped = { [weak self] in
            self?.actioner?.executeAction(.switchCredentialsType(.email))
        }

        learnMore.buttonTapped = { [weak self] in
            let url = URL.wr_emailInUseLearnMore.appendingLocaleParameter
            self?.actioner?.executeAction(.openURL(url))
        }
    }

    func display(on error: Error) -> ViewDescriptor? {
        guard (error as NSError).userSessionErrorCode == .emailIsAlreadyRegistered else {
            return nil
        }

        return learnMore
    }
}

final class SetPhoneStepDescription: TeamCreationStepDescription {

    let backButton: BackButtonDescription?
    let mainView: ViewDescriptor & ValueSubmission
    let headline: String
    let subtext: String?
    let secondaryView: TeamCreationSecondaryViewDescription?

    init() {
        backButton = BackButtonDescription()
        mainView = TextFieldDescription(placeholder: "registration.email.textfield.placeholder".localized, actionDescription: "registration.email.textfield.accessibility".localized, kind: .email)
        headline = "team.email.headline".localized
        subtext = "registration.phone.subheadline".localized
        secondaryView = SetPhoneStepSecondaryView()
    }

}