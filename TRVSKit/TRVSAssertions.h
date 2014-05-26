//
//  TRVSAssertions.h
//  Tests
//
//  Created by Travis Jeffery on 5/26/14.
//
//

void trvs_assertNotificationsObserved(id self, void (^block)(void), id firstNotification, ...);
void trvs_assertNotificationsNotObserved(id self, void (^block)(void), id firstNotification, ...);
