; ModuleID = 'extended_euclidean.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [20 x i8] c"%i*%i + %i*%i = %i\0A\00", align 1 ; <[20 x i8]*> [#uses=1]

define i32 @egcd(i32 %a, i32 %b, i32* %r, i32* %s) nounwind {
entry:
  %a_addr = alloca i32                            ; <i32*> [#uses=5]
  %b_addr = alloca i32                            ; <i32*> [#uses=6]
  %r_addr = alloca i32*                           ; <i32**> [#uses=2]
  %s_addr = alloca i32*                           ; <i32**> [#uses=2]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %temp = alloca i32                              ; <i32*> [#uses=6]
  %quot = alloca i32                              ; <i32*> [#uses=3]
  %lasty = alloca i32                             ; <i32*> [#uses=4]
  %y = alloca i32                                 ; <i32*> [#uses=4]
  %lastx = alloca i32                             ; <i32*> [#uses=4]
  %x = alloca i32                                 ; <i32*> [#uses=4]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %a, i32* %a_addr
  store i32 %b, i32* %b_addr
  store i32* %r, i32** %r_addr
  store i32* %s, i32** %s_addr
  store i32 0, i32* %x, align 4
  store i32 1, i32* %lastx, align 4
  store i32 1, i32* %y, align 4
  store i32 0, i32* %lasty, align 4
  br label %bb1

bb:                                               ; preds = %bb1
  %1 = load i32* %a_addr, align 4                 ; <i32> [#uses=1]
  %2 = load i32* %b_addr, align 4                 ; <i32> [#uses=1]
  %3 = sdiv i32 %1, %2                            ; <i32> [#uses=1]
  store i32 %3, i32* %quot, align 4
  %4 = load i32* %b_addr, align 4                 ; <i32> [#uses=1]
  store i32 %4, i32* %temp, align 4
  %5 = load i32* %a_addr, align 4                 ; <i32> [#uses=1]
  %6 = load i32* %b_addr, align 4                 ; <i32> [#uses=1]
  %7 = srem i32 %5, %6                            ; <i32> [#uses=1]
  store i32 %7, i32* %b_addr, align 4
  %8 = load i32* %temp, align 4                   ; <i32> [#uses=1]
  store i32 %8, i32* %a_addr, align 4
  %9 = load i32* %x, align 4                      ; <i32> [#uses=1]
  store i32 %9, i32* %temp, align 4
  %10 = load i32* %quot, align 4                  ; <i32> [#uses=1]
  %11 = load i32* %x, align 4                     ; <i32> [#uses=1]
  %12 = mul i32 %10, %11                          ; <i32> [#uses=1]
  %13 = load i32* %lastx, align 4                 ; <i32> [#uses=1]
  %14 = sub i32 %13, %12                          ; <i32> [#uses=1]
  store i32 %14, i32* %x, align 4
  %15 = load i32* %temp, align 4                  ; <i32> [#uses=1]
  store i32 %15, i32* %lastx, align 4
  %16 = load i32* %y, align 4                     ; <i32> [#uses=1]
  store i32 %16, i32* %temp, align 4
  %17 = load i32* %quot, align 4                  ; <i32> [#uses=1]
  %18 = load i32* %y, align 4                     ; <i32> [#uses=1]
  %19 = mul i32 %17, %18                          ; <i32> [#uses=1]
  %20 = load i32* %lasty, align 4                 ; <i32> [#uses=1]
  %21 = sub i32 %20, %19                          ; <i32> [#uses=1]
  store i32 %21, i32* %y, align 4
  %22 = load i32* %temp, align 4                  ; <i32> [#uses=1]
  store i32 %22, i32* %lasty, align 4
  br label %bb1

bb1:                                              ; preds = %bb, %entry
  %23 = load i32* %b_addr, align 4                ; <i32> [#uses=1]
  %24 = icmp ne i32 %23, 0                        ; <i1> [#uses=1]
  br i1 %24, label %bb, label %bb2

bb2:                                              ; preds = %bb1
  %25 = load i32** %r_addr, align 4               ; <i32*> [#uses=1]
  %26 = load i32* %lastx, align 4                 ; <i32> [#uses=1]
  store i32 %26, i32* %25, align 4
  %27 = load i32** %s_addr, align 4               ; <i32*> [#uses=1]
  %28 = load i32* %lasty, align 4                 ; <i32> [#uses=1]
  store i32 %28, i32* %27, align 4
  %29 = load i32* %a_addr, align 4                ; <i32> [#uses=1]
  store i32 %29, i32* %0, align 4
  %30 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %30, i32* %retval, align 4
  br label %return

return:                                           ; preds = %bb2
  %retval3 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval3
}

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %g = alloca i32                                 ; <i32*> [#uses=2]
  %s = alloca i32                                 ; <i32*> [#uses=2]
  %r = alloca i32                                 ; <i32*> [#uses=2]
  %b = alloca i32                                 ; <i32*> [#uses=3]
  %a = alloca i32                                 ; <i32*> [#uses=3]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %a) nounwind ; <i32> [#uses=0]
  %2 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %b) nounwind ; <i32> [#uses=0]
  %3 = load i32* %b, align 4                      ; <i32> [#uses=1]
  %4 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %5 = call i32 @egcd(i32 %4, i32 %3, i32* %r, i32* %s) nounwind ; <i32> [#uses=1]
  store i32 %5, i32* %g, align 4
  %6 = load i32* %b, align 4                      ; <i32> [#uses=1]
  %7 = load i32* %s, align 4                      ; <i32> [#uses=1]
  %8 = load i32* %a, align 4                      ; <i32> [#uses=1]
  %9 = load i32* %r, align 4                      ; <i32> [#uses=1]
  %10 = load i32* %g, align 4                     ; <i32> [#uses=1]
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @.str1, i32 0, i32 0), i32 %9, i32 %8, i32 %7, i32 %6, i32 %10) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %12 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %12, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @printf(i8* noalias, ...) nounwind
