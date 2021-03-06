//
//  SidraImageGallery.m
//  Pulse
//
//  Created by xibic on 6/25/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "SidraImageGallery.h"
#import "MediaItem.h"

#define ALBUM_SIZE CGSizeMake(99,99)
#define PADDING 3

@interface SidraImageGallery()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate>{
    UIScrollView *itemScrollView;
   
    
    int posX,posY;
    
    int numberOfCols,lastCol;
       BOOL isPulling;
    
}

@end

@implementation SidraImageGallery

@synthesize delegate,mediaItemArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)showGalleryImages:(NSArray *)photosArray{
    
    mediaItemArray = [NSMutableArray arrayWithArray:photosArray];
    
    [itemScrollView removeFromSuperview];
    itemScrollView = nil;
    
    itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    itemScrollView.backgroundColor = [UIColor clearColor];
    itemScrollView.showsHorizontalScrollIndicator = NO;
    itemScrollView.showsVerticalScrollIndicator = NO;
    itemScrollView.pagingEnabled = NO;
    itemScrollView.delegate = self;
    itemScrollView.bounces = YES;
    itemScrollView.userInteractionEnabled = YES;
    
    numberOfCols = 3;
    
    int index=0;
    posY = 0;
    for (int i=0; index <[mediaItemArray count]; i++) {
        posX = 5;
        for (int j=0; j<numberOfCols && index <[mediaItemArray count]; j++) {
            
            MediaItem *item = (MediaItem*)[mediaItemArray objectAtIndex:index];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(posX, posY, ALBUM_SIZE.width, ALBUM_SIZE.height)];
            posX += ALBUM_SIZE.width+5;
            
            view.tag = index;
            view.userInteractionEnabled = YES;
            view.backgroundColor = [UIColor clearColor];
            view.layer.cornerRadius = 4.0f;
    
            if (item.mediaType==1) {
                
                AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(2, 2, ALBUM_SIZE.width-4, ALBUM_SIZE.height-4)];
                imageView.showActivityIndicator = YES;
                imageView.layer.cornerRadius = 2.5;
                imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
                //imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.image = [UIImage imageNamed:@"PlaceHolderImg.png"];
                imageView.imageURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",SERVER_BASE_IMAGE_URL,item.media] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                [view addSubview:imageView];
                imageView.userInteractionEnabled = YES;
                
                UIImageView *imageShadeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ALBUM_SIZE.width, ALBUM_SIZE.height)];
                imageShadeView.image = [UIImage imageNamed:@"w_b.png"];
                [imageShadeView setContentMode:UIViewContentModeRedraw];
                [view addSubview:imageShadeView];
                
            }else{
                view.backgroundColor = [UIColor blackColor];
                
//                NSRange titleResultsRange = [item.media rangeOfString:@"youtube" options:NSCaseInsensitiveSearch];
//                if (titleResultsRange.length > 0){
//                    
//                    UIWebView *videWebView = [[UIWebView alloc] initWithFrame:CGRectMake(1, 1, ALBUM_SIZE.width-1, ALBUM_SIZE.height-1)];
//                    videWebView.backgroundColor = [UIColor clearColor];
//                    videWebView.scrollView.scrollEnabled = NO;
//                    videWebView.scrollView.bounces = NO;
//                    videWebView.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
//                    NSString *urlString = item.media;//@"https://www.youtube.com/watch?v=N-SElhktQF0";
//                    NSString* videoId = nil;
//                    NSURL *url = [NSURL URLWithString:urlString];
//                    NSArray *queryComponents = [url.query componentsSeparatedByString:@"&"];
//                    for (NSString* pair in queryComponents) {
//                        NSArray* pairComponents = [pair componentsSeparatedByString:@"="];
//                        if ([pairComponents[0] isEqualToString:@"v"]) {
//                            videoId = pairComponents[1];
//                            break;
//                        }
//                    }
//                    
//                    //XLog(@"Embed video id: %@", videoId);
//                    
//                    NSString *htmlString = @"<html><head>\
//                    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 99\"/></head>\
//                    <body style=\"background:#000;margin-top:0%;margin-left:0%; background-color: transparent;\">\
//                    <iframe id=\"ytplayer\" type=\"text/html\" width=\"98\" height=\"98\"\
//                    src=\"http://www.youtube.com/embed/%@?autoplay=1\"\
//                    frameborder=\"0\"/>\
//                    </body></html>";
//                    
//                    htmlString = [NSString stringWithFormat:htmlString, videoId, videoId];
//                    [videWebView loadHTMLString:htmlString baseURL:nil];
//                    
//                    [view addSubview:videWebView];
//                }else{
                    UIImageView *videoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlayControl.png"]];
                    videoView.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
                    videoView.layer.cornerRadius = 2.5;
                    videoView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
                    videoView.userInteractionEnabled = YES;
                    [view addSubview:videoView];
//                }
                
                
                
                UIImageView *videoShadeView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -1, ALBUM_SIZE.width+2, ALBUM_SIZE.height+2)];
                videoShadeView.image = [UIImage imageNamed:@"w_b.png"];
                [videoShadeView setContentMode:UIViewContentModeRedraw];
                [view addSubview:videoShadeView];
                
            }
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
            [singleTap setNumberOfTapsRequired:1];
            [view addGestureRecognizer:singleTap];
            
            [itemScrollView addSubview:view];
            
            index++;
            lastCol = j;
        }
        
        posY += ALBUM_SIZE.height + PADDING *2;
        
        itemScrollView.contentSize = CGSizeMake(itemScrollView.contentSize.width, posY + PADDING + ALBUM_SIZE.height);
         NSLog(@"Content Size %@",itemScrollView);
    }
    
    if(itemScrollView.contentSize.height<self.frame.size.height)
        itemScrollView.frame=CGRectMake(0, 0, self.frame.size.width, itemScrollView.contentSize.height-5);
    
    [self addSubview:itemScrollView];
    
}
- (void)addGalleryImages:(NSArray *)photosArray{
    
    
    int index=[mediaItemArray count];
    [mediaItemArray addObjectsFromArray:photosArray];
  
    
    //XLog(@"1 # POSY %d",posY);
    if(lastCol!=2) posY -= ALBUM_SIZE.height + PADDING *2;
    //XLog(@"2 # POSY %d",posY);
    
    for (int i=index; index <[mediaItemArray count]; i++) {

        lastCol +=1;
        lastCol%=3;
        
        posX = (lastCol==0?5:posX);
        
        for (int j=lastCol; j<numberOfCols && index <[mediaItemArray count]; j++) {
            
            MediaItem *item = (MediaItem*)[mediaItemArray objectAtIndex:index];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(posX, posY, ALBUM_SIZE.width, ALBUM_SIZE.height)];
            posX += ALBUM_SIZE.width+5;
            
            view.tag = index;
            view.userInteractionEnabled = YES;
            view.backgroundColor = [UIColor clearColor];
            view.layer.cornerRadius = 4.0f;
            
            if (item.mediaType==1) {
                
                AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(2, 2, ALBUM_SIZE.width-4, ALBUM_SIZE.height-4)];
                imageView.showActivityIndicator = YES;
                imageView.layer.cornerRadius = 2.5;
                imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
                imageView.image = [UIImage imageNamed:@"PlaceHolderImg.png"];
                imageView.imageURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",SERVER_BASE_IMAGE_URL,item.media] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                [view addSubview:imageView];
                imageView.userInteractionEnabled = YES;
                
                UIImageView *imageShadeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ALBUM_SIZE.width, ALBUM_SIZE.height)];
                imageShadeView.image = [UIImage imageNamed:@"w_b.png"];
                [imageShadeView setContentMode:UIViewContentModeRedraw];
                [view addSubview:imageShadeView];
                
            }else{
                view.backgroundColor = [UIColor blackColor];
                UIImageView *videoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlayControl.png"]];
                videoView.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
                videoView.layer.cornerRadius = 2.5;
                videoView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
                
                [view addSubview:videoView];
                videoView.userInteractionEnabled = YES;
                
                UIImageView *videoShadeView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -1, ALBUM_SIZE.width+2, ALBUM_SIZE.height+2)];
                videoShadeView.image = [UIImage imageNamed:@"w_b.png"];
                [videoShadeView setContentMode:UIViewContentModeRedraw];
                [view addSubview:videoShadeView];
                
            }
            
            /*
            
            UILabel *numberOfPhotosVideosLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, view.frame.size.height - 25.0f, view.frame.size.width -5, 10.0f)];
            numberOfPhotosVideosLabel.font = [UIFont systemFontOfSize:13.0f];
            numberOfPhotosVideosLabel.textColor = [UIColor redColor];
            numberOfPhotosVideosLabel.textAlignment = NSTextAlignmentLeft;
            numberOfPhotosVideosLabel.text = [NSString stringWithFormat:@"%d",view.tag];
            [view addSubview:numberOfPhotosVideosLabel];
            
            */
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
            [singleTap setNumberOfTapsRequired:1];
            [view addGestureRecognizer:singleTap];
            
            [itemScrollView addSubview:view];
            
            index++;

            lastCol = j;
        }
        
        posY += ALBUM_SIZE.height + PADDING *2;
        
        itemScrollView.contentSize = CGSizeMake(itemScrollView.contentSize.width, posY + PADDING + ALBUM_SIZE.height);
        
 
        
    }
    
    if(itemScrollView.contentSize.height<self.frame.size.height)
        itemScrollView.frame=CGRectMake(0, 0, self.frame.size.width, itemScrollView.contentSize.height-5);
    
}

