//
//  ViewController.swift
//  ios11
//
//  Created by EndoTakashi on 2016/04/26.
//  Copyright © 2016年 tak. All rights reserved.
//

import UIKit

class ViewController: UIViewController,

UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var Clear: UIButton!
    @IBOutlet weak var AllClear: UIButton!
    @IBOutlet weak var CalcuLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var Rlabel: UILabel!
    @IBOutlet weak var Llabel: UILabel!
    @IBOutlet weak var enzanLabel: UILabel!
    
    var Calcu:Double = 0
    var preCalcu:String = "0"
    var nextCalcu:String = "0"
    var calcuFlag = true
    var calcuCategory = 0
    var enzan:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    @IBAction func ClearEvent(sender: UIButton){
        if sender.titleLabel!.text! == "AC" {
            CalcuLabel.text = "0"
            Calcu = 0
            preCalcu = "0"
            nextCalcu = "0"
            calcuFlag = true
            enzan  = ""
        }else if sender.titleLabel!.text! == "C"{
            CalcuLabel.text = "0"
            nextCalcu = "0"
            enzan  = ""
        }
    }
    
    @IBAction func calculate(sender: UIButton){
        print ( sender.titleLabel!.text! )
        if  sender.titleLabel!.text! == "+" ||
            sender.titleLabel!.text! == "-" ||
            sender.titleLabel!.text! == "×" ||
            sender.titleLabel!.text! == "÷" ||
            sender.titleLabel!.text! == "=" {
            print (enzan)
            switch enzan {
            case "+":
                Calcu = Calcu + Double(nextCalcu)!
                enzan = sender.titleLabel!.text!
                print ("+")
                break
            case "-":
                Calcu = Calcu - Double(nextCalcu)!
                enzan = sender.titleLabel!.text!
                print ("-")
                break
                
            case "×":
                Calcu = Calcu * Double(nextCalcu)!
                enzan = sender.titleLabel!.text!
                print ("*")
                break
                
            case "÷":
                Calcu = Calcu / Double(nextCalcu)!
                enzan = sender.titleLabel!.text!
                print ("/")
                break
            case "=":
                Calcu = Calcu / Double(nextCalcu)!
                enzan = ""
                print ("/")
                break
            default:
                Calcu = Double(preCalcu)!
                calcuFlag = false
                enzan = sender.titleLabel!.text!
                break
            }
            let shosu: [String] = String(Calcu).componentsSeparatedByString(".")
            print ( shosu)
            if shosu[1] == "0"{
                CalcuLabel.text = String((Calcu.description as NSString).integerValue)
            }else{
                CalcuLabel.text = String(Calcu)
            }
            nextCalcu = "0"
            
         }else{
            if calcuFlag{
                if (preCalcu == "0" || preCalcu == "00") && sender.titleLabel!.text! != "." {
                    preCalcu = ""
                }
                preCalcu = preCalcu + sender.titleLabel!.text!
                CalcuLabel.text = preCalcu
            }else{
                if (nextCalcu == "0" || nextCalcu == "00") && sender.titleLabel!.text! != "." {
                    nextCalcu = ""
                }
                nextCalcu = nextCalcu + sender.titleLabel!.text!
                CalcuLabel.text = nextCalcu
            }
        }

    }
    @IBAction func picSelect(sender: AnyObject){
        if sender.tag == 101{
            PicSelect(UIImagePickerControllerSourceType.PhotoLibrary)
        }else if sender.tag == 100{
            imageView.image = nil
        }
        
    }
    //=========================
    //ImagePiker
    //=========================
    func PicSelect(sourceType: UIImagePickerControllerSourceType){
            //カメラとフォトアルバムの利用可能チェック(1)
            if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
                showAlert(nil, text: "利用できません")
                return
            }
            
            //イメージピッカーの生成(2)
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            
            //ビューコントローラのビューを開く
            presentViewController(picker, animated: true, completion: nil)
        }
    
    //====================
    //UIImagePickerControllerDelegate
    //====================
    //イメージピッカーのイメージ取得時に呼ばれる(3)
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        //イメージの指定
        let image = info[UIImagePickerControllerOriginalImage]
            as! UIImage
        imageView.image = image
        //        ImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        //ビューコントローラのビューを閉じる
        picker.presentingViewController?
            .dismissViewControllerAnimated(true, completion: nil)
    }
    
    //イメージピッカーのキャンセル時に呼ばれる(3)
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //ビューコントローラのビューを閉じる
        picker.presentingViewController?
            .dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showAlert(title: String?, text: String?){
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK",style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    //=========================
    //ImagePiker
    //=========================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

