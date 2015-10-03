//
//  AttributesController.swift
//  Reform
//
//  Created by Laszlo Korte on 02.10.15.
//  Copyright © 2015 Laszlo Korte. All rights reserved.
//

import Cocoa

class AttributesController : NSViewController {
    @IBOutlet var labelField : NSTextField?
    @IBOutlet var formNameField : NSTextField?
    @IBOutlet var tabs : NSTabView?
    @IBOutlet var singleTab : NSTabViewItem?
    @IBOutlet var multipleTab : NSTabViewItem?

    override var representedObject : AnyObject? {
        didSet {
            attributesViewModel = representedObject as? AttributesViewModel
        }
    }

    var attributesViewModel : AttributesViewModel?

    override func viewDidAppear() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectionChanged", name:"SelectionChanged", object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "procedureChanged", name:"ProcedureEvaluated", object: nil)

        selectionChanged()
    }

    override func viewDidDisappear() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"SelectionChanged", object: nil)


        NSNotificationCenter.defaultCenter().removeObserver(self, name:"ProcedureEvaluated", object: nil)
    }

    dynamic func selectionChanged() {
        if let model = attributesViewModel {
            tabs?.hidden = false
            if let single = model.selection.one {
                tabs?.selectTabViewItem(singleTab)
                formNameField?.stringValue = model.analyzer.stringifier.labelFor(single) ?? String(single)
            } else {
                tabs?.selectTabViewItem(multipleTab)
                labelField?.stringValue = "\(model.selection.selected.count) Forms selected"
            }
        } else {
            tabs?.hidden = true
        }
    }

    dynamic func procedureChanged() {
        if let
            model = attributesViewModel,
            single = model.selection.one {
                formNameField?.stringValue = model.analyzer.stringifier.labelFor(single) ?? ""
        }
    }
}
