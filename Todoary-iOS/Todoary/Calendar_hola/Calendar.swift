//
//  CalendarViewController.swift
//  Todoary
//
//  Created by 송채영 on 2022/07/16.
//

import UIKit

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: - UIcomponents
    func initView() {
        
        dateFormatterYear.dateFormat = "yyyy"
        dateFormatterMonth.dateFormat = "MM"
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        self.calculation()
    }

    
    func calculation() {
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        
        self.Month = Int(dateFormatterMonth.string(from: firstDayOfMonth!))!
        self.year_Month.text = dateFormatterYear.string(from: firstDayOfMonth!)+"년 "+String(self.Month)+"월"
        
        self.days.removeAll()
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 43, height: 42)
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return self.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell
        
        switch indexPath.section {
        case 0:
            cell?.dateLabel.snp.makeConstraints{ make in
                make.height.equalTo(20)
            }
            cell?.dateLabel.backgroundColor = .white
            cell?.dateLabel.text = weeks[indexPath.row]
            if indexPath.row == 0 {
                cell?.dateLabel.textColor = .sunday
            } else if indexPath.row == 6 {
                cell?.dateLabel.textColor = .saturday
            }
        default:
            cell?.dateLabel.text = days[indexPath.row]
        }
        
        return cell!
    }
    
    
}