// Infront of it

- (void)addGalleryImages_Infront:(NSArray *)photosArray{
    
    
    //int index=[mediaItemArray count];
    
    NSMutableArray *newItem=[[NSMutableArray alloc]init];
    
    
    for(int i=0;i<photosArray.count;i++){
        [newItem addObject:[photosArray objectAtIndex:i]];
    
    }

    [newItem addObjectsFromArray:mediaItemArray];
    mediaItemArray =newItem;
    
    [self showGalleryImages:[mediaItemArray mutableCopy]];
    // [mediaItemArray addObjectsFromArray:photosArray];

    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (endScrolling >= scrollView.contentSize.height){
        
    }
    if (endScrolling == scrollView.frame.size.height){
        //XLog(@"Scroll UP Called");
    }
}
*/


/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
    
    //XLog(@"SCROLLING: %f  ----- %f",endScrolling, scrollView.contentSize.height);
    if (endScrolling >= scrollView.contentSize.height-SCREEN_SIZE.height*2){
        [self.delegate loadNextSetOfImages];
    }
    if (endScrolling <= scrollView.frame.size.height){
        //XLog(@"Scroll UP Called");
        [self.delegate loadNewSetOfImages];
    }
}
*/

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    float  endScrolling2=0.0;;
    if(scrollView.contentSize.height>=scrollView.frame.size.height){
        endScrolling2  = scrollView.frame.size.height+scrollView.contentOffset.y+1 ;
    }
    
    
    if(isPulling){
        
        if(scrollView.contentOffset.y<=0){
            
         [self.delegate loadNewSetOfImages];
            
        }
        
        else{
            
            
            
            
            if(endScrolling2>=scrollView.contentSize.height && endScrolling2>=scrollView.frame.size.height){
               [self.delegate loadNextSetOfImages];
                
            }
            else if(endScrolling2<1 &&endScrolling2>-1){
                [self.delegate dismisssView];
            }
            
            else{
                XLog(@"\n NOT SCROLLING:");
                [self.delegate dismisssView];
                
            }
            
            
            
        }
        
        
        isPulling = false;
    }
    else{
        
        
        
    }
    

}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

