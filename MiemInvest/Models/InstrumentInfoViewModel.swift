//
//  InstrumentInfoViewModel.swift
//  MiemInvest
//
//  Created by Юлия Мелькина on 24.05.2022.
//

import Foundation
import Combine

final class InstrumentInfoViewModel: ObservableObject {
    @Published var indexEndpoint: Int = 7
    @Published var instrumentId: String = "1"
    
    @Published var instrumentInfo: InstrumentInfo?
    
    init(instrumentId: String){
        self.indexEndpoint = 7
        self.instrumentId = instrumentId
        Publishers.CombineLatest($indexEndpoint, $instrumentId)
            .flatMap { (indexEndpoint, instrumentId) -> AnyPublisher<InstrumentInfo?, Never> in
                return InstrumentApi.shared.fetchInstrumentInfo(from: Endpoint(index: indexEndpoint, text: instrumentId)!)
            }
            .assign(to: \.instrumentInfo, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
}
