//
//  DataSourceFacade+Favorite.swift
//  Mastodon
//
//  Created by MainasuK on 2022-1-21.
//

import UIKit
import CoreData
import CoreDataStack
import MastodonCore

extension DataSourceFacade {
    public static func responseToStatusFavoriteAction(
        provider: DataSourceProvider,
        status: ManagedObjectRecord<Status>,
        authenticationBox: MastodonAuthenticationBox
    ) async throws {
        let selectionFeedbackGenerator = await UISelectionFeedbackGenerator()
        await selectionFeedbackGenerator.selectionChanged()
        
        _ = try await provider.context.apiService.favorite(
            record: status,
            authenticationBox: authenticationBox
        )
    }
}
