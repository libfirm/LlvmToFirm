; ModuleID = 'copy_param.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%struct.TestStruct = type { [10 x i32], [10 x float] }

@.str = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define void @showData(%struct.TestStruct* byval align 4 %ts) nounwind {
entry:
  %i = alloca i32                                 ; <i32*> [#uses=8]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 0, i32* %i, align 4
  br label %bb1

bb:                                               ; preds = %bb1
  %0 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %1 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %2 = sub i32 0, %1                              ; <i32> [#uses=1]
  %3 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <[10 x i32]*> [#uses=1]
  %4 = getelementptr inbounds [10 x i32]* %3, i32 0, i32 %0 ; <i32*> [#uses=1]
  store i32 %2, i32* %4, align 4
  %5 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %6 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %7 = sub i32 0, %6                              ; <i32> [#uses=1]
  %8 = sitofp i32 %7 to float                     ; <float> [#uses=1]
  %9 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 1 ; <[10 x float]*> [#uses=1]
  %10 = getelementptr inbounds [10 x float]* %9, i32 0, i32 %5 ; <float*> [#uses=1]
  store float %8, float* %10, align 4
  %11 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %12 = add nsw i32 %11, 1                        ; <i32> [#uses=1]
  store i32 %12, i32* %i, align 4
  br label %bb1

bb1:                                              ; preds = %bb, %entry
  %13 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %14 = icmp sle i32 %13, 9                       ; <i1> [#uses=1]
  br i1 %14, label %bb, label %bb2

bb2:                                              ; preds = %bb1
  br label %return

return:                                           ; preds = %bb2
  ret void
}

define i32 @main(i32 %argc, i8* %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8*                         ; <i8**> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %i = alloca i32                                 ; <i32*> [#uses=14]
  %ts = alloca %struct.TestStruct                 ; <%struct.TestStruct*> [#uses=5]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8* %argv, i8** %argv_addr
  store i32 0, i32* %i, align 4
  br label %bb1

bb:                                               ; preds = %bb1
  %1 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %2 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <[10 x i32]*> [#uses=1]
  %3 = getelementptr inbounds [10 x i32]* %2, i32 0, i32 %1 ; <i32*> [#uses=1]
  %4 = load i32* %i, align 4                      ; <i32> [#uses=1]
  store i32 %4, i32* %3, align 4
  %5 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %6 = load i32* %i, align 4                      ; <i32> [#uses=1]
  %7 = sitofp i32 %6 to float                     ; <float> [#uses=1]
  %8 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 1 ; <[10 x float]*> [#uses=1]
  %9 = getelementptr inbounds [10 x float]* %8, i32 0, i32 %5 ; <float*> [#uses=1]
  store float %7, float* %9, align 4
  %10 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %11 = add nsw i32 %10, 1                        ; <i32> [#uses=1]
  store i32 %11, i32* %i, align 4
  br label %bb1

bb1:                                              ; preds = %bb, %entry
  %12 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %13 = icmp sle i32 %12, 9                       ; <i1> [#uses=1]
  br i1 %13, label %bb, label %bb2

bb2:                                              ; preds = %bb1
  call void @showData(%struct.TestStruct* byval align 4 %ts) nounwind
  store i32 0, i32* %i, align 4
  br label %bb4

bb3:                                              ; preds = %bb4
  %14 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %15 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 0 ; <[10 x i32]*> [#uses=1]
  %16 = getelementptr inbounds [10 x i32]* %15, i32 0, i32 %14 ; <i32*> [#uses=1]
  %17 = load i32* %16, align 4                    ; <i32> [#uses=1]
  %18 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %17) nounwind ; <i32> [#uses=0]
  %19 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %20 = getelementptr inbounds %struct.TestStruct* %ts, i32 0, i32 1 ; <[10 x float]*> [#uses=1]
  %21 = getelementptr inbounds [10 x float]* %20, i32 0, i32 %19 ; <float*> [#uses=1]
  %22 = load float* %21, align 4                  ; <float> [#uses=1]
  %23 = fpext float %22 to double                 ; <double> [#uses=1]
  %24 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %23) nounwind ; <i32> [#uses=0]
  %25 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %26 = add nsw i32 %25, 1                        ; <i32> [#uses=1]
  store i32 %26, i32* %i, align 4
  br label %bb4

bb4:                                              ; preds = %bb3, %bb2
  %27 = load i32* %i, align 4                     ; <i32> [#uses=1]
  %28 = icmp sle i32 %27, 9                       ; <i1> [#uses=1]
  br i1 %28, label %bb3, label %bb5

bb5:                                              ; preds = %bb4
  store i32 0, i32* %0, align 4
  %29 = load i32* %0, align 4                     ; <i32> [#uses=1]
  store i32 %29, i32* %retval, align 4
  br label %return

return:                                           ; preds = %bb5
  %retval6 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval6
}

declare i32 @printf(i8* noalias, ...) nounwind
