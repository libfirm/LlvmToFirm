target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@bc  = private constant float bitcast (i32 982379473 to float)
@str = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %0 = load float* @bc
  %1 = fpext float %0 to double
  %2 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @str, i32 0, i32 0), double %1) nounwind
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind

