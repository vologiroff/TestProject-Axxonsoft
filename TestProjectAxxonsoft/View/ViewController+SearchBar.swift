//
//  ViewController+SearchBar.swift
//  TestProjectAxxonsoft
//
//  Created by Kantemir Vologirov on 11/9/20.
//  Copyright © 2020 Kantemir Vologirov. All rights reserved.
//

import UIKit

extension ViewController: UISearchBarDelegate {

func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    videosArray = videosArrayCopy.filter({
        $0.friendlyNameShort.contains(searchBar.text!)
    })
    
    if(searchBar.text?.count == 0) {
        videosArray = videosArrayCopy
    }
    
    videoTable.reloadData()
    DispatchQueue.main.async {
        searchBar.resignFirstResponder()
    }
}

func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if(searchBar.text?.count == 0) {
        videosArray = videosArrayCopy
    
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    } else {
        videosArray = videosArrayCopy.filter({
            $0.friendlyNameShort.contains(searchBar.text!)
        })
    }
    
    videoTable.reloadData()
}
}

