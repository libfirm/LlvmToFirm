; ModuleID = 'unreachable_if.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [12 x i8] c"Hello world\00", align 1 ; <[12 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=2]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = load i32* %argc_addr, align 4              ; <i32> [#uses=1]
  %2 = icmp sgt i32 %1, 1                         ; <i1> [#uses=1]
  br i1 %2, label %bb, label %bb1

bb:                                               ; preds = %entry
  %3 = call i32 @puts(i8* getelementptr inbounds ([12 x i8]* @.str, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  call void @exit(i32 0) noreturn nounwind
  unreachable

bb1:                                              ; preds = %entry
  store i32 0, i32* %0, align 4
  %4 = load i32* %0, align 4                      ; <i32> [#uses=1]
  store i32 %4, i32* %retval, align 4
  br label %return

return:                                           ; preds = %bb1
  %retval2 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval2
}

declare i32 @puts(i8*)

declare void @exit(i32) noreturn nounwind
