//
//  Customer_ServiceContainer.swift
//  KenshinAppAll
//
//  Created by MaiInagaki on 2019/02/25.
//  Copyright © 2019年 KenshinT. All rights reserved.
//

import UIKit

class Customer_ServiceContainer: UITableViewController{

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }

}

