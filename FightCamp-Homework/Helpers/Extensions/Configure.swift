//
//  Configure.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 31.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

public protocol ExpressibleWithoutParameters {
    init()
}

extension NSObject: ExpressibleWithoutParameters { }

public extension ExpressibleWithoutParameters {
    
    /**
     
     Helper to create configured object instance.
     
     ### Usage Example: ###
     ````
     let user = User { user in
        user.id = 1
        user.name = "Jack"
     }
     ````
     
     */
    init(_ configure: (Self) -> Void) {
        
        self.init()
        
        configure(self)
    }
}
