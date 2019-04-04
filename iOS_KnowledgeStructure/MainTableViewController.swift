//
//  MainTableViewController.swift
//  iOS_KnowledgeStructure
//
//  Created by 周飞 on 2018/10/31.
//  Copyright © 2018年 zhf. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        return footer
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MainTableViewModel.shared.dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = MainTableViewModel.shared.dataSource[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let coor = MainTableCoordinater(self.navigationController!)
        switch indexPath.row {
        case 0:
            coor.pushStoryBoardVC("ThreadViewController")
        case 1:
            let vc = DecoderEncoderVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            coor.pushStoryBoardVC("HybirdViewController")
        case 3:
            let vc = AlertWindowVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = StringRetainCountVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = UnkonwMessageVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = ChainOfTransformVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = LocationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            let vc = PhotoSaveAndVisitVc()
            self.navigationController?.pushViewController(vc, animated: true)
        case 9:
            let vc = ScrolleViewApplyVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 10:
            let vc = RunLoopViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 11:
            let vc = CustomNavigationBarVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 12:
            let vc = ArrayFiltrateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 13:
            let vc = LifeCycleViewController(nibName: "LifeCycleViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        case 14:
            let vc = PickerViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 15:
            let vc = CoreText_CoreImageVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case 16:
            let vc = EightLockViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 17:
            let vc = AI_ViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 18:
            let vc = LocationNotificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 19:
            let vc = CoreDataViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            print("未知...")
        }
        
    }

   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
