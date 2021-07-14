//
//  LoadFromAppClipView.swift
//  Clew
//
//  Created by Berwin Lan on 7/9/21.
//  Copyright © 2021 OccamLab. All rights reserved.
//

import SwiftUI

/// Puts a placeholder loading screen when invoking from a URL.
struct LoadFromAppClipView: View {
    
    var body: some View {
        Text(NSLocalizedString("loadingText", comment: "This is the text that is displayed when the app clip needs time to load something."))
    }
}

struct LoadFromAppClipView_Previews: PreviewProvider {
    static var previews: some View {
        LoadFromAppClipView()
    }
}
