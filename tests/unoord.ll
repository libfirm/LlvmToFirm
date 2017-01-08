target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@nums = private constant [4 x i8] c"%i\0A\00", align 1
@nan  = private constant double 0x7FF8000000000000, align 8
@one  = private constant double 1.0, align 8

; ==============================================================================
; =                         uno/ord as jump condition                          =
; ==============================================================================

define void @is_uno_jump(double %num) nounwind {
entry:
  %0 = fcmp uno double %num, %num
  br i1 %0, label %true, label %false

true:
  %1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @nums, i32 0, i32 0), i32 1) nounwind
  br label %quit

false:
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @nums, i32 0, i32 0), i32 0) nounwind
  br label %quit

quit:
  ret void
}

define void @is_ord_jump(double %num) nounwind {
entry:
  %0 = fcmp ord double %num, %num
  br i1 %0, label %true, label %false

true:
  %1 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @nums, i32 0, i32 0), i32 1) nounwind
  br label %quit

false:
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @nums, i32 0, i32 0), i32 0) nounwind
  br label %quit

quit:
  ret void
}

; ==============================================================================
; =                         uno/ord to int conversion                          =
; ==============================================================================

define void @is_ord_conv(double %num) nounwind {
entry:
  %0 = fcmp ord double %num, %num
  %1 = zext i1 %0 to i32
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @nums, i32 0, i32 0), i32 %1) nounwind
  ret void
}

define void @is_uno_conv(double %num) nounwind {
entry:
  %0 = fcmp uno double %num, %num
  %1 = zext i1 %0 to i32
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @nums, i32 0, i32 0), i32 %1) nounwind
  ret void
}

; ==============================================================================
; =                             uno/ord in select                              =
; ==============================================================================

define void @is_ord_select(double %num) nounwind {
entry:
  %0 = fcmp ord double %num, %num
  %1 = select i1 %0, i32 5, i32 0
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @nums, i32 0, i32 0), i32 %1) nounwind
  ret void
}

define void @is_uno_select(double %num) nounwind {
entry:
  %0 = fcmp uno double %num, %num
  %1 = select i1 %0, i32 5, i32 0
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @nums, i32 0, i32 0), i32 %1) nounwind
  ret void
}

; ==============================================================================
; =                              Main entry point                              =
; ==============================================================================

define i32 @main() nounwind {
entry:
  %0 = load double* @nan, align 8
  %1 = load double* @one, align 8
  call void @is_uno_jump(double %0) nounwind
  call void @is_uno_jump(double %1) nounwind
  call void @is_ord_jump(double %0) nounwind
  call void @is_ord_jump(double %1) nounwind
  call void @is_uno_conv(double %0) nounwind
  call void @is_uno_conv(double %1) nounwind
  call void @is_ord_conv(double %0) nounwind
  call void @is_ord_conv(double %1) nounwind
  call void @is_uno_select(double %0) nounwind
  call void @is_uno_select(double %1) nounwind
  call void @is_ord_select(double %0) nounwind
  call void @is_ord_select(double %1) nounwind
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind
