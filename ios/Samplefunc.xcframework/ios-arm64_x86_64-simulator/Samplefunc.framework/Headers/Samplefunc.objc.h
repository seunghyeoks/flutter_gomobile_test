// Objective-C API for talking to gomobile_sample Go package.
//   gobind -lang=objc gomobile_sample
//
// File is generated by gobind. Do not edit.

#ifndef __Samplefunc_H__
#define __Samplefunc_H__

@import Foundation;
#include "ref.h"
#include "Universe.objc.h"


FOUNDATION_EXPORT NSString* _Nonnull SamplefuncReadFileContent(NSString* _Nullable filePath);

FOUNDATION_EXPORT long SamplefuncSum(long a, long b);

#endif
