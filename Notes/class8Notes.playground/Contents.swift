
import UIKit


                        ////// CLASS 8 \\\\\\
                        ///// 10/19/16 \\\\\


/*
 #NOTES:
 
 
 *** Auto Layout ***
    --> constraint-based layout system
 
 - recommended way to go for properly laying out your interface for multiple screen sizes
 - auto layout is extremely flexible and feature rich
 - constraints are the fundamental building block of Auto Layout
    -> constraints express rules for the layot of elements in your interface
 
 * should be ONE possible layout *
 
 -- attributes
    - constraints are always attached to attributes
    - EX: left, right, top, botom, leading, trailing, centerX, centerY
    - y = mx + b

 - constant is the literal size or offset, in points of the constraint
 - multiplier is the value b/w 0.0-1.0(useful for creating ratios)
 - most constraints have a firstItem and secondItem, but width and height often have firstItem only
 
 - hugging vs resistance
    - content hugging priority
        -- how much the view resists growing due to constraints
    - compression resistance
        -- how much the view resists shrinking due to constraints
    -> both have 2 values, horizontal/vertical

 ** Automatic Row Height **
    --> dynamically resize cells based on the content
 -- WorkFlow
    - proper auto layout setup
    - ensure the elements that are going to be dynamic and dictate the height don't have fixed height constraints
    - modify the setting of the elements(label --> set lines to 0, for text view, disable scrolling
    - give tableView an estimatedRowHeight and then set its rowHeight to UITableViewAutomaticDimension
        -> automatically assigned at runtime
 
 -- acivityIndicator
    - showing a task in progress, spins while loading, disappears when done
    - assures user the app isn't stalled
 WORKFLOW
    - drag to storyboard, place at bottom of hierarchy, implement bottom and top constraint
 
 -- navigationController
    -> container view controller used for managing content view controllers

    -- content view controllers
        - present your apps content
    -- container view controller
        - manages content view controllers
 
 - nav controllers keep strong leashes on all view controllers
 - nav item
    - provides content that the nav bar displays
    - optional property called navigationItem
    - 3 positions -> left, center, right
 
 * segue *
    - supports the visual transitions b/w view controllers
    - have unique ID's
    - 3 primary types
        -- push/show
        -- modal
        -- custom
    - usually set up in storyboard
    - method we typically have to override called prepareForSegue()
 
 
 
 */







