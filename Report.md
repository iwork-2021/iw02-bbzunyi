# IOS开发TodoList

## 一、效果展示

功能展示如下：

![开始界面](https://raw.githubusercontent.com/iwork-2021/iw02-bbzunyi/main/pics/StartWindow.png)
![添加修改界面](https://raw.githubusercontent.com/iwork-2021/iw02-bbzunyi/main/pics/AddItemWindow.png)


结果展示：https://www.bilibili.com/video/BV1Qv411M7Hu?spm_id_from=333.999.0.0



## 二、实验中遇到的问题：

1、TableView的背景图问题

​	这个问题比较简单就解决了，原来TableView设置背景图这么简单啊，不像普通的View需要先设置frame再添加图片啥的，stack overflow yyds。

```swift
 self.tableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
```

2、普通view的背景图设置

​	swift5好多API和变量名字都改变了，所以在这一块花费了很多的时间，最后成功运行的代码如下，也感受到了tofill和aspectfill的区别

```swift
 let screenSize: CGRect = UIScreen.main.bounds
       let screenWidth = Int(screenSize.width)
       let screenHeight = Int(screenSize.height)
       let uiImage = UIImage(named: "itemViewBackground")
       let imageFrame: CGRect = CGRect(x:0, y:0, width:(screenWidth), height:Int(screenHeight))
       // Create a UIView object which use above CGRect object.
       let imageView = UIImageView(frame: imageFrame)
       // Create a UIColor object which use above UIImage object.
       // Set above image as UIView's background.
       imageView.image = uiImage
       imageView.contentMode = UIView.ContentMode.scaleToFill
       // Add above UIView object as the main view's subview.
       self.view.addSubview(imageView)
       self.view.sendSubviewToBack(imageView)
```



3、UIColor的初始化问题

​	之前不知道Alpha是透明度，还在那到处搜怎么弄透明色，结果只有UIColor.Clear,最后也是找了半天将Alpha设置成了0.5，实现了想要的颜色

```swift
 let bgColor = UIColor(red: 0.12, green: 0.39, blue: 0.806, alpha: 0.3)
```



4、protocol问题

​	居然能在ItemViewController里定义一个protocol，然后在主要的tableView界面去实现，学到了。

## 三、感想与体会

​	这次主要是跟着曹老师的流程一点一点走的，在这过程中也学会了很多，定义一个Cell，给他结构，然后在tableView中创立一个数组用于建立那么多个Cell。印象比较深的是存储数据的那一部分，里面也有一些东西不太理解，但是大体懂了，会在之后的学习中加深对这个的印象，还有就是as和as！，as！是基类向派生类转型。在完成了这次实验后，学会调整一个label，bar butto或者其他东西的属性，也学会了添加背景图，在之后的实验中也会继续深化学习。