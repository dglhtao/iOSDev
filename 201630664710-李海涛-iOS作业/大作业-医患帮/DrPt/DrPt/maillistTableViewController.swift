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
        mailList.append(mail(inputName: "健康的生活方式", inputMail: "健康的生活方式意味着要好好照顾身体。我们应该记住，健康的心灵只存在于健康的身体中。身心健康有助于保持所需的能量，从而实现人生的成功。我们所有人都必须努力实现健康的生活方式。想做到健康生活，我们应该注意饮食，免受有害物质的摄入，定期锻炼，保证充足的睡眠，只有消除疲劳，保持活力，才能保证我们的生活质量。健康的人能够充分享受生活，不受疾病的干扰。健康不仅与一个人的身体健康有关，还涉及一个人的心理稳定或内心的平静。", inputPhoto: nil))
        mailList.append(mail(inputName: "良好的生活习惯", inputMail: "一般来说，健康的饮食包括吃绿色和新鲜的蔬菜，水果，牛奶，鸡蛋，矿物质，蛋白质和人类生活方式必需的维生素。在日常生活中练习瑜伽包括定期锻炼也可以帮助您保持理想的身材，血糖和免疫水平。健康的生活习惯可以改善你的外表，心理稳定性，以及更好的活动能力，这有助于你过上无压力的生活，保持愉快的心情。我们每个人都应该把健康当做最重要的事; 为了保持身心健康，应该每天保持健康饮食和充分睡眠。快乐与提高你的智力和健康直接相关，因此快乐可以被视为健康和健康生活方式的结果。健康是一个人应该照顾的最重要的事情。领导健康的生活方式可带来快乐，成功和成就。", inputPhoto: nil))
        mailList.append(mail(inputName: "影响健康的因素", inputMail: " \n         健康不仅意味着保持身体健康，还包括健康的精神状态。我们的健康取决于几个因素，如食物，污染，睡眠习惯，新鲜空气，水，阳光和健康的精神状况。早晨散步和体育锻炼对确保我们的身心健康非常有帮助。一般来说，健康可以通过主要的三个参数来衡量：身体，心理和营养。身体健康是指一个人的外表; 营养健康意味着体内存在必需的营养素来对抗具有免疫力的疾病。心理健康意味着一个人在生活的各种环境中保持耐心，平静和镇定的能力。", inputPhoto: nil))
        mailList.append(mail(inputName: "科学的运动生活", inputMail: " 大家还应该多在户外晒太阳，吸入新鲜空气并参加健康活动。散步，跑步，骑自行车，游泳，园艺，跳绳，举重和瑜伽是帮助我们保持健康和健康生活方式的一些重要活动。精神充足的人足以面对生活的起伏，并且不会受到环境急剧变化的影响。 \n       在确保一个人健康的几个组成部分中，以下是确保身体健康和心理健康的七个关键物理组成部分：\n       1. 心血管/有氧调节 \n        2. 力量训练和肌肉发育  \n       3. 伸展运动 - 肌肉，韧带和肌腱  \n       4. 核心稳定性 - 身体和心理  \n        5. 营养和补充 - 均衡饮食  \n       6. 精神休息和放松 - 平衡的生活方式  \n       7. 睡觉 - 经常睡觉", inputPhoto: nil))
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
