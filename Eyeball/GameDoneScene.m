//
//  GameDoneScene.m
//  Eyeball
//
//  Created by Craig Milby on 3/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "GameDoneScene.h"

#import <GameKit/GameKit.h>

#import "GameData.h"
#import "GameScene.h"
#import "MainMenuScene.h"

@implementation GameDoneScene {
	CGRect m_back;
	CGRect m_playAgain;
	
	CGFloat m_bannerHeight;
	
	GameViewController *m_gvController;
}

- ( id ) initWithSize: ( CGSize ) size withTime: ( NSString* ) time withTotalError: ( CGFloat ) totalError withErrors: ( NSMutableArray<NSNumber*>* ) errors bannerHeight: ( CGFloat ) bannerHeight withGameView: ( GameViewController* ) viewController {
	if ( self = [ super initWithSize: size ] ) {
		[ self setBackgroundColor: [ SKColor blackColor ] ];
		
		// We will get and set GameData here
		GameData *data = [ GameData sharedGameData ];
		data.parallelogramClosest = MIN( [ [ errors objectAtIndex: 0 ] floatValue ], data.parallelogramClosest );
		data.parallelogramTotalError += [ [ errors objectAtIndex: 0 ] floatValue ];
		
		data.midpointCloseset = MIN( [ [ errors objectAtIndex: 1 ] floatValue ], data.midpointCloseset );
		data.midpointTotalError += [ [ errors objectAtIndex: 1 ] floatValue ];
		
		data.bisectCloseset = MIN( [ [ errors objectAtIndex: 2 ] floatValue ], data.bisectCloseset );
		data.bisectTotalError += [ [ errors objectAtIndex: 2 ] floatValue ];
		
		data.triangleCloseset = MIN( [ [ errors objectAtIndex: 3 ] floatValue ], data.triangleCloseset );
		data.triangleTotalError += [ [ errors objectAtIndex: 3 ] floatValue ];
		
		data.circleClosest = MIN( [ [ errors objectAtIndex: 4 ] floatValue ], data.circleClosest );
		data.circleTotalError += [ [ errors objectAtIndex: 4 ] floatValue ];
		
		data.rightCloseset = MIN( [ [ errors objectAtIndex: 5 ] floatValue ], data.rightCloseset );
		data.rightTotalError += [ [ errors objectAtIndex: 5 ] floatValue ];
		
		data.convergenceCloseset = MIN( [ [ errors objectAtIndex: 6 ] floatValue ], data.convergenceCloseset );
		data.convergenceTotalError += [ [ errors objectAtIndex: 6 ] floatValue ];
		
		// Time fastest should only change if you
		// get a lower average error
		// It's fastest time with the lowest errror K?
		if ( data.avgErrorBest > ( totalError / 7.0f ) ) {
			data.avgErrorBest = totalError / 7.0f;
			data.timeFastest = [ time floatValue ];
			
			if ( [ viewController gameCenterEnabled ] ) {
				[ self reportScore: data.avgErrorBest scoreboard: ScoreLeaderboardID ];
				// [ self reportScore: [ time floatValue ] scoreboard: FastestLeaderboardID ];
				
				// [ self reportScore: data.avgErrorBest scoreboard: CombinedLeaderboardID ];
				// [ self reportScore: [ time floatValue ] scoreboard: CombinedLeaderboardID ];
			}
		}
		
		data.avgErrorWorst = MAX( totalError / 7.0f, data.avgErrorWorst );
		data.avgErrorTotal += ( totalError / 7.0f );
		
		data.totalErrorBest = MIN( totalError, data.totalErrorBest );
		data.totalErrorWorst = MAX( totalError, data.totalErrorWorst );
		data.totalErrorTotal += totalError;
		
		data.timeSlowest = MAX( [ time floatValue ], data.timeSlowest );
		data.timeTotal += [ time floatValue ];
		
		data.gamesPlayed++;
		
		[ data save ];
		
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		SKNode *gameTitle = [ self getWrappingTextNode: @"Just About There" width: width * 0.8 height: 800 ];
		// SKLabelNode *gameTitle = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		// gameTitle.color = [ SKColor whiteColor ];
		// gameTitle.fontSize = 50.0f;
		// gameTitle.text = @"Just About There";
		gameTitle.position = CGPointMake( width / 2, height / 4 * 3 );
		[ self addChild: gameTitle ];
		
		SKLabelNode *currentLabel = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		currentLabel.text = @"Current";
		currentLabel.fontSize = height * FONT_SIZE;
		currentLabel.fontColor = [ SKColor whiteColor ];
		currentLabel.position = CGPointMake( width / 4 * 2.5, height / 10 * 6.5 );
		[ self addChild: currentLabel ];
		
		SKLabelNode *bestLabel = [ currentLabel copy ];
		bestLabel.text = @"Best";
		bestLabel.position = CGPointMake( width / 4 * 3.5, bestLabel.position.y );
		[ self addChild: bestLabel ];
		
		CGFloat diff = ( FONT_SIZE * height ) * 1.25f;
		
		SKLabelNode *parallel = [ currentLabel copy ];
		parallel.text = @"Parallelogram:";
		parallel.position = CGPointMake( parallel.frame.size.width + 20.0f, parallel.position.y - diff );
		parallel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
		[ self addChild: parallel ];
		
		SKLabelNode *midpoint = [ parallel copy ];
		midpoint.text = @"Line Midpoint:";
		midpoint.position = CGPointMake( midpoint.position.x, midpoint.position.y - diff );
		[ self addChild: midpoint ];
		
		SKLabelNode *bisect = [ midpoint copy ];
		bisect.text = @"Bisect Angle:";
		bisect.position = CGPointMake( bisect.position.x, bisect.position.y - diff );
		[ self addChild: bisect ];
		
		SKLabelNode *triangle = [ bisect copy ];
		triangle.text = @"Triangle Center:";
		triangle.position = CGPointMake( triangle.position.x, triangle.position.y - diff );
		[ self addChild: triangle ];
		
		SKLabelNode *circle = [ triangle copy ];
		circle.text = @"Circle Center:";
		circle.position = CGPointMake( circle.position.x, circle.position.y - diff );
		[ self addChild: circle ];
		
		SKLabelNode *right = [ circle copy ];
		right.text = @"Right Angle:";
		right.position = CGPointMake( right.position.x, right.position.y - diff );
		[ self addChild: right ];
		
		SKLabelNode *convergence = [ right copy ];
		convergence.text = @"Convergence:";
		convergence.position = CGPointMake( convergence.position.x, convergence.position.y - diff );
		[ self addChild: convergence ];
		
		SKLabelNode *average = [ convergence copy ];
		average.text = @"Average Error:";
		average.position = CGPointMake( average.position.x, average.position.y - diff * 2 );
		[ self addChild: average ];
		
		SKLabelNode *totalLbl = [ average copy ];
		totalLbl.text = @"Total Error:";
		totalLbl.position = CGPointMake( totalLbl.position.x, totalLbl.position.y - diff );
		[ self addChild: totalLbl ];
		
		SKLabelNode *timeLbl = [ totalLbl copy ];
		timeLbl.text = @"Time:";
		timeLbl.position = CGPointMake( timeLbl.position.x, timeLbl.position.y - diff );
		[ self addChild: timeLbl ];
		
		m_back = CGRectMake( 10.0f, 10.0f, width / 2 - 20, height / 10 );
		SKShapeNode *backButton = [ SKShapeNode shapeNodeWithRect: m_back ];
		backButton.lineWidth = 2.0f;
		backButton.strokeColor = [ SKColor whiteColor ];
		[ self addChild: backButton ];
		
		m_playAgain = CGRectMake( width / 2 + 10, 10.0f, width / 2 - 20, height / 10 );
		SKShapeNode *playAgainBut = [ SKShapeNode shapeNodeWithRect: m_playAgain ];
		playAgainBut.lineWidth = 2.0f;
		playAgainBut.strokeColor = [ SKColor whiteColor ];
		[ self addChild: playAgainBut ];
		
		SKLabelNode *backLbl = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		backLbl.text = @"Back";
		backLbl.fontSize = height * FONT_SIZE;
		backLbl.fontColor = [ SKColor whiteColor ];
		backLbl.position = CGPointMake( CGRectGetMidX( m_back ), CGRectGetMidY( m_back ) - ( height * FONT_SIZE / 3 ) );
		[ self addChild: backLbl ];
		
		SKLabelNode *againLbl = [ backLbl copy ];
		againLbl.text = @"Play Again";
		againLbl.position = CGPointMake( CGRectGetMidX( m_playAgain ), againLbl.position.y );
		[ self addChild: againLbl ];
		
		int curr = 0;
		for ( NSNumber *number in errors ) {
			CGFloat num = [ number floatValue ];
			SKLabelNode *numLbl = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
			numLbl.text = [ NSString stringWithFormat: @"%.02f", num ];
			numLbl.fontColor = [ SKColor whiteColor ];
			numLbl.fontSize = height * FONT_SIZE;
			numLbl.position = CGPointMake( currentLabel.position.x, parallel.position.y - ( curr * diff ) );
			[ self addChild: numLbl ];
			curr++;
		}
		
		SKLabelNode *avgErrorLBl = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		avgErrorLBl.fontColor = [ SKColor whiteColor ];
		avgErrorLBl.fontSize = height * FONT_SIZE;
		avgErrorLBl.text = [ NSString stringWithFormat: @"%.02f", totalError / [ errors count ] ];
		avgErrorLBl.position = CGPointMake( currentLabel.position.x, average.position.y );
		[ self addChild: avgErrorLBl ];
		
		SKLabelNode *totalErrorLbl = [ avgErrorLBl copy ];
		totalErrorLbl.text = [ NSString stringWithFormat: @"%.02f", totalError ];
		totalErrorLbl.position = CGPointMake( totalErrorLbl.position.x, totalLbl.position.y );
		[ self addChild: totalErrorLbl ];
		
		SKLabelNode *totalTimeLbl = [ avgErrorLBl copy ];
		totalTimeLbl.text = time;
		totalTimeLbl.position = CGPointMake( totalErrorLbl.position.x, timeLbl.position.y );
		[ self addChild: totalTimeLbl ];
		
		// Now we need to add all the best scores!!!
		
		SKLabelNode *parallelBest = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		parallelBest.fontSize = height * FONT_SIZE;
		parallelBest.fontColor = [ SKColor whiteColor ];
		parallelBest.text = [ NSString stringWithFormat: @"%.02f", data.parallelogramClosest ];
		parallelBest.position = CGPointMake( bestLabel.position.x, parallel.position.y );
		[ self addChild: parallelBest ];
		
		SKLabelNode *midpointBest = [ parallelBest copy ];
		midpointBest.text = [ NSString stringWithFormat: @"%.02f", data.midpointCloseset ];
		midpointBest.position = CGPointMake( midpointBest.position.x, midpointBest.position.y - diff );
		[ self addChild: midpointBest ];
		
		SKLabelNode *bisectBest = [ midpointBest copy ];
		bisectBest.text = [ NSString stringWithFormat: @"%.02f", data.bisectCloseset ];
		bisectBest.position = CGPointMake( bisectBest.position.x, bisectBest.position.y - diff );
		[ self addChild: bisectBest ];
		
		SKLabelNode *triangleBest = [ bisectBest copy ];
		triangleBest.text = [ NSString stringWithFormat: @"%.02f", data.triangleCloseset ];
		triangleBest.position = CGPointMake( triangleBest.position.x, triangleBest.position.y - diff );
		[ self addChild: triangleBest ];
		
		SKLabelNode *circleBest = [ triangleBest copy ];
		circleBest.text = [ NSString stringWithFormat: @"%.02f", data.circleClosest ];
		circleBest.position = CGPointMake( circleBest.position.x, circleBest.position.y - diff );
		[ self addChild: circleBest ];
		
		SKLabelNode *rightBest = [ circleBest copy ];
		rightBest.text = [ NSString stringWithFormat: @"%.02f", data.rightCloseset ];
		rightBest.position = CGPointMake( rightBest.position.x, rightBest.position.y - diff );
		[ self addChild: rightBest ];
		
		SKLabelNode *convergeBest = [ rightBest copy ];
		convergeBest.text = [ NSString stringWithFormat: @"%.02f", data.convergenceCloseset ];
		convergeBest.position = CGPointMake( convergeBest.position.x, convergeBest.position.y - diff );
		[ self addChild: convergeBest ];
		
		SKLabelNode *avgBest = [ convergeBest copy ];
		avgBest.text = [ NSString stringWithFormat: @"%.02f", data.avgErrorBest ];
		avgBest.position = CGPointMake( avgBest.position.x, avgBest.position.y - diff * 2 );
		[ self addChild: avgBest ];
		
		SKLabelNode *totalBest = [ avgBest copy ];
		totalBest.text = [ NSString stringWithFormat: @"%.02f", data.totalErrorBest ];
		totalBest.position = CGPointMake( totalBest.position.x, totalBest.position.y - diff );
		[ self addChild: totalBest ];
		
		SKLabelNode *timeBest = [ totalBest copy ];
		timeBest.text = [ NSString stringWithFormat: @"%.01f", data.timeFastest ];
		timeBest.position = CGPointMake( timeBest.position.x, timeBest.position.y - diff );
		[ self addChild: timeBest ];
		
		m_bannerHeight = bannerHeight;
		m_gvController = viewController;
	}
	return self;
}

