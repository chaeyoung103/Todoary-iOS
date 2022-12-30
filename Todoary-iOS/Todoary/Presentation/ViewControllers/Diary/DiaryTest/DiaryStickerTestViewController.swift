//
//  DiaryStickerTestViewController.swift
//  Todoary
//
//  Created by 박지윤 on 2022/12/30.
//

import UIKit
import StickerView


//struct Sticker {
//    let stickerType: Int
//    let sticker : StickerView
//    var flip : Bool
//}

extension DiaryTestViewController{
    
    func checkStickerStateAndRequestApi(){
        if create.isEmpty == false {
            for i in 0...create.count - 1 {
                
                let new = CreatedDiarySticker(stickerId: create[i].stickerType, locationX: Double(create[i].sticker.center.x), locationY: Double(create[i].sticker.center.y), width: create[i].sticker.contentView.frame.height, height: create[i].sticker.contentView.frame.height, rotation: atan2(create[i].sticker.transform.b,create[i].sticker.transform.a) , flipped: create[i].flip)
                
                createdApi.append(new)
            }
        }
        
        if modify.isEmpty == false {
            for i in 0...modify.count - 1 {
                
                let old = ModifiedDiarySticker(id:modify[i].sticker.tag ,stickerId: modify[i].stickerType, locationX: Double(modify[i].sticker.center.x), locationY: Double(modify[i].sticker.center.y), width: modify[i].sticker.contentView.frame.height, height: modify[i].sticker.contentView.frame.height, rotation: atan2(modify[i].sticker.transform.b,modify[i].sticker.transform.a) , flipped: modify[i].flip)
                
                modifiedApi.append(old)
            }
        }
        
        let diaryStickerInput = DiaryStickerInput(created: createdApi, modified: modifiedApi, deleted: delete)
        
        DiaryDataManager().diaryStickerDataManager(viewController: self, createdDate: self.pickDate!.dateSendServer, parameter: diaryStickerInput)
    }
    
    func successAPI_sticker(_ result : [DiarySticker]) {
        
        if result.isEmpty == false {
            for i in 0...result.count - 1 {
                
                let image = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: result[i].width, height: result[i].height))
                image.image = DiaryViewController.stickerData[result[i].stickerId]
                image.contentMode = .scaleAspectFit
                
                if result[i].flipped == true {
                    image.transform = image.transform.scaledBy(x: -1, y: 1)
                }
                
                let sticker = StickerView.init(contentView: image)
                sticker.center = CGPoint.init(x: result[i].locationX, y: result[i].locationY)
                sticker.transform = sticker.transform.rotated(by: result[i].rotation)
                sticker.delegate = self
                sticker.setImage(UIImage.init(named: "close")!, forHandler: StickerViewHandler.close)
                sticker.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.rotate)
                sticker.setImage(UIImage.init(named: "flip")!, forHandler: StickerViewHandler.flip)
                sticker.showEditingHandlers = false
                sticker.tag = result[i].id
                self.mainView.textView.addSubview(sticker)
                
                let stickerInfo = Sticker(stickerType: result[i].stickerId, sticker: sticker, flip: result[i].flipped)
                
                modify.append(stickerInfo)
                
            }
        }
    }
    
    //스티커뷰 선택 제스쳐
    func setupGestureRecognizerOnCollection() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapSticker(gestureRecognizer:)))
        tapGesture.delegate = self
        DiarySticker.collectionView?.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapSticker(gestureRecognizer: UIGestureRecognizer) {

        let p = gestureRecognizer.location(in: DiarySticker.collectionView)
        
        if let indexPath = DiarySticker.collectionView?.indexPathForItem(at: p) {
            
            tag += 1
            
            let testImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
            testImage.image = DiaryViewController.stickerData[indexPath.row]
            testImage.contentMode = .scaleAspectFit
            
            let sticker = StickerView.init(contentView: testImage)
            sticker.center = CGPoint.init(x: 150, y: 150)
            sticker.delegate = self
            sticker.setImage(UIImage.init(named: "close")!, forHandler: StickerViewHandler.close)
            sticker.setImage(UIImage.init(named: "rotate")!, forHandler: StickerViewHandler.rotate)
            sticker.setImage(UIImage.init(named: "flip")!, forHandler: StickerViewHandler.flip)
            sticker.showEditingHandlers = false
            sticker.tag = tag
            self.mainView.textView.addSubview(sticker)
            self.selectedStickerView = sticker
            
            let stickerInfo = Sticker(stickerType: indexPath.row, sticker: sticker, flip: false)
            
            create.append(stickerInfo)
        }
    }
}

extension DiaryTestViewController: StickerViewDelegate{
    
    func stickerViewDidTap(_ stickerView: StickerView) {
        if stickerView.showEditingHandlers == false {
            self.selectedStickerView = stickerView
            stickerView.showEditingHandlers = true
        }else {
            stickerView.showEditingHandlers = false
        }
    }
    func stickerViewDidChangeMoving(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndMoving(_ stickerView: StickerView) {

    }
    
    func stickerViewDidBeginRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidChangeRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidEndRotating(_ stickerView: StickerView) {
        
    }
    
    func stickerViewDidBeginMoving(_ stickerView: StickerView) {
        self.selectedStickerView = stickerView
    }
    
    func stickerViewDidClose(_ stickerView: StickerView) {
        
        if create.isEmpty == false{
            for i in 0...create.count - 1 {
                if create[i].sticker.tag == stickerView.tag{
                    create.remove(at: i)
                    break
                }
            }
        }
        
        if modify.isEmpty == false {
            for i in 0...modify.count - 1 {
                if modify[i].sticker.tag == stickerView.tag{
                    modify.remove(at: i)
                    delete.append(stickerView.tag)
                    break
                }
            }
        }
    }
    
    func stickerViewDidFlip(_ stickerView: StickerView) {
        
        if create.isEmpty == false {
            for i in 0...create.count - 1 {
                if create[i].sticker.tag == stickerView.tag{
                    create[i].flip.toggle()
                    break
                }
            }
        }
        
        if modify.isEmpty == false {
            for i in 0...modify.count - 1 {
                if modify[i].sticker.tag == stickerView.tag{
                    modify[i].flip.toggle()
                    break
                }
            }
        }
    }
}
