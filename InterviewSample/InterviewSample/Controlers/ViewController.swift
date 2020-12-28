
//
//  ViewController.swift
//  InterviewSample
//
//  Created by Deepak on 25/12/20.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var vwCurve: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgtopPixelHeight: NSLayoutConstraint!
    @IBOutlet weak var vwBackProgress: UIView!
    @IBOutlet weak var circleCoin: PlainCircularProgressBar!
    @IBOutlet weak var circleComplete: PlainCircularProgressBar!
    @IBOutlet weak var circleTimespend: PlainCircularProgressBar!
    @IBOutlet weak var lblTimeSpend: UILabel!
    @IBOutlet weak var lblEarnCoin: UILabel!
    @IBOutlet weak var lblComplete: UILabel!
    @IBOutlet weak var lblTotalChapter: UILabel!
    @IBOutlet weak var heightlbltotalChapter: NSLayoutConstraint!
    @IBOutlet weak var widthtotalChapter: NSLayoutConstraint!
    @IBOutlet weak var withUnderlinechapter: NSLayoutConstraint!
    @IBOutlet weak var toplblSubject: NSLayoutConstraint!
    @IBOutlet weak var tblChapterData: UITableView!
    @IBOutlet weak var vwtotalChapterUnderline: UIView!
    var hiddenSections = Set<Int>()
    var processcount:Float = 0.0
    var timer:Timer!
    let chapterData = [
        ["Multiply a two-digit number by a three-digit\nnumber: complete the missing steps","One Dimensional Motion","One Dimensional Motion ","One Dimensional Motion","One Dimensional Motion","One Dimensional Motion","One Dimensional Motion","One Dimensional Motion","One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],["One Dimensional Motion"],
    ]
    let maxHeaderHeight: CGFloat = 360
    let minHeaderHeight: CGFloat = 220
    var previousScrollOffset: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.tblChapterData.delegate = self
        self.tblChapterData.dataSource = self
        
        
    }
    
    
    func setUI(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        vwBackProgress.layer.cornerRadius = 20
        vwCurve.layer.cornerRadius = 30
        vwBackProgress.layoutShadowView()
        let coinColor = UIColor(red: 1, green: 0.357, blue: 0.357, alpha: 1)
        let completeColor = UIColor(red: 0.745, green: 0.424, blue: 1, alpha: 1)
        let timeColor = UIColor(red: 0.478, green: 0.753, blue: 0.122, alpha: 1)
        lblEarnCoin.textColor = coinColor
        lblComplete.textColor = completeColor
        lblTimeSpend.textColor = timeColor
        circleCoin.color = coinColor
        circleComplete.color = completeColor
        circleTimespend.color = timeColor
        lblComplete.text = "80%"
        lblEarnCoin.text = "8"
        lblTimeSpend.text = "8:00"
        let currentImage = #imageLiteral(resourceName: "Maths")
        let imageRatio = currentImage.getImageRatio()
        let height =  self.view.frame.width / imageRatio
        imgtopPixelHeight.constant = height
      }
    @objc func runTimedCode(){
        processcount = processcount + 0.1
        circleCoin.progress = CGFloat(processcount)
        circleComplete.progress = CGFloat(processcount)
        circleTimespend.progress = CGFloat(processcount)
        if processcount > 0.7 {
            timer.invalidate()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.chapterData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if !self.hiddenSections.contains(section) {
                return 0
            }
            
            return self.chapterData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ChapterCell!
        let cellIdentifier = "ChapterCell"
        cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ChapterCell?
        if cell == nil {
         cell = ChapterCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
        }
        cell.lblTopic.text = "Topic \(indexPath.row + 1)"
        cell.lblTitle?.text = self.chapterData[indexPath.section][indexPath.row]
        cell.vwcircle.addSubview(fillCircle(fill: 25*indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vwSection = UIView.init(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 74))
        let vwLine = UIView.init(frame: CGRect(x:23, y:48, width:4, height: 26))
        vwLine.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        vwSection.addSubview(vwLine)
       
        let vwParent = UIView.init(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 50))
        vwSection.addSubview(vwParent)
        vwParent.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        vwParent.layer.cornerRadius = 25
        let img = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        img.layer.cornerRadius = img.frame.size.width/2
        img.image = #imageLiteral(resourceName: "surface")
        if section == 0 {
        let imgRightDown = UIImageView.init(frame: CGRect(x: tableView.frame.size.width - 37, y: 22, width: 11, height: 6))
            imgRightDown.image = #imageLiteral(resourceName: "downA")
            vwParent.addSubview(imgRightDown)
        }
        else{
            let imgLock = UIImageView.init(frame: CGRect(x: tableView.frame.size.width - 34, y: 16, width: 18, height: 18))
            imgLock.image = #imageLiteral(resourceName: "lock")
            vwParent.addSubview(imgLock)
        }
        let lblChapter = UILabel.init(frame: CGRect(x:61, y:10, width:tableView.frame.size.width - 40, height: 12))
        lblChapter.font = UIFont(name: "gothamrounded-medium", size: 10)
        let lblTitle = UILabel.init(frame: CGRect(x:61, y:25, width:tableView.frame.size.width - 40, height: 14))
        lblTitle.font = UIFont(name: "gothamRounded-book", size: 12)
        let maintxt = "Chapter \(section + 1) - 09 Topic"
        lblChapter.attributedText = setColoredLabel(fullstring: maintxt, rang1txt: "Chapter \(section + 1)", rang2txt: "- 09 Topic")
        lblTitle.text = "Punctuation, capitalisation and..."
        let sectionButton = UIButton.init(frame: CGRect(x:0, y:0, width: tableView.frame.size.width, height: 74))
        sectionButton.backgroundColor = .clear
        sectionButton.tag = section
        sectionButton.addTarget(self,
                                action: #selector(self.hideSection(sender:)),
                                for: .touchUpInside)
        vwParent.addSubview(img)
        vwParent.addSubview(lblChapter)
        vwParent.addSubview(lblTitle)
        vwParent.addSubview(sectionButton)
        return vwSection
    }
    
   
    @objc private func hideSection(sender: UIButton) {
        let section = sender.tag
        func indexPathsForSection() -> [IndexPath] {
         var indexPaths = [IndexPath]()
         for row in 0..<self.chapterData[section].count {
          indexPaths.append(IndexPath(row: row,section: section))
                                            
        }
         return indexPaths
        }
        
        if !self.hiddenSections.contains(section) {
            self.hiddenSections.insert(section)
            self.tblChapterData.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            self.hiddenSections.remove(section)
            self.tblChapterData.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
    
    func setColoredLabel(fullstring:String,rang1txt:String,rang2txt:String)->NSMutableAttributedString{
        let range = (fullstring as NSString).range(of: rang1txt)
        let range1 = (fullstring as NSString).range(of: rang2txt)
        let attribute = NSMutableAttributedString.init(string: fullstring)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.388, green: 0.439, blue: 0.984, alpha: 1) , range: range)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) , range: range1)
         return attribute
    }
    
    func fillCircle(fill:Int) -> UIView{
        let roundView = UIView(frame:CGRect(x: 0, y: 0, width: 26, height: 26))
        roundView.backgroundColor = UIColor.white
        roundView.layer.cornerRadius = roundView.frame.size.width / 2
        // vary this to move the start of the arc
        let startAngle = -CGFloat.pi / 2    // This corresponds to 12 0'clock
        // vary this to vary the size of the segment, in per cent
        let proportion = CGFloat(fill)
        let centre = CGPoint (x: roundView.frame.size.width / 2, y: roundView.frame.size.height / 2)
        let radius = roundView.frame.size.width / 2
        let arc = CGFloat.pi * 2 * proportion / 100 // i.e. the proportion of a full circle

        // Start a mutable path
        let cPath = UIBezierPath()
        // Move to the centre
        cPath.move(to: centre)
        // Draw a line to the circumference
        cPath.addLine(to: CGPoint(x: centre.x + radius * cos(startAngle), y: centre.y + radius * sin(startAngle)))
        // NOW draw the arc
        cPath.addArc(withCenter: centre, radius: radius, startAngle: startAngle, endAngle: arc + startAngle, clockwise: true)
        // Line back to the centre, where we started (or the stroke doesn't work, though the fill does)
        cPath.addLine(to: CGPoint(x: centre.x, y: centre.y))
        // n.b. as @MartinR points out `cPath.close()` does the same!

        // circle shape
        let circleShape = CAShapeLayer()
        circleShape.path = cPath.cgPath
        circleShape.strokeColor = UIColor.clear.cgColor
        circleShape.fillColor = UIColor(red: 0.455, green: 0.706, blue: 1, alpha: 1).cgColor
        circleShape.lineWidth = 1.5
        // add sublayer
        roundView.layer.addSublayer(circleShape)
        roundView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        return roundView
    }
    
    
}

extension ViewController {
    func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerViewHeight.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    func setScrollPosition() {
        self.tblChapterData.contentOffset = CGPoint(x:0, y: 0)
    }
    
    
}
extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = headerViewHeight.constant
            if newHeight < 250 {
                toplblSubject.constant  = (250 - newHeight)/3
            }
            if newHeight > 250 {
                toplblSubject.constant = 0
            }
            
            if isScrollingDown {
                newHeight = max(minHeaderHeight, headerViewHeight.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeaderHeight, headerViewHeight.constant + abs(scrollDiff))
            }
            if newHeight != headerViewHeight.constant {
                headerViewHeight.constant = newHeight
                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
                withUnderlinechapter.constant = 60 - (maxHeaderHeight - newHeight)/2
                widthtotalChapter.constant = 70 - (maxHeaderHeight - newHeight)/2
                heightlbltotalChapter.constant =  13 - (maxHeaderHeight - newHeight)/5
                
                
            }
        }
    }
}






class ChapterCell: UITableViewCell {
    
    @IBOutlet weak var vwcircle: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTopic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vwcircle.layer.cornerRadius = vwcircle.frame.width/2
        vwcircle.layer.borderWidth = 2
        vwcircle.layer.borderColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1).cgColor
    }
   
}
