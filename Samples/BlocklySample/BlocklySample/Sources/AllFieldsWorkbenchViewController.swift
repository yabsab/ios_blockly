/*
 * Copyright 2016 Google Inc. All Rights Reserved.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import Blockly


class AllFieldsWorkbenchViewController: WorkbenchViewController {
  // MARK: - Initializers

private var codeGenerator = Codegenerator()
    
 
    
  init() {
    super.init(style: .defaultStyle)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  // MARK: - Super
   
 
  override func viewDidLoad() {
    super.viewDidLoad()
    generateCode()
    // Don't allow the navigation controller bar cover this view controller
    self.edgesForExtendedLayout = UIRectEdge()
    self.navigationItem.title = "creamo"

    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(saveXML))
    // Load data
    loadBlockFactory()
    loadToolbox()
    loadcodingBlock()
    

  
  }

    
    
   // ------+---Date-------+----------------------------+---------------------------+
   //       +  2019.08.29  +   안재용 yabsab@kist.re.kr   +  코딩블록 save, load  기능
   //       +              +
   //       +              +
   //       +              +
   //       +              +
   // ------------------------------------------------------------------------------+
    
 
  func generateCode()
  {
    
    if let workspaceXML = FileHelper.loadContents(of: "workspace\(0).xml") {
        codeGenerator.generateCode(forKey: String(0), workspaceXML: workspaceXML)
    }
}
    
    @objc func saveXML ()
    {
    saveCoding()
     print("test")
    
    }
    
    
  // MARK: - Private

  private func loadBlockFactory() {
    do {
      try blockFactory.load(fromJSONPaths: ["AllFieldsDemo/custom_field_blocks.json"])
    } catch let error {
      print("Couldn't load `custom_field_blocks.json` into the block factory: \(error)")
    }
  }

  private func loadToolbox() {
    // Create a new toolbox with a "Blocks" category
    let toolbox = Toolbox()
    
    let Start =
        toolbox.addCategory(
            name: "Start", color: ColorPalette.green.tint400, icon: UIImage(named: ""))
    
    let blocksCategory =
      toolbox.addCategory(
        name: "Blocks", color: ColorPalette.orange.tint800, icon: UIImage(named: ""))
    
    let Loops =
        toolbox.addCategory(
            name: "Loops", color: ColorPalette.green.tint400, icon: UIImage(named: ""))
  
    let Text =
        toolbox.addCategory(
            name: "Text", color: ColorPalette.green.tint400, icon: UIImage(named: ""))
    
    let Math =
        toolbox.addCategory(
            name: "Math", color: ColorPalette.green.tint400, icon: UIImage(named: ""))
    
    let Variables =
        toolbox.addCategory(
            name: "Variables", color: ColorPalette.green.tint400, icon: UIImage(named: ""))
    
   
    let SMBlock =
        toolbox.addCategory(
            name: "SmartBlock", color: ColorPalette.green.tint400, icon: UIImage(named: ""))
    

    // Add all field blocks to the "Blocks" category
    let blockNames = [
      "field_angle_block", "field_checkbox_block", "field_colour_block", "field_date_block",
      "field_dropdown_block", "field_input_block", "field_image_local_block",
      "field_image_web_block", "field_label_block", "field_number_nonconstrained_block",
      "field_number_integer_block", "field_number_currency_block", "field_number_constrained_block",
      "field_variable_block"
    ]
    let LoopsBlocks = ["controls_repeat_ext","controls_whileUntil"]
    let TextBlocks = ["text"]
   let MathBlocks = ["math_number","math_arithmetic","math_number_property","math_trig","math_modulo","math_random_int"]
    let VariablesBlocks = ["variables_get"]
    let SmartBlocks = ["SB_digital"]
   let StartBlocks = ["creamo_Digital"]
    
    
    
    //block category1
    for SmartBlock in SmartBlocks
    {
        do
        {
        let smartblock = try blockFactory.makeBlock(name : SmartBlock)
        try SMBlock.addBlockTree(smartblock)
    }
    
    catch let error
    
    {
        print("Error adding '\(SmartBlock)' block to category: \(error)")
    }
}
    
    //block category2
    for VariablesBlock in VariablesBlocks
    {
        do
        {
            let variablesblock = try blockFactory.makeBlock(name : VariablesBlock)
            try Variables.addBlockTree(variablesblock)
        }
            catch let error
    {
        print("Error adding '\(VariablesBlock)' block to category: \(error)")
    }
}
    
    //block category3
    for MathBlock in MathBlocks
    {
        do
        {
            let listblock = try blockFactory.makeBlock(name : MathBlock)
            try Math.addBlockTree(listblock)
    }
      catch let error
      {
        print("Error adding '\(MathBlocks)' block to category: \(error)")
    }
}
    //block category4
    for TextBlock in TextBlocks
    {
        do
        {
        let textblock = try blockFactory.makeBlock(name : TextBlock)
        try Text.addBlockTree(textblock)
        }
        catch let error
    {
        print("Error adding '\(TextBlock)' block to category: \(error)")
    }
}

    
    //block category5
    
    for blockName in blockNames
    {
      do {
        let block = try blockFactory.makeBlock(name: blockName)
        
        try blocksCategory.addBlockTree(block)
       
      } catch let error {
        print("Error adding '\(blockName)' block to category: \(error)")
      }
    }
    
    
    //block category6
    for LoopsBlock in LoopsBlocks
    {
        do {
            let block = try blockFactory.makeBlock(name: LoopsBlock)
            
            try Loops.addBlockTree(block)
            
        } catch let error {
            print("Error adding '\(LoopsBlock)' block to category: \(error)")
        }
    }
    
    
    //block category7
    for StartBlock in StartBlocks
    {
        do {
            let block = try blockFactory.makeBlock(name: StartBlock)
            
            try Start.addBlockTree(block)
            
        } catch let error {
            print("Error adding '\(StartBlock)' block to category: \(error)")
        }
    }
  // Load the toolbox into the workbench
    do
    {
      try loadToolbox(toolbox)
    } catch let error {
      print("Error loading toolbox into workbench: \(error)")
      return
    }
  }
    
    
     //코딩 저장
    public func saveCoding()
    {
        
        if let workspace = workspaceViewController.workspace
        {
        do {
            let xml = try workspace.toXML()
            FileHelper.saveContents(xml, to: "0.xml")
            print(xml)
        }
        catch let error
        {
            print("could't save workspace to disk \(error)")
            
        }
        
    }
        
}
    
    //저장된 xml 로드
    public func loadcodingBlock()
    {
        do
        {
            let workspace = Workspace()
            
            
            if let xml = FileHelper.loadContents(of: "0.xml")
            
            {
                try workspace.loadBlocks(fromXMLString: xml, factory: blockFactory)
            }
            
            try  loadWorkspace(workspace)
           
            print(workspace)
            
            
        }
        catch let error
        {
        print ("cloud't load xml \(error)")
        }
        
    }

}