//float endScrolling = scrollView.contentOffset.y + scrollView.contentSize.height;

float  endScrolling2=0.0;;

if(scrollView.contentSize.height>=scrollView.frame.size.height){
    endScrolling2  = scrollView.frame.size.height+scrollView.contentOffset.y+1 ;
}

if(scrollView.contentOffset.y<=0){
    
    [self.delegate imageLoadingPullDownView];
    isPulling = true;
    //pullToRefresh = 0;
    
}
else
{
    
    
    if(endScrolling2>=scrollView.contentSize.height && endScrolling2>=scrollView.frame.size.height){
        [self.delegate imageLoadingPullUpView];
        XLog(@"\nSCROLLING:");
        isPulling = true;
        //pullToRefresh = 1;
        
    }
    
    else{
        XLog(@"\n NOT SCROLLING:");
        isPulling = false;
        //pullToRefresh = 0;
    }
}
}






- (UIImage *)thumbnailFromVideoAtURL:(NSURL *)contentURL {
    UIImage *theImage = nil;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:contentURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generator copyCGImageAtTime:time actualTime:NULL error:&err];
    
    theImage = [[UIImage alloc] initWithCGImage:imgRef];
    
    CGImageRelease(imgRef);
    
    return theImage;
}


#pragma mark Gesture Handling methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    UIView *view = (UIView*)[gestureRecognizer view];
    //[self.xibImageDelegate imageClicked:imageName];
    [self.delegate clickedItem:view.tag];
}

#pragma mark - GestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (BOOL)shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}



@end
