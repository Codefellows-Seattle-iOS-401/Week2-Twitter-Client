
import UIKit



                        ////// CLASS 9 \\\\\\
                        ///// 10/20/16 \\\\\


/*
 #NOTES:
 
 
 * lazy loading
--> loading something until accessed, will not be instantiated until access
    
    - always a variable(start out as nothing, then being set)
    - good in collection views
 
 * Nib's/Xib's *
--> in Xcode 3.1, Xib's/Nib's allowed developer's to create interfaces graphically instead of programatically
 
    - create single layout for a view controller
    - create non-view controller related views(cells, header/footer view)
    - interface objects
 
 -- life cycle
    - loads content into memory
    - its object graph is unarchived(NSKeyedUnarchiver)
    - all connections reestablish
    - awakeFromNib() is sent to all appropriare objects(good place to setup your view)
 
 -- NIB workflow
    - create empty XIB
    - create subclass
    - in viewDidLoad() or other appropriate method, call registerNib:ForCellReuseIdentifier: on your tableView
 
 
 ** UITableView -- Header View **
    
    - just a UIView
    - top or bottom of a table section
    - display info for section in focus
    - UITableViewHeaderFooterView can be used without subclassing, usually
    - tableView:titleForHeaderInSection: to display a custom section title
 
 ** Image Assets **
 --> container for a collection of images that represent multiple ways of describing a single piece of artwork

    - grouping multiple images of the same item at different display scales
    - supports image sets, app icons, launch images
    - drag image to XCAsset, an image set will be created for it
        -- 1x = non-retina
        -- 2x = retina
        -- 3x = retina-HD
    - image sets can be configured to be device or size class specific
    - name with @1x, @2x, or @3x to the end of your image(not extension, but directly before!!!)
    
 -- optimization
    - static images, not vector, will be sized for you
    - check whether current device is 1X, 2X, or 3X
 
 -- resizing images
    - UIImage extension to resize
    - "Context" means there is a space for drawing something
    -
 
 
 
 */




var newFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
print(newFrame)
newFrame.origin.x = 4
newFrame





