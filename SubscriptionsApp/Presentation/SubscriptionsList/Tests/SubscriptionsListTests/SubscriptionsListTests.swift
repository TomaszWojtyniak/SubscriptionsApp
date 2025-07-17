import Testing
@testable import SubscriptionsList
import SubscriptionsUseCases
import Models
import Foundation

@MainActor
class SubscriptionsDataModelTests {
    
    var dataModel: SubscriptionsDataModel!
    var getSubscriptionsUseCase: MockGetSubscriptionsUseCase!
    var setSubscriptionsUseCase: MockSetSubscriptionsUseCase!
    
    func createMockSubscription(id: UUID = UUID(), name: String = "Test Subscription", cost: Double = 9.99) -> Subscription {
           return Subscription(id: id,
                               name: name,
                               monthlyCost: cost,
                               details: ProductivitySubscription(userLicenses: 4,
                                                                 hasCloudStorage: true,
                                                                 hasAdvancedSecurity: true))
       }
       
    func createDataModel(mockGetUseCase: MockGetSubscriptionsUseCase = MockGetSubscriptionsUseCase(),
                         mockSetUseCase: MockSetSubscriptionsUseCase = MockSetSubscriptionsUseCase()) -> SubscriptionsDataModel {
        
        return SubscriptionsDataModel(getSubscriptionsUseCase: mockGetUseCase,setSubscriptionsUseCase: mockSetUseCase)
    }
       
    @Test func testGetSubscriptionsDataSuccess() async throws {
        let mockSubscriptions = [
           createMockSubscription(name: "Netflix"),
           createMockSubscription(name: "Spotify")
        ]

        let mockGetUseCase = MockGetSubscriptionsUseCase()
        mockGetUseCase.subscriptionsToReturn = mockSubscriptions

        let dataModel = createDataModel(mockGetUseCase: mockGetUseCase)

        await dataModel.getSubscriptionsData()

        #expect(dataModel.subscriptions.count == 2)
        #expect(dataModel.subscriptions[0].name == "Netflix")
        #expect(dataModel.subscriptions[1].name == "Spotify")
        #expect(dataModel.isShowingErrorAlert == false)
    }

    @Test func testGetSubscriptionsDataFailure() async throws {
        let mockGetUseCase = MockGetSubscriptionsUseCase()
        mockGetUseCase.shouldThrowError = true
        mockGetUseCase.errorToThrow = MockError.networkError

        let dataModel = createDataModel(mockGetUseCase: mockGetUseCase)

        await dataModel.getSubscriptionsData()

        #expect(dataModel.subscriptions.isEmpty)
        #expect(dataModel.isShowingErrorAlert == true)
    }
}
