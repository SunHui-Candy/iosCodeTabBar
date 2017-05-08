//
//  SHSeeBigPicViewController.m
//  SHCode
//
//  Created by ios on 17/5/4.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHSeeBigPicViewController.h"
#import <Photos/Photos.h>

@interface SHSeeBigPicViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *bgScrollV;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic, strong) UIImageView *imageV;

/** 当前App对应的自定义相册 */
- (PHAssetCollection *)createdCollection;
/** 返回刚才保存到【相机胶卷】的图片 */
- (PHFetchResult<PHAsset *> *)createdAssets;

@end

@implementation SHSeeBigPicViewController


- (IBAction)backBtn:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    // 保存图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageV.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    if (error) {
        return  nil;
    }
    // 获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}

- (PHAssetCollection *)createdCollection
{
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }

    /** 当前App对应的自定义相册没有被创建过 **/
    // 创建一个【自定义相册】

    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        return nil;
    }
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
    
    
}

/**
 *  保存图片到相册
 */
- (void)saveImageIntoAlbum
{
    //获得相片
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
        return;
    }
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败"];
        return;
    }
    
    // 添加刚才保存的图片到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    // 最后的判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }

}

- (IBAction)saveBtn:(id)sender {
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) {
            //用户拒绝当前app访问相册
            if (oldStatus != PHAuthorizationStatusNotDetermined) {
                //用户之前有操作过
                NSLog(@"提醒用户打开开关");
            }
        }else if (status == PHAuthorizationStatusAuthorized) {
            //用户允许当前app访问相册
            [self saveImageIntoAlbum];
        }else if (status == PHAuthorizationStatusRestricted) {
            //无法访问相册
            [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
        }
    }];
}

#pragma mark - <UIScrollViewDelegate>

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.bgScrollV atIndex:0];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.childModel.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            return ;
        }
        self.saveBtn.enabled  = YES;
    }];
    
    self.imageV.sh_width = self.bgScrollV.sh_width;
    self.imageV.sh_height = self.imageV.sh_width * self.childModel.height / self.childModel.width;
    self.imageV.sh_x = 0;
    if (self.imageV.sh_height > kScreenH) {
        //超过一个屏幕
        self.imageV.sh_y = 0;
        self.bgScrollV.contentSize = CGSizeMake(0, self.imageV.sh_height);
    }else {
        self.imageV.sh_centerY = self.bgScrollV.sh_height * 0.5;
    }
    
    CGFloat maxScale = self.childModel.width / self.imageV.sh_width;
    if (maxScale > 1) {
        self.bgScrollV.maximumZoomScale = maxScale;
        self.bgScrollV.delegate  =self;
    }

}
#pragma mark - Getters
- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}
- (UIScrollView *)bgScrollV
{
    if (!_bgScrollV) {
        _bgScrollV = [[UIScrollView alloc] init];
        _bgScrollV.frame =  [UIScreen mainScreen].bounds;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtn:)];
        [_bgScrollV addGestureRecognizer:tapGes];
        [_bgScrollV addSubview:self.imageV];
        
    }
    return _bgScrollV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end




















































