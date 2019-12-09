//
//  maillistTableViewController.swift
//  TableView
//
//  Created by 李海涛 on 2018/11/6.
//  Copyright © 2019年 李海涛. All rights reserved.
//
import os.log
import UIKit

//最新的
class maillistTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedMails = loadMails() {
            mailList += savedMails
        } else {
            initMailList()
        }
        
        tableView.rowHeight = 133
//        initMailList()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem = editButtonItem
        
        
    }
    
    var mailList: [mail] = [mail]()
    
    func initMailList() {
        mailList.append(mail(inputName: "lht", inputMail: "1301369833@qq.com", inputPhoto: nil))
        mailList.append(mail(inputName: "dglhtao", inputMail: "dglhtao@163.com", inputPhoto: nil))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //分区的数量
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mailList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myListCell", for: indexPath) as! maillistTableCellController

        // Configure the cell...
        //cell.textLabel?.text = String(indexPath.row)

        cell.mainTitle?.text = mailList[indexPath.row].name
        cell.subTitle?.text = mailList[indexPath.row].mail
        cell.avatar?.image = mailList[indexPath.row].photo
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            mailList.remove(at: indexPath.row)
            saveMails()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    //从Detail页的cancel返回到maillist页，需要在终点segue写上以下代码
    //然后cancel拉到detail页的dock的exit图标，然后unwind segue cancel to "cancelExitEntry" 的identifier改成详细页对应的swift文件中的名称
    @IBAction func cancelExitEntry ( _ segue: UIStoryboardSegue) {
        print("cancel")
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
        let descriptionVC = segue.destination as! mailDescViewController
        if let selectedCell = sender as? UITableViewCell {
            let indexPath = tableView.indexPath(for: selectedCell)!
            let selectedMail = mailList[(indexPath as NSIndexPath).row]
            descriptionVC.mailForEdit = selectedMail
        }
        }
    }
    
    
    
    // 接受从另外一个页面传过来的数据并作reload
    @IBAction func saveToList(_ segue: UIStoryboardSegue) {
        
        if let saveVC = segue.source as? mailDescViewController {
            if let mailEditResult = saveVC.mailForEdit{
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    //Update an existing mail.
                    
                    mailList[(selectedIndexPath as NSIndexPath).row] = mailEditResult
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                    
                }
                    //行1和行2不能对调！！！！！
                else {
                    mailList.append(mailEditResult)         //行1
                    let newIndexPath = IndexPath(row: mailList.count-1, section: 0)     //行2
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
        saveMails()
    }
    /*
    TableView is divided into sections. Each section contains some number of rows. IndexPath contains information about which row in which section the function is asking about.
    */
 
    private func saveMails() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(mailList, toFile: mail.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("MailList successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save mail...", log: OSLog.default, type: .error)
        }
    }

    private func loadMails() -> [mail]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: mail.ArchiveURL.path) as? [mail]
    }
    
}
