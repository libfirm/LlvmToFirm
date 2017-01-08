; ModuleID = 'infinite_loop.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [12 x i8] c"Hello world\00", align 1 ; <[12 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind readnone {
entry:
  ret i32 0
}

define void @infiniteLoop() nounwind {
entry:
  br label %bb

bb:                                               ; preds = %bb, %entry
  %0 = tail call i32 @puts(i8* getelementptr inbounds ([12 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  br label %bb
}

declare i32 @puts(i8* nocapture) nounwind
