#import <Foundation/Foundation.h>
#import <substrate.h>

namespace _SiriActivationService {
    namespace _isSAEEnabled {
        BOOL (*original)(id, SEL);
        BOOL custom(id self, SEL _cmd) {
            return YES;
        }
        void swizzle() {
            MSHookMessageEx(objc_lookUpClass("SiriActivationService"), sel_registerName("_isSAEEnabled"), reinterpret_cast<IMP>(custom), reinterpret_cast<IMP *>(original));
        }
    }

    // namespace _shouldShowHintGlowWithRequest {
    //     BOOL (*original)(id, SEL, id);
    //     BOOL custom(id self, SEL _cmd, id request) {
    //         return YES;
    //     }
    //     void swizzle() {
    //         Method method = class_getInstanceMethod(objc_lookUpClass("SiriActivationService"), sel_registerName("_shouldShowHintGlowWithRequest:"));
    //         original = reinterpret_cast<decltype(original)>(method_getImplementation(method));
    //         method_setImplementation(method, reinterpret_cast<IMP>(custom));
    //     }
    // }
}

// namespace _SiriPresentationViewController {
//     namespace _canPresentSiriEffectsViewControllerWithRequestOptions {
//         BOOL (*original)(id, SEL, id);
//         BOOL custom(id self, SEL _cmd, id options) {
//             return YES;
//         }
//         void swizzle() {
//             Method method = class_getInstanceMethod(objc_lookUpClass("SiriPresentationViewController"), sel_registerName("_canPresentSiriEffectsViewControllerWithRequestOptions:"));
//             original = reinterpret_cast<decltype(original)>(method_getImplementation(method));
//             method_setImplementation(method, reinterpret_cast<IMP>(custom));
//         }
//     }
// }

// namespace _SASActivationRequest {
//     namespace requestSourceForButtonIdentifier {
//         NSInteger (*original)(id, SEL, long);
//         NSInteger custom(id self, SEL _cmd, long identifier) {
//             return 2;
//         }
//         void swizzle() {
//             Method method = class_getClassMethod(objc_lookUpClass("SASActivationRequest"), sel_registerName("requestSourceForButtonIdentifier:"));
//             original = reinterpret_cast<decltype(original)>(method_getImplementation(method));
//             method_setImplementation(method, reinterpret_cast<IMP>(custom));
//         }
//     }
// }

__attribute__((constructor)) static void init() {
    _SiriActivationService::_isSAEEnabled::swizzle();
    // _SiriActivationService::_shouldShowHintGlowWithRequest::swizzle();
    // _SiriPresentationViewController::_canPresentSiriEffectsViewControllerWithRequestOptions::swizzle();
    // _SASActivationRequest::requestSourceForButtonIdentifier::swizzle();
}