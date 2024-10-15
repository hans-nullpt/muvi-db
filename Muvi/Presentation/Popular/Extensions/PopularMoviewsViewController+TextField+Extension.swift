//
//  PopularMoviewsViewController+TextField+Extension.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 15/10/24.
//

import Foundation
import UIKit

extension PopularMoviesViewController: UISearchTextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    if let keyword = textField.text, !keyword.isEmpty {
      Task {
        try await viewModel.searchMovie(keyword)
      }
    } else {
      Task {
        try await viewModel.getPopularMovies()
      }
    }
    
    return true
  }
}
