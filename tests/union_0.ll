; ModuleID = 'union.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%struct.TestUnion = type { i32 }

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@.str1 = private constant [4 x i8] c"%f\0A\00", align 1 ; <[4 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %argc_addr = alloca i32                         ; <i32*> [#uses=1]
  %argv_addr = alloca i8**                        ; <i8***> [#uses=1]
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %tu = alloca %struct.TestUnion                  ; <%struct.TestUnion*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  store i32 %argc, i32* %argc_addr
  store i8** %argv, i8*** %argv_addr
  %1 = getelementptr inbounds %struct.TestUnion* %tu, i32 0, i32 0 ; <i32*> [#uses=1]
  %2 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* %1) nounwind ; <i32> [#uses=0]
  %3 = getelementptr inbounds %struct.TestUnion* %tu, i32 0, i32 0 ; <i32*> [#uses=1]
  %4 = bitcast i32* %3 to float*                  ; <float*> [#uses=1]
  %5 = load float* %4, align 4                    ; <float> [#uses=1]
  %6 = fpext float %5 to double                   ; <double> [#uses=1]
  %7 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), double %6) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %8 = load i32* %0, align 4                      ; <i32> [#uses=1]
  store i32 %8, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @"\01__isoc99_scanf"(i8* noalias, ...) nounwind

declare i32 @printf(i8* noalias, ...) nounwind
