; ModuleID = 'test.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [4 x i8] c"%x \00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"foo\00", align 1 ; <[4 x i8]*> [#uses=1]

define void @foo(i8* nocapture %a, i32 %n) nounwind {
entry:
  %0 = icmp sgt i32 %n, 0                         ; <i1> [#uses=1]
  br i1 %0, label %bb, label %bb2

bb:                                               ; preds = %bb, %entry
  %i.03 = phi i32 [ 0, %entry ], [ %4, %bb ]      ; <i32> [#uses=2]
  %scevgep = getelementptr i8* %a, i32 %i.03      ; <i8*> [#uses=1]
  %1 = load i8* %scevgep, align 1                 ; <i8> [#uses=1]
  %2 = zext i8 %1 to i32                          ; <i32> [#uses=1]
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %2) nounwind ; <i32> [#uses=0]
  %4 = add nsw i32 %i.03, 1                       ; <i32> [#uses=2]
  %exitcond = icmp eq i32 %4, %n                  ; <i1> [#uses=1]
  br i1 %exitcond, label %bb2, label %bb

bb2:                                              ; preds = %bb, %entry
  %5 = tail call i32 @putchar(i32 10) nounwind    ; <i32> [#uses=0]
  ret void
}

declare i32 @printf(i8* nocapture, ...) nounwind

declare i32 @putchar(i32) nounwind

@num = private global i256 79237420974927904823704987309278928736498269348629836492836
@num2 = private global i256 0

define i32 @main() nounwind {
entry:
  %0 = load i256* @num, align 8
  store i256 %0, i256* @num2

  %1 = bitcast i256* @num2 to i8*
  call void @foo(i8* %1, i32 40) nounwind

  ret i32 0
}