- ( void ) didMoveToView: ( SKView* ) view {
	UITapGestureRecognizer *tapGesture = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
	[ view addGestureRecognizer: tapGesture ];
}

- ( void ) handleTap: ( UITapGestureRecognizer* ) sender {
	CGPoint location = [ sender locationInView: self.view ];
	location = CGPointMake( location.x, fabs( [ UIScreen mainScreen ].bounds.size.height - location.y ) );
	
	if ( CGRectContainsPoint( m_back, location ) ) {
		[ self.view presentScene: [ [ MainMenuScene alloc ] initWithSize: self.size withBannerHeight:m_bannerHeight withGameView: m_gvController ] transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	} else if ( CGRectContainsPoint( m_playAgain, location ) ) {
		[ self.view presentScene: [ [ GameScene alloc ] initWithSize: self.size withBannerHeight: m_bannerHeight withGameView: m_gvController ] transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	}
}

- ( void ) reportScore: ( CGFloat ) score scoreboard: ( NSString* ) scoreboard {
	GKScore *gkScore = [ [ GKScore alloc ] initWithLeaderboardIdentifier: scoreboard ];
	gkScore.value = score;
	
	[ GKScore reportScores: @[ gkScore ] withCompletionHandler: ^( NSError *error ) {
		if ( error != nil ) {
			NSLog( @"%@", [ error localizedDescription ] );
		}
	}];
}

- ( SKNode* ) getWrappingTextNode: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	UIImage *img = [ self drawText:text width: width height: height ];
	return [ SKSpriteNode spriteNodeWithTexture: [ SKTexture textureWithImage:img ] ];
}

- ( UIImage* ) drawText: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	NSMutableParagraphStyle *paragraphStyle = [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ];
	paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	paragraphStyle.firstLineHeadIndent = 0.5f;
	
	UIFont *font = [ UIFont fontWithName: GAME_FONT size: 50.0f ];
	
	UIColor *color = [ SKColor whiteColor ];
	NSDictionary *att = @{ NSForegroundColorAttributeName: color,  NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle };
	
	//using 800 here but make sure this height is greater than the potential height of the text (unless you want a max-height I guess but I did not test max-height)
	CGRect rect =  [ text boundingRectWithSize:CGSizeMake( width, 800 ) options: NSStringDrawingUsesLineFragmentOrigin attributes: att context: nil ];
	
	UIGraphicsBeginImageContextWithOptions( rect.size, NO, 0.0f );
	
	[ text drawInRect: rect withAttributes:att ];
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

@end