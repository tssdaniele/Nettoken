//
//  NettokenViewModel.swift
//  Nettoken
//
//  Created by Daniele Tassone on 07/02/2023.
//

import Foundation
import Combine

protocol NettokenViewModel: ObservableObject {
    var model: NettokenModel { get set }
    var info: AlertInfo? { get set }
    init()
}

class NettokenVM {
    @Published var model: NettokenModel
    @Published var info: AlertInfo?
    var itemsFetcher: NettokenAPI
    private var disposables = Set<AnyCancellable>()
    
    required init() {
        itemsFetcher = NettokenAPI()
        model = NettokenModel(groups: [GroupModel]())
        fetchModel()
    }
}

extension NettokenVM: NettokenViewModel {
    func fetchModel(){
        itemsFetcher
            .fetchCredentialsList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure (let error):
                    self?.info =  AlertInfo(id: .info, title: "Network error", message: error.id)
                    self?.model = NettokenModel(groups: [GroupModel]())
                case .finished:
                    break
                }
            } receiveValue: { [weak self] dto in
                self?.model = dto.data.profile.toModel()
            }
            .store(in: &disposables)
    }
}

struct AlertInfo: Identifiable {
    enum AlertType {
        case info
    }
    let id: AlertType
    let title: String
    let message: String
}
