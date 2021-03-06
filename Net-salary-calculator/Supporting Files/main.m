//
//  main.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 02.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BNAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        int retval;
        @try{
            retval = UIApplicationMain(argc, argv, nil, NSStringFromClass([BNAppDelegate class]));
        }
        @catch (NSException *exception)
        {
            NSLog(@"Gosh!!! %@", [exception callStackSymbols]);
            @throw;
        }
        return retval;
    }
}
