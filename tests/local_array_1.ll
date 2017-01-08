; ModuleID = 'local_array.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [13 x i8] c"Hello world!\00", align 1 ; <[13 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %message = alloca [13 x i8], align 1            ; <[13 x i8]*> [#uses=2]
  %message1 = getelementptr inbounds [13 x i8]* %message, i32 0, i32 0 ; <i8*> [#uses=2]
  call void @llvm.memcpy.i32(i8* %message1, i8* getelementptr inbounds ([13 x i8]* @.str, i32 0, i32 0), i32 13, i32 1)
  %0 = getelementptr inbounds [13 x i8]* %message, i32 0, i32 11 ; <i8*> [#uses=1]
  store i8 63, i8* %0, align 1
  %1 = call i32 @puts(i8* %message1) nounwind     ; <i32> [#uses=0]
  ret i32 0
}

declare void @llvm.memcpy.i32(i8* nocapture, i8* nocapture, i32, i32) nounwind

declare i32 @puts(i8* nocapture) nounwind
