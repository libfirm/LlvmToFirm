; ModuleID = 'construct_destruct.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%0 = type { i32, void ()* }

@.str = private constant [5 x i8] c"Main\00", align 1 ; <[5 x i8]*> [#uses=1]
@.str1 = private constant [8 x i8] c"Goodbye\00", align 1 ; <[7 x i8]*> [#uses=1]
@.str2 = private constant [6 x i8] c"Hello\00", align 1 ; <[6 x i8]*> [#uses=1]
@Constructors_ctor_0 = common global i32 0                     ; <i32*> [#uses=0]
@llvm.global_ctors = appending global [1 x %0] [%0 { i32 65535, void ()* @construct }] ; <[1 x %0]*> [#uses=0]
@llvm.global_dtors = appending global [1 x %0] [%0 { i32 65535, void ()* @destruct }] ; <[1 x %0]*> [#uses=0]

define void @construct() nounwind {
entry:
  %0 = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @.str2, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  ret void
}

define i32 @main() nounwind {
entry:
  %0 = tail call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @puts(i8* nocapture) nounwind

define void @destruct() nounwind {
entry:
  %0 = tail call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  ret void
}
