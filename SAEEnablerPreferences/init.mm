#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <substrate.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

namespace sep_NSBundle{
    namespace URLForResource_withExtension {
        id (*original)(id, SEL, id, id);
        NSURL *custom(NSBundle *self, SEL _cmd, NSString *resource, NSString *extension) {
            if ([resource isEqualToString:@"AssistantSettings"] && [extension isEqualToString:UTTypePropertyList.preferredFilenameExtension]) {
                return [NSURL fileURLWithPath:@"/var/jb/Library/Application Support/SAEEnabler/AssistantSettings.plist"];
            } else {
                return original(self, _cmd, resource, extension);
            }
        }
        void hook() {
            MSHookMessageEx(NSBundle.class, @selector(URLForResource:withExtension:), reinterpret_cast<IMP>(&custom), reinterpret_cast<IMP *>(&original));
        }
    }
}

namespace sep__TtC24AssistantSettingsSupport21GMEligibilityProvider{
    namespace deviceSupported {
        BOOL (*original)(id, SEL);
        BOOL custom(NSBundle *self, SEL _cmd) {
            return YES;
        }
        void hook() {
            MSHookMessageEx(objc_lookUpClass("_TtC24AssistantSettingsSupport21GMEligibilityProvider"), sel_registerName("deviceSupported"), reinterpret_cast<IMP>(&custom), reinterpret_cast<IMP *>(&original));
        }
    }
    namespace activeEnabled {
        BOOL (*original)(id, SEL);
        BOOL custom(NSBundle *self, SEL _cmd) {
            return YES;
        }
        void hook() {
            MSHookMessageEx(objc_lookUpClass("_TtC24AssistantSettingsSupport21GMEligibilityProvider"), sel_registerName("activeEnabled"), reinterpret_cast<IMP>(&custom), reinterpret_cast<IMP *>(&original));
        }
    }
    namespace eligibility {
        NSInteger (*original)(id, SEL);
        NSInteger custom(NSBundle *self, SEL _cmd) {
            return 0x5;
        }
        void hook() {
            MSHookMessageEx(objc_lookUpClass("_TtC24AssistantSettingsSupport21GMEligibilityProvider"), sel_registerName("eligibility"), reinterpret_cast<IMP>(&custom), reinterpret_cast<IMP *>(&original));
        }
    }
}

namespace sep_AssistantController {
    namespace viewDidLoad {
        void (*original)(__kindof UIViewController *self, SEL _cmd);
        void custom(__kindof UIViewController *self, SEL _cmd) {
            original(self, _cmd);

            NSMutableArray<UIBarButtonItemGroup *> *trailingItemGroups = [self.navigationItem.trailingItemGroups mutableCopy];

            __block auto retainedSelf = self;
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithPrimaryAction:[UIAction actionWithTitle:@"GMHistory" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
                __kindof UIViewController *viewController = [NSClassFromString(@"GMHistoryViewController") new];
                [retainedSelf.navigationController pushViewController:viewController animated:YES];
                [viewController release];
            }]];
            
            UIBarButtonItemGroup *group = [[UIBarButtonItemGroup alloc] initWithBarButtonItems:@[item] representativeItem:nil];
            [item release];
            
            [trailingItemGroups addObject:group];
            [group release];
            
            self.navigationItem.trailingItemGroups = trailingItemGroups;
            [trailingItemGroups release];
        }
        void hook() {
            MSHookMessageEx(objc_lookUpClass("AssistantController"), @selector(viewDidLoad), reinterpret_cast<IMP>(&custom), reinterpret_cast<IMP *>(&original));
        }
    }
}

__attribute__((constructor)) static void init() {
    // sep_NSBundle::URLForResource_withExtension::hook();
    // sep__TtC24AssistantSettingsSupport21GMEligibilityProvider::deviceSupported::hook();
    // sep__TtC24AssistantSettingsSupport21GMEligibilityProvider::activeEnabled::hook();
    // sep__TtC24AssistantSettingsSupport21GMEligibilityProvider::eligibility::hook();
    sep_AssistantController::viewDidLoad::hook();
}