; ModuleID = 'copy_param.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%struct.TestStruct = type { [10 x i32], [10 x float] }

@.str = private constant [4 x i8] c"%i\0A\00", align 1 ; <[4 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define void @showData(%struct.TestStruct* nocapture byval align 4 %ts) nounwind {
entry:
  br label %bb

bb:                                               ; preds = %bb, %entry
  %i.03 = phi i32 [ 0, %entry ], [ %1, %bb ]      ; <i32> [#uses=4]
  %tmp = sub i32 0, %i.03                         ; <i32> [#uses=2]
  %scevgep = getelementptr %struct.TestStruct* %ts, i32 0, i32 1, i32 %i.03 ; <float*> [#uses=1]
  %scevgep4 = getelementptr %struct.TestStruct* %ts, i32 0, i32 0, i32 %i.03 ; <i32*> [#uses=1]
  store i32 %tmp, i32* %scevgep4, align 4
  %0 = sitofp i32 %tmp to float                   ; <float> [#uses=1]
  store float %0, float* %scevgep, align 4
  %1 = add nsw i32 %i.03, 1                       ; <i32> [#uses=2]
  %exitcond = icmp eq i32 %1, 10                  ; <i1> [#uses=1]
  br i1 %exitcond, label %return, label %bb

return:                                           ; preds = %bb
  ret void
}

define i32 @main(i32 %argc, i8* nocapture %argv) nounwind {
entry:
  %ts = alloca %struct.TestStruct, align 8        ; <%struct.TestStruct*> [#uses=5]
  br label %bb

bb:                                               ; preds = %bb, %entry
  %0 = phi i32 [ 0, %entry ], [ %2, %bb ]         ; <i32> [#uses=5]
  %scevgep13 = getelementptr %struct.TestStruct* %ts, i32 0, i32 1, i32 %0 ; <float*> [#uses=1]
  %scevgep14 = getelementptr %struct.TestStruct* %ts, i32 0, i32 0, i32 %0 ; <i32*> [#uses=1]
  store i32 %0, i32* %scevgep14, align 4
  %1 = sitofp i32 %0 to float                     ; <float> [#uses=1]
  store float %1, float* %scevgep13, align 4
  %2 = add nsw i32 %0, 1                          ; <i32> [#uses=2]
  %exitcond12 = icmp eq i32 %2, 10                ; <i1> [#uses=1]
  br i1 %exitcond12, label %bb2, label %bb

bb2:                                              ; preds = %bb
  call void @showData(%struct.TestStruct* byval align 4 %ts) nounwind
  br label %bb3

bb3:                                              ; preds = %bb3, %bb2
  %i.17 = phi i32 [ 0, %bb2 ], [ %8, %bb3 ]       ; <i32> [#uses=3]
  %scevgep = getelementptr %struct.TestStruct* %ts, i32 0, i32 1, i32 %i.17 ; <float*> [#uses=1]
  %scevgep11 = getelementptr %struct.TestStruct* %ts, i32 0, i32 0, i32 %i.17 ; <i32*> [#uses=1]
  %3 = load i32* %scevgep11, align 4              ; <i32> [#uses=1]
  %4 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0), i32 %3) nounwind ; <i32> [#uses=0]
  %5 = load float* %scevgep, align 4              ; <float> [#uses=1]
  %6 = fpext float %5 to double                   ; <double> [#uses=1]
  %7 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %6) nounwind ; <i32> [#uses=0]
  %8 = add nsw i32 %i.17, 1                       ; <i32> [#uses=2]
  %exitcond = icmp eq i32 %8, 10                  ; <i1> [#uses=1]
  br i1 %exitcond, label %bb5, label %bb3

bb5:                                              ; preds = %bb3
  ret i32 0
}

declare i32 @printf(i8* nocapture, ...) nounwind
