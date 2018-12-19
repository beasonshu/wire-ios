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

class VerifyPhoneStepSecondaryView: TeamCreationSecondaryViewDescription {
    let views: [ViewDescriptor]
    weak var actioner: AuthenticationActioner?

    init(phoneNumber: String) {
        let resendCode = ButtonDescription(title: "team.activation_code.button.resend".localized, accessibilityIdentifier: "resend_button")
        let changePhoneNumber = ButtonDescription(title: "team.activation_code.button.change_phone".localized, accessibilityIdentifier: "change_phone_button")
        views = [resendCode, changePhoneNumber]

        resendCode.buttonTapped = {
            self.actioner?.repeatAction()
        }

        changePhoneNumber.buttonTapped = { [weak self] in
            self?.actioner?.executeAction(.unwindState(withInterface: true))
        }
    }
}

final class VerifyPhoneStepDescription: TeamCreationStepDescription {
    let phoneNumber: String
    let backButton: BackButtonDescription?
    let mainView: ViewDescriptor & ValueSubmission
    let headline: String
    let subtext: String?
    let secondaryView: TeamCreationSecondaryViewDescription?

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        backButton = nil
        mainView = VerificationCodeFieldDescription()
        headline = "team.phone_activation_code.headline".localized
        subtext = "team.activation_code.subheadline".localized(args: phoneNumber)
        secondaryView = VerifyPhoneStepSecondaryView(phoneNumber: phoneNumber)
    }

    func shouldSkipFromNavigation() -> Bool {
        return true
    }
}