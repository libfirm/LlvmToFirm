target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str2 = private constant [7 x i8] c"Error!\00", align 1 ; <[7 x i8]*> [#uses=1]

define i32 @main() nounwind {
entry:
  %b = alloca i32, align 4                        ; <i32*> [#uses=1]
  %a = alloca i32, align 4                        ; <i32*> [#uses=1]

  ; Should be  0
  %0 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  ; Should be -1
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %b) nounwind ; <i32> [#uses=0]

  %2 = load i32* %a
  %3 = load i32* %b

  %4 = and i32 %2, undef ; Should be  0
  %5 = or  i32 %3, undef ; Should be -1

  %6 = select i1 undef, i32 %2, i32 %3 ; Should be 0 or -1

  %7 = icmp eq i32 %6,  0
  %8 = icmp eq i32 %6, -1
  %9 = or i1 %7, %8
  %10 = zext i1 %9 to i32 ; Should be 1

  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %4) nounwind ; <i32> [#uses=0]
  %12 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %5) nounwind ; <i32> [#uses=0]
  %13 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %10) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
