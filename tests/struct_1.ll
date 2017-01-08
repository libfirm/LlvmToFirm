; ModuleID = 'struct.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

%struct.TestStruct = type { i32, i8, %struct.TestStruct2, float }
%struct.TestStruct2 = type { i8, i32 }

@.str = private constant [3 x i8] c"%i\00", align 1 ; <[3 x i8]*> [#uses=1]
@s = common global %struct.TestStruct zeroinitializer ; <%struct.TestStruct*> [#uses=4]
@.str1 = private constant [12 x i8] c"%i, %i, %e\0A\00", align 1 ; <[12 x i8]*> [#uses=1]

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %0 = tail call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* getelementptr inbounds (%struct.TestStruct* @s, i32 0, i32 2, i32 1)) nounwind ; <i32> [#uses=0]
  %1 = tail call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32* getelementptr inbounds (%struct.TestStruct* @s, i32 0, i32 0)) nounwind ; <i32> [#uses=0]
  store i8 9, i8* getelementptr inbounds (%struct.TestStruct* @s, i32 0, i32 1), align 4
  store float 1.270000e+02, float* getelementptr inbounds (%struct.TestStruct* @s, i32 0, i32 3), align 4
  %2 = load i32* getelementptr inbounds (%struct.TestStruct* @s, i32 0, i32 0), align 4 ; <i32> [#uses=1]
  %3 = tail call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([12 x i8]* @.str1, i32 0, i32 0), i32 %2, i32 9, double 1.270000e+02) nounwind ; <i32> [#uses=0]
  ret i32 0
}

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind

declare i32 @printf(i8* nocapture, ...) nounwind
