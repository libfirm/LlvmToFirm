target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32"
target triple = "i386-unknown-linux-gnu"

@scanf_int = private constant [3 x i8] c"%i\00", align 1
@scanf_uint = private constant [3 x i8] c"%u\00", align 1
@scanf_double = private constant [4 x i8] c"%lf\00", align 1
@printf_eq = private constant [20 x i8] c"%i: %i  == %i = %i\0A\00", align 1
@printf_ne = private constant [20 x i8] c"%i: %i  != %i = %i\0A\00", align 1
@printf_ult = private constant [20 x i8] c"%i: %u u<  %u = %i\0A\00", align 1
@printf_ule = private constant [20 x i8] c"%i: %u u<= %u = %i\0A\00", align 1
@printf_ugt = private constant [20 x i8] c"%i: %u u>  %u = %i\0A\00", align 1
@printf_uge = private constant [20 x i8] c"%i: %u u>= %u = %i\0A\00", align 1
@printf_slt = private constant [20 x i8] c"%i: %i s<  %i = %i\0A\00", align 1
@printf_sle = private constant [20 x i8] c"%i: %i s<= %i = %i\0A\00", align 1
@printf_sgt = private constant [20 x i8] c"%i: %i s>  %i = %i\0A\00", align 1
@printf_sge = private constant [20 x i8] c"%i: %i s>= %i = %i\0A\00", align 1
@printf_foeq = private constant [24 x i8] c"%i: %.5E o== %.5E = %i\0A\00", align 1
@printf_fone = private constant [24 x i8] c"%i: %.5E o!= %.5E = %i\0A\00", align 1
@printf_folt = private constant [24 x i8] c"%i: %.5E o<  %.5E = %i\0A\00", align 1
@printf_fole = private constant [24 x i8] c"%i: %.5E o<= %.5E = %i\0A\00", align 1
@printf_fogt = private constant [24 x i8] c"%i: %.5E o>  %.5E = %i\0A\00", align 1
@printf_foge = private constant [24 x i8] c"%i: %.5E o>= %.5E = %i\0A\00", align 1
@printf_fueq = private constant [24 x i8] c"%i: %.5E u== %.5E = %i\0A\00", align 1
@printf_fune = private constant [24 x i8] c"%i: %.5E u!= %.5E = %i\0A\00", align 1
@printf_fult = private constant [24 x i8] c"%i: %.5E u<  %.5E = %i\0A\00", align 1
@printf_fule = private constant [24 x i8] c"%i: %.5E u<= %.5E = %i\0A\00", align 1
@printf_fugt = private constant [24 x i8] c"%i: %.5E u>  %.5E = %i\0A\00", align 1
@printf_fuge = private constant [24 x i8] c"%i: %.5E u>= %.5E = %i\0A\00", align 1
@printf_ftrue = private constant [24 x i8] c"%i: %.5E ttt %.5E = %i\0A\00", align 1
@printf_ffalse = private constant [24 x i8] c"%i: %.5E fff %.5E = %i\0A\00", align 1
@printf_ford = private constant [24 x i8] c"%i: %.5E ord %.5E = %i\0A\00", align 1
@printf_funo = private constant [24 x i8] c"%i: %.5E uno %.5E = %i\0A\00", align 1
@pinf = private constant double 0x7FF0000000000000, align 8
@ninf = private constant double 0xFFF0000000000000, align 8
@nan  = private constant double 0x7FF8000000000000, align 8

declare i32 @"\01__isoc99_scanf"(i8* nocapture, ...) nounwind
declare i32 @printf(i8* nocapture, ...) nounwind

define void @eq0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 0, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 1, i32 %2, i32 %5, i32 %10) nounwind
  %12 = icmp ule i32 %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 2, i32 %2, i32 %5, i32 %13) nounwind
  %15 = icmp ult i32 %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 3, i32 %2, i32 %5, i32 %16) nounwind
  %18 = icmp uge i32 %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 4, i32 %2, i32 %5, i32 %19) nounwind
  %21 = icmp ugt i32 %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 5, i32 %2, i32 %5, i32 %22) nounwind
  ret void
}

define void @eq1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 6, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 7, i32 %2, i32 %5, i32 %10) nounwind
  %12 = icmp ule i32 %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 8, i32 %2, i32 %5, i32 %13) nounwind
  %15 = icmp ult i32 %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 9, i32 %2, i32 %5, i32 %16) nounwind
  %18 = icmp uge i32 %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 10, i32 %2, i32 %5, i32 %19) nounwind
  %21 = icmp ugt i32 %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 11, i32 %2, i32 %5, i32 %22) nounwind
  ret void
}

define void @eq2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 12, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 13, i32 %2, i32 %5, i32 %10) nounwind
  %12 = icmp ule i32 %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 14, i32 %2, i32 %5, i32 %13) nounwind
  %15 = icmp ult i32 %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 15, i32 %2, i32 %5, i32 %16) nounwind
  %18 = icmp uge i32 %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 16, i32 %2, i32 %5, i32 %19) nounwind
  %21 = icmp ugt i32 %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 17, i32 %2, i32 %5, i32 %22) nounwind
  ret void
}

define void @eq3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 18, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 19, i32 %2, i32 %5, i32 %10) nounwind
  %12 = icmp ule i32 %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 20, i32 %2, i32 %5, i32 %13) nounwind
  %15 = icmp ult i32 %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 21, i32 %2, i32 %5, i32 %16) nounwind
  %18 = icmp uge i32 %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 22, i32 %2, i32 %5, i32 %19) nounwind
  %21 = icmp ugt i32 %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 23, i32 %2, i32 %5, i32 %22) nounwind
  ret void
}

define void @eq4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 24, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 25, i32 %2, i32 %5, i32 %10) nounwind
  %12 = icmp ule i32 %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 26, i32 %2, i32 %5, i32 %13) nounwind
  %15 = icmp ult i32 %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 27, i32 %2, i32 %5, i32 %16) nounwind
  %18 = icmp uge i32 %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 28, i32 %2, i32 %5, i32 %19) nounwind
  %21 = icmp ugt i32 %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 29, i32 %2, i32 %5, i32 %22) nounwind
  ret void
}

define void @ne0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 30, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 31, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ne1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 32, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 33, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ne2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 34, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 35, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ne3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 36, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 37, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ne4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp eq i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_eq, i32 0, i32 0), i32 38, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ne i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ne, i32 0, i32 0), i32 39, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ult0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ult i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 40, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp uge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 41, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ult1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ult i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 42, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp uge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 43, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ult2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ult i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 44, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp uge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 45, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ult3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ult i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 46, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp uge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 47, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ult4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ult i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 48, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp uge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 49, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ule0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ule i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 50, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ugt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 51, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ule1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ule i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 52, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ugt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 53, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ule2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ule i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 54, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ugt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 55, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ule3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ule i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 56, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ugt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 57, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ule4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ule i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 58, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ugt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 59, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ugt0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ugt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 60, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ule i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 61, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ugt1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ugt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 62, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ule i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 63, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ugt2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ugt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 64, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ule i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 65, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ugt3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ugt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 66, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ule i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 67, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @ugt4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp ugt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ugt, i32 0, i32 0), i32 68, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ule i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ule, i32 0, i32 0), i32 69, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @uge0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp uge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 70, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ult i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 71, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @uge1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp uge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 72, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ult i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 73, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @uge2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp uge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 74, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ult i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 75, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @uge3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp uge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 76, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ult i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 77, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @uge4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_uint, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp uge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_uge, i32 0, i32 0), i32 78, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp ult i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_ult, i32 0, i32 0), i32 79, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @slt0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp slt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 80, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 81, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @slt1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp slt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 82, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 83, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @slt2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp slt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 84, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 85, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @slt3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp slt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 86, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 87, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @slt4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp slt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 88, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sge i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 89, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sle0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sle i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 90, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sgt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 91, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sle1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sle i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 92, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sgt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 93, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sle2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sle i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 94, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sgt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 95, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sle3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sle i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 96, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sgt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 97, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sle4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sle i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 98, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sgt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 99, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sgt0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sgt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 100, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sle i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 101, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sgt1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sgt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 102, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sle i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 103, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sgt2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sgt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 104, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sle i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 105, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sgt3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sgt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 106, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sle i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 107, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sgt4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sgt i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sgt, i32 0, i32 0), i32 108, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp sle i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sle, i32 0, i32 0), i32 109, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sge0() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 110, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp slt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 111, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sge1() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 112, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp slt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 113, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sge2() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 114, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp slt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 115, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sge3() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 116, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp slt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 117, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @sge4() nounwind {
entry:
  %0 = alloca i32, align 4
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %0) nounwind
  %2 = load i32* %0, align 4
  %3 = alloca i32, align 4
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([3 x i8]* @scanf_int, i32 0, i32 0), i32* %3) nounwind
  %5 = load i32* %3, align 4
  %6 = icmp sge i32 %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_sge, i32 0, i32 0), i32 118, i32 %2, i32 %5, i32 %7) nounwind
  %9 = icmp slt i32 %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([20 x i8]* @printf_slt, i32 0, i32 0), i32 119, i32 %2, i32 %5, i32 %10) nounwind
  ret void
}

define void @intTest() nounwind {
entry:
  call void @eq0() nounwind
  call void @eq1() nounwind
  call void @eq2() nounwind
  call void @eq3() nounwind
  call void @eq4() nounwind
  call void @ne0() nounwind
  call void @ne1() nounwind
  call void @ne2() nounwind
  call void @ne3() nounwind
  call void @ne4() nounwind
  call void @ult0() nounwind
  call void @ult1() nounwind
  call void @ult2() nounwind
  call void @ult3() nounwind
  call void @ult4() nounwind
  call void @ule0() nounwind
  call void @ule1() nounwind
  call void @ule2() nounwind
  call void @ule3() nounwind
  call void @ule4() nounwind
  call void @ugt0() nounwind
  call void @ugt1() nounwind
  call void @ugt2() nounwind
  call void @ugt3() nounwind
  call void @ugt4() nounwind
  call void @uge0() nounwind
  call void @uge1() nounwind
  call void @uge2() nounwind
  call void @uge3() nounwind
  call void @uge4() nounwind
  call void @slt0() nounwind
  call void @slt1() nounwind
  call void @slt2() nounwind
  call void @slt3() nounwind
  call void @slt4() nounwind
  call void @sle0() nounwind
  call void @sle1() nounwind
  call void @sle2() nounwind
  call void @sle3() nounwind
  call void @sle4() nounwind
  call void @sgt0() nounwind
  call void @sgt1() nounwind
  call void @sgt2() nounwind
  call void @sgt3() nounwind
  call void @sgt4() nounwind
  call void @sge0() nounwind
  call void @sge1() nounwind
  call void @sge2() nounwind
  call void @sge3() nounwind
  call void @sge4() nounwind
  ret void
}

define void @feq0() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 120, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 121, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ole double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 122, double %2, double %5, i32 %13) nounwind
  %15 = fcmp olt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 123, double %2, double %5, i32 %16) nounwind
  %18 = fcmp oge double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 124, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ogt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 125, double %2, double %5, i32 %22) nounwind
  %24 = fcmp ueq double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 126, double %2, double %5, i32 %25) nounwind
  %27 = fcmp une double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 127, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ule double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 128, double %2, double %5, i32 %31) nounwind
  %33 = fcmp ult double %2, %5
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 129, double %2, double %5, i32 %34) nounwind
  %36 = fcmp uge double %2, %5
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 130, double %2, double %5, i32 %37) nounwind
  %39 = fcmp ugt double %2, %5
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 131, double %2, double %5, i32 %40) nounwind
  %42 = fcmp true double %2, %5
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ftrue, i32 0, i32 0), i32 132, double %2, double %5, i32 %43) nounwind
  %45 = fcmp false double %2, %5
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ffalse, i32 0, i32 0), i32 133, double %2, double %5, i32 %46) nounwind
  ret void
}

define void @feq1() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 134, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 135, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ole double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 136, double %2, double %5, i32 %13) nounwind
  %15 = fcmp olt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 137, double %2, double %5, i32 %16) nounwind
  %18 = fcmp oge double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 138, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ogt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 139, double %2, double %5, i32 %22) nounwind
  %24 = fcmp ueq double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 140, double %2, double %5, i32 %25) nounwind
  %27 = fcmp une double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 141, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ule double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 142, double %2, double %5, i32 %31) nounwind
  %33 = fcmp ult double %2, %5
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 143, double %2, double %5, i32 %34) nounwind
  %36 = fcmp uge double %2, %5
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 144, double %2, double %5, i32 %37) nounwind
  %39 = fcmp ugt double %2, %5
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 145, double %2, double %5, i32 %40) nounwind
  %42 = fcmp true double %2, %5
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ftrue, i32 0, i32 0), i32 146, double %2, double %5, i32 %43) nounwind
  %45 = fcmp false double %2, %5
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ffalse, i32 0, i32 0), i32 147, double %2, double %5, i32 %46) nounwind
  ret void
}

define void @feq2() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 148, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 149, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ole double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 150, double %2, double %5, i32 %13) nounwind
  %15 = fcmp olt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 151, double %2, double %5, i32 %16) nounwind
  %18 = fcmp oge double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 152, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ogt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 153, double %2, double %5, i32 %22) nounwind
  %24 = fcmp ueq double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 154, double %2, double %5, i32 %25) nounwind
  %27 = fcmp une double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 155, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ule double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 156, double %2, double %5, i32 %31) nounwind
  %33 = fcmp ult double %2, %5
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 157, double %2, double %5, i32 %34) nounwind
  %36 = fcmp uge double %2, %5
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 158, double %2, double %5, i32 %37) nounwind
  %39 = fcmp ugt double %2, %5
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 159, double %2, double %5, i32 %40) nounwind
  %42 = fcmp true double %2, %5
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ftrue, i32 0, i32 0), i32 160, double %2, double %5, i32 %43) nounwind
  %45 = fcmp false double %2, %5
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ffalse, i32 0, i32 0), i32 161, double %2, double %5, i32 %46) nounwind
  ret void
}

define void @feq3() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 162, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 163, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ole double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 164, double %2, double %5, i32 %13) nounwind
  %15 = fcmp olt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 165, double %2, double %5, i32 %16) nounwind
  %18 = fcmp oge double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 166, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ogt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 167, double %2, double %5, i32 %22) nounwind
  %24 = fcmp ueq double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 168, double %2, double %5, i32 %25) nounwind
  %27 = fcmp une double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 169, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ule double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 170, double %2, double %5, i32 %31) nounwind
  %33 = fcmp ult double %2, %5
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 171, double %2, double %5, i32 %34) nounwind
  %36 = fcmp uge double %2, %5
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 172, double %2, double %5, i32 %37) nounwind
  %39 = fcmp ugt double %2, %5
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 173, double %2, double %5, i32 %40) nounwind
  %42 = fcmp true double %2, %5
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ftrue, i32 0, i32 0), i32 174, double %2, double %5, i32 %43) nounwind
  %45 = fcmp false double %2, %5
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ffalse, i32 0, i32 0), i32 175, double %2, double %5, i32 %46) nounwind
  ret void
}

define void @feq4() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 176, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 177, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ole double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 178, double %2, double %5, i32 %13) nounwind
  %15 = fcmp olt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 179, double %2, double %5, i32 %16) nounwind
  %18 = fcmp oge double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 180, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ogt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 181, double %2, double %5, i32 %22) nounwind
  %24 = fcmp ueq double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 182, double %2, double %5, i32 %25) nounwind
  %27 = fcmp une double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 183, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ule double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 184, double %2, double %5, i32 %31) nounwind
  %33 = fcmp ult double %2, %5
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 185, double %2, double %5, i32 %34) nounwind
  %36 = fcmp uge double %2, %5
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 186, double %2, double %5, i32 %37) nounwind
  %39 = fcmp ugt double %2, %5
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 187, double %2, double %5, i32 %40) nounwind
  %42 = fcmp true double %2, %5
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ftrue, i32 0, i32 0), i32 188, double %2, double %5, i32 %43) nounwind
  %45 = fcmp false double %2, %5
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ffalse, i32 0, i32 0), i32 189, double %2, double %5, i32 %46) nounwind
  ret void
}

define void @fne0() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 190, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 191, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ueq double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 192, double %2, double %5, i32 %13) nounwind
  %15 = fcmp une double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 193, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fne1() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 194, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 195, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ueq double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 196, double %2, double %5, i32 %13) nounwind
  %15 = fcmp une double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 197, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fne2() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 198, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 199, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ueq double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 200, double %2, double %5, i32 %13) nounwind
  %15 = fcmp une double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 201, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fne3() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 202, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 203, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ueq double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 204, double %2, double %5, i32 %13) nounwind
  %15 = fcmp une double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 205, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fne4() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oeq double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 206, double %2, double %5, i32 %7) nounwind
  %9 = fcmp one double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 207, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ueq double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 208, double %2, double %5, i32 %13) nounwind
  %15 = fcmp une double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 209, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @flt0() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp olt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 210, double %2, double %5, i32 %7) nounwind
  %9 = fcmp oge double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 211, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ult double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 212, double %2, double %5, i32 %13) nounwind
  %15 = fcmp uge double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 213, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @flt1() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp olt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 214, double %2, double %5, i32 %7) nounwind
  %9 = fcmp oge double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 215, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ult double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 216, double %2, double %5, i32 %13) nounwind
  %15 = fcmp uge double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 217, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @flt2() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp olt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 218, double %2, double %5, i32 %7) nounwind
  %9 = fcmp oge double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 219, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ult double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 220, double %2, double %5, i32 %13) nounwind
  %15 = fcmp uge double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 221, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @flt3() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp olt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 222, double %2, double %5, i32 %7) nounwind
  %9 = fcmp oge double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 223, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ult double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 224, double %2, double %5, i32 %13) nounwind
  %15 = fcmp uge double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 225, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @flt4() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp olt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 226, double %2, double %5, i32 %7) nounwind
  %9 = fcmp oge double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 227, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ult double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 228, double %2, double %5, i32 %13) nounwind
  %15 = fcmp uge double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 229, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fle0() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ole double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 230, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ogt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 231, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ule double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 232, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ugt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 233, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fle1() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ole double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 234, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ogt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 235, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ule double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 236, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ugt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 237, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fle2() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ole double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 238, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ogt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 239, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ule double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 240, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ugt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 241, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fle3() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ole double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 242, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ogt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 243, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ule double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 244, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ugt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 245, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fle4() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ole double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 246, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ogt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 247, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ule double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 248, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ugt double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 249, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fgt0() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ogt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 250, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ole double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 251, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ugt double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 252, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ule double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 253, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fgt1() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ogt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 254, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ole double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 255, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ugt double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 256, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ule double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 257, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fgt2() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ogt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 258, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ole double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 259, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ugt double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 260, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ule double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 261, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fgt3() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ogt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 262, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ole double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 263, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ugt double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 264, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ule double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 265, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fgt4() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp ogt double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 266, double %2, double %5, i32 %7) nounwind
  %9 = fcmp ole double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 267, double %2, double %5, i32 %10) nounwind
  %12 = fcmp ugt double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 268, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ule double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 269, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fge0() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oge double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 270, double %2, double %5, i32 %7) nounwind
  %9 = fcmp olt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 271, double %2, double %5, i32 %10) nounwind
  %12 = fcmp uge double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 272, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ult double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 273, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fge1() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oge double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 274, double %2, double %5, i32 %7) nounwind
  %9 = fcmp olt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 275, double %2, double %5, i32 %10) nounwind
  %12 = fcmp uge double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 276, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ult double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 277, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fge2() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oge double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 278, double %2, double %5, i32 %7) nounwind
  %9 = fcmp olt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 279, double %2, double %5, i32 %10) nounwind
  %12 = fcmp uge double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 280, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ult double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 281, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fge3() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oge double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 282, double %2, double %5, i32 %7) nounwind
  %9 = fcmp olt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 283, double %2, double %5, i32 %10) nounwind
  %12 = fcmp uge double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 284, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ult double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 285, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @fge4() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = fcmp oge double %2, %5
  %7 = zext i1 %6 to i32
  %8 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 286, double %2, double %5, i32 %7) nounwind
  %9 = fcmp olt double %2, %5
  %10 = zext i1 %9 to i32
  %11 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 287, double %2, double %5, i32 %10) nounwind
  %12 = fcmp uge double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 288, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ult double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 289, double %2, double %5, i32 %16) nounwind
  ret void
}

define void @ford0() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = load double* @nan, align 8
  %7 = load double* @pinf, align 8
  %8 = load double* @ninf, align 8
  %9 = load double* @nan, align 8
  %10 = load double* @pinf, align 8
  %11 = load double* @ninf, align 8
  %12 = fcmp ord double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 290, double %2, double %5, i32 %13) nounwind
  %15 = fcmp oeq double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 291, double %2, double %5, i32 %16) nounwind
  %18 = fcmp one double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 292, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ogt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 293, double %2, double %5, i32 %22) nounwind
  %24 = fcmp oge double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 294, double %2, double %5, i32 %25) nounwind
  %27 = fcmp olt double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 295, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ole double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 296, double %2, double %5, i32 %31) nounwind
  %33 = fcmp ord double %2, %9
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 297, double %2, double %9, i32 %34) nounwind
  %36 = fcmp oeq double %2, %9
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 298, double %2, double %9, i32 %37) nounwind
  %39 = fcmp one double %2, %9
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 299, double %2, double %9, i32 %40) nounwind
  %42 = fcmp ogt double %2, %9
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 300, double %2, double %9, i32 %43) nounwind
  %45 = fcmp oge double %2, %9
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 301, double %2, double %9, i32 %46) nounwind
  %48 = fcmp olt double %2, %9
  %49 = zext i1 %48 to i32
  %50 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 302, double %2, double %9, i32 %49) nounwind
  %51 = fcmp ole double %2, %9
  %52 = zext i1 %51 to i32
  %53 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 303, double %2, double %9, i32 %52) nounwind
  %54 = fcmp ord double %2, %10
  %55 = zext i1 %54 to i32
  %56 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 304, double %2, double %10, i32 %55) nounwind
  %57 = fcmp oeq double %2, %10
  %58 = zext i1 %57 to i32
  %59 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 305, double %2, double %10, i32 %58) nounwind
  %60 = fcmp one double %2, %10
  %61 = zext i1 %60 to i32
  %62 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 306, double %2, double %10, i32 %61) nounwind
  %63 = fcmp ogt double %2, %10
  %64 = zext i1 %63 to i32
  %65 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 307, double %2, double %10, i32 %64) nounwind
  %66 = fcmp oge double %2, %10
  %67 = zext i1 %66 to i32
  %68 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 308, double %2, double %10, i32 %67) nounwind
  %69 = fcmp olt double %2, %10
  %70 = zext i1 %69 to i32
  %71 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 309, double %2, double %10, i32 %70) nounwind
  %72 = fcmp ole double %2, %10
  %73 = zext i1 %72 to i32
  %74 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 310, double %2, double %10, i32 %73) nounwind
  %75 = fcmp ord double %2, %11
  %76 = zext i1 %75 to i32
  %77 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 311, double %2, double %11, i32 %76) nounwind
  %78 = fcmp oeq double %2, %11
  %79 = zext i1 %78 to i32
  %80 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 312, double %2, double %11, i32 %79) nounwind
  %81 = fcmp one double %2, %11
  %82 = zext i1 %81 to i32
  %83 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 313, double %2, double %11, i32 %82) nounwind
  %84 = fcmp ogt double %2, %11
  %85 = zext i1 %84 to i32
  %86 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 314, double %2, double %11, i32 %85) nounwind
  %87 = fcmp oge double %2, %11
  %88 = zext i1 %87 to i32
  %89 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 315, double %2, double %11, i32 %88) nounwind
  %90 = fcmp olt double %2, %11
  %91 = zext i1 %90 to i32
  %92 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 316, double %2, double %11, i32 %91) nounwind
  %93 = fcmp ole double %2, %11
  %94 = zext i1 %93 to i32
  %95 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 317, double %2, double %11, i32 %94) nounwind
  %96 = fcmp ord double %6, %5
  %97 = zext i1 %96 to i32
  %98 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 318, double %6, double %5, i32 %97) nounwind
  %99 = fcmp oeq double %6, %5
  %100 = zext i1 %99 to i32
  %101 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 319, double %6, double %5, i32 %100) nounwind
  %102 = fcmp one double %6, %5
  %103 = zext i1 %102 to i32
  %104 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 320, double %6, double %5, i32 %103) nounwind
  %105 = fcmp ogt double %6, %5
  %106 = zext i1 %105 to i32
  %107 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 321, double %6, double %5, i32 %106) nounwind
  %108 = fcmp oge double %6, %5
  %109 = zext i1 %108 to i32
  %110 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 322, double %6, double %5, i32 %109) nounwind
  %111 = fcmp olt double %6, %5
  %112 = zext i1 %111 to i32
  %113 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 323, double %6, double %5, i32 %112) nounwind
  %114 = fcmp ole double %6, %5
  %115 = zext i1 %114 to i32
  %116 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 324, double %6, double %5, i32 %115) nounwind
  %117 = fcmp ord double %6, %9
  %118 = zext i1 %117 to i32
  %119 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 325, double %6, double %9, i32 %118) nounwind
  %120 = fcmp oeq double %6, %9
  %121 = zext i1 %120 to i32
  %122 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 326, double %6, double %9, i32 %121) nounwind
  %123 = fcmp one double %6, %9
  %124 = zext i1 %123 to i32
  %125 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 327, double %6, double %9, i32 %124) nounwind
  %126 = fcmp ogt double %6, %9
  %127 = zext i1 %126 to i32
  %128 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 328, double %6, double %9, i32 %127) nounwind
  %129 = fcmp oge double %6, %9
  %130 = zext i1 %129 to i32
  %131 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 329, double %6, double %9, i32 %130) nounwind
  %132 = fcmp olt double %6, %9
  %133 = zext i1 %132 to i32
  %134 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 330, double %6, double %9, i32 %133) nounwind
  %135 = fcmp ole double %6, %9
  %136 = zext i1 %135 to i32
  %137 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 331, double %6, double %9, i32 %136) nounwind
  %138 = fcmp ord double %6, %10
  %139 = zext i1 %138 to i32
  %140 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 332, double %6, double %10, i32 %139) nounwind
  %141 = fcmp oeq double %6, %10
  %142 = zext i1 %141 to i32
  %143 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 333, double %6, double %10, i32 %142) nounwind
  %144 = fcmp one double %6, %10
  %145 = zext i1 %144 to i32
  %146 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 334, double %6, double %10, i32 %145) nounwind
  %147 = fcmp ogt double %6, %10
  %148 = zext i1 %147 to i32
  %149 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 335, double %6, double %10, i32 %148) nounwind
  %150 = fcmp oge double %6, %10
  %151 = zext i1 %150 to i32
  %152 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 336, double %6, double %10, i32 %151) nounwind
  %153 = fcmp olt double %6, %10
  %154 = zext i1 %153 to i32
  %155 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 337, double %6, double %10, i32 %154) nounwind
  %156 = fcmp ole double %6, %10
  %157 = zext i1 %156 to i32
  %158 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 338, double %6, double %10, i32 %157) nounwind
  %159 = fcmp ord double %6, %11
  %160 = zext i1 %159 to i32
  %161 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 339, double %6, double %11, i32 %160) nounwind
  %162 = fcmp oeq double %6, %11
  %163 = zext i1 %162 to i32
  %164 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 340, double %6, double %11, i32 %163) nounwind
  %165 = fcmp one double %6, %11
  %166 = zext i1 %165 to i32
  %167 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 341, double %6, double %11, i32 %166) nounwind
  %168 = fcmp ogt double %6, %11
  %169 = zext i1 %168 to i32
  %170 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 342, double %6, double %11, i32 %169) nounwind
  %171 = fcmp oge double %6, %11
  %172 = zext i1 %171 to i32
  %173 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 343, double %6, double %11, i32 %172) nounwind
  %174 = fcmp olt double %6, %11
  %175 = zext i1 %174 to i32
  %176 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 344, double %6, double %11, i32 %175) nounwind
  %177 = fcmp ole double %6, %11
  %178 = zext i1 %177 to i32
  %179 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 345, double %6, double %11, i32 %178) nounwind
  %180 = fcmp ord double %7, %5
  %181 = zext i1 %180 to i32
  %182 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 346, double %7, double %5, i32 %181) nounwind
  %183 = fcmp oeq double %7, %5
  %184 = zext i1 %183 to i32
  %185 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 347, double %7, double %5, i32 %184) nounwind
  %186 = fcmp one double %7, %5
  %187 = zext i1 %186 to i32
  %188 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 348, double %7, double %5, i32 %187) nounwind
  %189 = fcmp ogt double %7, %5
  %190 = zext i1 %189 to i32
  %191 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 349, double %7, double %5, i32 %190) nounwind
  %192 = fcmp oge double %7, %5
  %193 = zext i1 %192 to i32
  %194 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 350, double %7, double %5, i32 %193) nounwind
  %195 = fcmp olt double %7, %5
  %196 = zext i1 %195 to i32
  %197 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 351, double %7, double %5, i32 %196) nounwind
  %198 = fcmp ole double %7, %5
  %199 = zext i1 %198 to i32
  %200 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 352, double %7, double %5, i32 %199) nounwind
  %201 = fcmp ord double %7, %9
  %202 = zext i1 %201 to i32
  %203 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 353, double %7, double %9, i32 %202) nounwind
  %204 = fcmp oeq double %7, %9
  %205 = zext i1 %204 to i32
  %206 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 354, double %7, double %9, i32 %205) nounwind
  %207 = fcmp one double %7, %9
  %208 = zext i1 %207 to i32
  %209 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 355, double %7, double %9, i32 %208) nounwind
  %210 = fcmp ogt double %7, %9
  %211 = zext i1 %210 to i32
  %212 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 356, double %7, double %9, i32 %211) nounwind
  %213 = fcmp oge double %7, %9
  %214 = zext i1 %213 to i32
  %215 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 357, double %7, double %9, i32 %214) nounwind
  %216 = fcmp olt double %7, %9
  %217 = zext i1 %216 to i32
  %218 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 358, double %7, double %9, i32 %217) nounwind
  %219 = fcmp ole double %7, %9
  %220 = zext i1 %219 to i32
  %221 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 359, double %7, double %9, i32 %220) nounwind
  %222 = fcmp ord double %7, %10
  %223 = zext i1 %222 to i32
  %224 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 360, double %7, double %10, i32 %223) nounwind
  %225 = fcmp oeq double %7, %10
  %226 = zext i1 %225 to i32
  %227 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 361, double %7, double %10, i32 %226) nounwind
  %228 = fcmp one double %7, %10
  %229 = zext i1 %228 to i32
  %230 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 362, double %7, double %10, i32 %229) nounwind
  %231 = fcmp ogt double %7, %10
  %232 = zext i1 %231 to i32
  %233 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 363, double %7, double %10, i32 %232) nounwind
  %234 = fcmp oge double %7, %10
  %235 = zext i1 %234 to i32
  %236 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 364, double %7, double %10, i32 %235) nounwind
  %237 = fcmp olt double %7, %10
  %238 = zext i1 %237 to i32
  %239 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 365, double %7, double %10, i32 %238) nounwind
  %240 = fcmp ole double %7, %10
  %241 = zext i1 %240 to i32
  %242 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 366, double %7, double %10, i32 %241) nounwind
  %243 = fcmp ord double %7, %11
  %244 = zext i1 %243 to i32
  %245 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 367, double %7, double %11, i32 %244) nounwind
  %246 = fcmp oeq double %7, %11
  %247 = zext i1 %246 to i32
  %248 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 368, double %7, double %11, i32 %247) nounwind
  %249 = fcmp one double %7, %11
  %250 = zext i1 %249 to i32
  %251 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 369, double %7, double %11, i32 %250) nounwind
  %252 = fcmp ogt double %7, %11
  %253 = zext i1 %252 to i32
  %254 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 370, double %7, double %11, i32 %253) nounwind
  %255 = fcmp oge double %7, %11
  %256 = zext i1 %255 to i32
  %257 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 371, double %7, double %11, i32 %256) nounwind
  %258 = fcmp olt double %7, %11
  %259 = zext i1 %258 to i32
  %260 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 372, double %7, double %11, i32 %259) nounwind
  %261 = fcmp ole double %7, %11
  %262 = zext i1 %261 to i32
  %263 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 373, double %7, double %11, i32 %262) nounwind
  %264 = fcmp ord double %8, %5
  %265 = zext i1 %264 to i32
  %266 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 374, double %8, double %5, i32 %265) nounwind
  %267 = fcmp oeq double %8, %5
  %268 = zext i1 %267 to i32
  %269 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 375, double %8, double %5, i32 %268) nounwind
  %270 = fcmp one double %8, %5
  %271 = zext i1 %270 to i32
  %272 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 376, double %8, double %5, i32 %271) nounwind
  %273 = fcmp ogt double %8, %5
  %274 = zext i1 %273 to i32
  %275 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 377, double %8, double %5, i32 %274) nounwind
  %276 = fcmp oge double %8, %5
  %277 = zext i1 %276 to i32
  %278 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 378, double %8, double %5, i32 %277) nounwind
  %279 = fcmp olt double %8, %5
  %280 = zext i1 %279 to i32
  %281 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 379, double %8, double %5, i32 %280) nounwind
  %282 = fcmp ole double %8, %5
  %283 = zext i1 %282 to i32
  %284 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 380, double %8, double %5, i32 %283) nounwind
  %285 = fcmp ord double %8, %9
  %286 = zext i1 %285 to i32
  %287 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 381, double %8, double %9, i32 %286) nounwind
  %288 = fcmp oeq double %8, %9
  %289 = zext i1 %288 to i32
  %290 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 382, double %8, double %9, i32 %289) nounwind
  %291 = fcmp one double %8, %9
  %292 = zext i1 %291 to i32
  %293 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 383, double %8, double %9, i32 %292) nounwind
  %294 = fcmp ogt double %8, %9
  %295 = zext i1 %294 to i32
  %296 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 384, double %8, double %9, i32 %295) nounwind
  %297 = fcmp oge double %8, %9
  %298 = zext i1 %297 to i32
  %299 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 385, double %8, double %9, i32 %298) nounwind
  %300 = fcmp olt double %8, %9
  %301 = zext i1 %300 to i32
  %302 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 386, double %8, double %9, i32 %301) nounwind
  %303 = fcmp ole double %8, %9
  %304 = zext i1 %303 to i32
  %305 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 387, double %8, double %9, i32 %304) nounwind
  %306 = fcmp ord double %8, %10
  %307 = zext i1 %306 to i32
  %308 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 388, double %8, double %10, i32 %307) nounwind
  %309 = fcmp oeq double %8, %10
  %310 = zext i1 %309 to i32
  %311 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 389, double %8, double %10, i32 %310) nounwind
  %312 = fcmp one double %8, %10
  %313 = zext i1 %312 to i32
  %314 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 390, double %8, double %10, i32 %313) nounwind
  %315 = fcmp ogt double %8, %10
  %316 = zext i1 %315 to i32
  %317 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 391, double %8, double %10, i32 %316) nounwind
  %318 = fcmp oge double %8, %10
  %319 = zext i1 %318 to i32
  %320 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 392, double %8, double %10, i32 %319) nounwind
  %321 = fcmp olt double %8, %10
  %322 = zext i1 %321 to i32
  %323 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 393, double %8, double %10, i32 %322) nounwind
  %324 = fcmp ole double %8, %10
  %325 = zext i1 %324 to i32
  %326 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 394, double %8, double %10, i32 %325) nounwind
  %327 = fcmp ord double %8, %11
  %328 = zext i1 %327 to i32
  %329 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 395, double %8, double %11, i32 %328) nounwind
  %330 = fcmp oeq double %8, %11
  %331 = zext i1 %330 to i32
  %332 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 396, double %8, double %11, i32 %331) nounwind
  %333 = fcmp one double %8, %11
  %334 = zext i1 %333 to i32
  %335 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 397, double %8, double %11, i32 %334) nounwind
  %336 = fcmp ogt double %8, %11
  %337 = zext i1 %336 to i32
  %338 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 398, double %8, double %11, i32 %337) nounwind
  %339 = fcmp oge double %8, %11
  %340 = zext i1 %339 to i32
  %341 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 399, double %8, double %11, i32 %340) nounwind
  %342 = fcmp olt double %8, %11
  %343 = zext i1 %342 to i32
  %344 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 400, double %8, double %11, i32 %343) nounwind
  %345 = fcmp ole double %8, %11
  %346 = zext i1 %345 to i32
  %347 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 401, double %8, double %11, i32 %346) nounwind
  ret void
}

define void @ford1() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = load double* @nan, align 8
  %7 = load double* @pinf, align 8
  %8 = load double* @ninf, align 8
  %9 = load double* @nan, align 8
  %10 = load double* @pinf, align 8
  %11 = load double* @ninf, align 8
  %12 = fcmp ord double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 402, double %2, double %5, i32 %13) nounwind
  %15 = fcmp oeq double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 403, double %2, double %5, i32 %16) nounwind
  %18 = fcmp one double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 404, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ogt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 405, double %2, double %5, i32 %22) nounwind
  %24 = fcmp oge double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 406, double %2, double %5, i32 %25) nounwind
  %27 = fcmp olt double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 407, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ole double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 408, double %2, double %5, i32 %31) nounwind
  %33 = fcmp ord double %2, %9
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 409, double %2, double %9, i32 %34) nounwind
  %36 = fcmp oeq double %2, %9
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 410, double %2, double %9, i32 %37) nounwind
  %39 = fcmp one double %2, %9
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 411, double %2, double %9, i32 %40) nounwind
  %42 = fcmp ogt double %2, %9
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 412, double %2, double %9, i32 %43) nounwind
  %45 = fcmp oge double %2, %9
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 413, double %2, double %9, i32 %46) nounwind
  %48 = fcmp olt double %2, %9
  %49 = zext i1 %48 to i32
  %50 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 414, double %2, double %9, i32 %49) nounwind
  %51 = fcmp ole double %2, %9
  %52 = zext i1 %51 to i32
  %53 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 415, double %2, double %9, i32 %52) nounwind
  %54 = fcmp ord double %2, %10
  %55 = zext i1 %54 to i32
  %56 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 416, double %2, double %10, i32 %55) nounwind
  %57 = fcmp oeq double %2, %10
  %58 = zext i1 %57 to i32
  %59 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 417, double %2, double %10, i32 %58) nounwind
  %60 = fcmp one double %2, %10
  %61 = zext i1 %60 to i32
  %62 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 418, double %2, double %10, i32 %61) nounwind
  %63 = fcmp ogt double %2, %10
  %64 = zext i1 %63 to i32
  %65 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 419, double %2, double %10, i32 %64) nounwind
  %66 = fcmp oge double %2, %10
  %67 = zext i1 %66 to i32
  %68 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 420, double %2, double %10, i32 %67) nounwind
  %69 = fcmp olt double %2, %10
  %70 = zext i1 %69 to i32
  %71 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 421, double %2, double %10, i32 %70) nounwind
  %72 = fcmp ole double %2, %10
  %73 = zext i1 %72 to i32
  %74 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 422, double %2, double %10, i32 %73) nounwind
  %75 = fcmp ord double %2, %11
  %76 = zext i1 %75 to i32
  %77 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 423, double %2, double %11, i32 %76) nounwind
  %78 = fcmp oeq double %2, %11
  %79 = zext i1 %78 to i32
  %80 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 424, double %2, double %11, i32 %79) nounwind
  %81 = fcmp one double %2, %11
  %82 = zext i1 %81 to i32
  %83 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 425, double %2, double %11, i32 %82) nounwind
  %84 = fcmp ogt double %2, %11
  %85 = zext i1 %84 to i32
  %86 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 426, double %2, double %11, i32 %85) nounwind
  %87 = fcmp oge double %2, %11
  %88 = zext i1 %87 to i32
  %89 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 427, double %2, double %11, i32 %88) nounwind
  %90 = fcmp olt double %2, %11
  %91 = zext i1 %90 to i32
  %92 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 428, double %2, double %11, i32 %91) nounwind
  %93 = fcmp ole double %2, %11
  %94 = zext i1 %93 to i32
  %95 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 429, double %2, double %11, i32 %94) nounwind
  %96 = fcmp ord double %6, %5
  %97 = zext i1 %96 to i32
  %98 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 430, double %6, double %5, i32 %97) nounwind
  %99 = fcmp oeq double %6, %5
  %100 = zext i1 %99 to i32
  %101 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 431, double %6, double %5, i32 %100) nounwind
  %102 = fcmp one double %6, %5
  %103 = zext i1 %102 to i32
  %104 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 432, double %6, double %5, i32 %103) nounwind
  %105 = fcmp ogt double %6, %5
  %106 = zext i1 %105 to i32
  %107 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 433, double %6, double %5, i32 %106) nounwind
  %108 = fcmp oge double %6, %5
  %109 = zext i1 %108 to i32
  %110 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 434, double %6, double %5, i32 %109) nounwind
  %111 = fcmp olt double %6, %5
  %112 = zext i1 %111 to i32
  %113 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 435, double %6, double %5, i32 %112) nounwind
  %114 = fcmp ole double %6, %5
  %115 = zext i1 %114 to i32
  %116 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 436, double %6, double %5, i32 %115) nounwind
  %117 = fcmp ord double %6, %9
  %118 = zext i1 %117 to i32
  %119 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 437, double %6, double %9, i32 %118) nounwind
  %120 = fcmp oeq double %6, %9
  %121 = zext i1 %120 to i32
  %122 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 438, double %6, double %9, i32 %121) nounwind
  %123 = fcmp one double %6, %9
  %124 = zext i1 %123 to i32
  %125 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 439, double %6, double %9, i32 %124) nounwind
  %126 = fcmp ogt double %6, %9
  %127 = zext i1 %126 to i32
  %128 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 440, double %6, double %9, i32 %127) nounwind
  %129 = fcmp oge double %6, %9
  %130 = zext i1 %129 to i32
  %131 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 441, double %6, double %9, i32 %130) nounwind
  %132 = fcmp olt double %6, %9
  %133 = zext i1 %132 to i32
  %134 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 442, double %6, double %9, i32 %133) nounwind
  %135 = fcmp ole double %6, %9
  %136 = zext i1 %135 to i32
  %137 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 443, double %6, double %9, i32 %136) nounwind
  %138 = fcmp ord double %6, %10
  %139 = zext i1 %138 to i32
  %140 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 444, double %6, double %10, i32 %139) nounwind
  %141 = fcmp oeq double %6, %10
  %142 = zext i1 %141 to i32
  %143 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 445, double %6, double %10, i32 %142) nounwind
  %144 = fcmp one double %6, %10
  %145 = zext i1 %144 to i32
  %146 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 446, double %6, double %10, i32 %145) nounwind
  %147 = fcmp ogt double %6, %10
  %148 = zext i1 %147 to i32
  %149 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 447, double %6, double %10, i32 %148) nounwind
  %150 = fcmp oge double %6, %10
  %151 = zext i1 %150 to i32
  %152 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 448, double %6, double %10, i32 %151) nounwind
  %153 = fcmp olt double %6, %10
  %154 = zext i1 %153 to i32
  %155 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 449, double %6, double %10, i32 %154) nounwind
  %156 = fcmp ole double %6, %10
  %157 = zext i1 %156 to i32
  %158 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 450, double %6, double %10, i32 %157) nounwind
  %159 = fcmp ord double %6, %11
  %160 = zext i1 %159 to i32
  %161 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 451, double %6, double %11, i32 %160) nounwind
  %162 = fcmp oeq double %6, %11
  %163 = zext i1 %162 to i32
  %164 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 452, double %6, double %11, i32 %163) nounwind
  %165 = fcmp one double %6, %11
  %166 = zext i1 %165 to i32
  %167 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 453, double %6, double %11, i32 %166) nounwind
  %168 = fcmp ogt double %6, %11
  %169 = zext i1 %168 to i32
  %170 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 454, double %6, double %11, i32 %169) nounwind
  %171 = fcmp oge double %6, %11
  %172 = zext i1 %171 to i32
  %173 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 455, double %6, double %11, i32 %172) nounwind
  %174 = fcmp olt double %6, %11
  %175 = zext i1 %174 to i32
  %176 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 456, double %6, double %11, i32 %175) nounwind
  %177 = fcmp ole double %6, %11
  %178 = zext i1 %177 to i32
  %179 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 457, double %6, double %11, i32 %178) nounwind
  %180 = fcmp ord double %7, %5
  %181 = zext i1 %180 to i32
  %182 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 458, double %7, double %5, i32 %181) nounwind
  %183 = fcmp oeq double %7, %5
  %184 = zext i1 %183 to i32
  %185 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 459, double %7, double %5, i32 %184) nounwind
  %186 = fcmp one double %7, %5
  %187 = zext i1 %186 to i32
  %188 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 460, double %7, double %5, i32 %187) nounwind
  %189 = fcmp ogt double %7, %5
  %190 = zext i1 %189 to i32
  %191 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 461, double %7, double %5, i32 %190) nounwind
  %192 = fcmp oge double %7, %5
  %193 = zext i1 %192 to i32
  %194 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 462, double %7, double %5, i32 %193) nounwind
  %195 = fcmp olt double %7, %5
  %196 = zext i1 %195 to i32
  %197 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 463, double %7, double %5, i32 %196) nounwind
  %198 = fcmp ole double %7, %5
  %199 = zext i1 %198 to i32
  %200 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 464, double %7, double %5, i32 %199) nounwind
  %201 = fcmp ord double %7, %9
  %202 = zext i1 %201 to i32
  %203 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 465, double %7, double %9, i32 %202) nounwind
  %204 = fcmp oeq double %7, %9
  %205 = zext i1 %204 to i32
  %206 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 466, double %7, double %9, i32 %205) nounwind
  %207 = fcmp one double %7, %9
  %208 = zext i1 %207 to i32
  %209 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 467, double %7, double %9, i32 %208) nounwind
  %210 = fcmp ogt double %7, %9
  %211 = zext i1 %210 to i32
  %212 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 468, double %7, double %9, i32 %211) nounwind
  %213 = fcmp oge double %7, %9
  %214 = zext i1 %213 to i32
  %215 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 469, double %7, double %9, i32 %214) nounwind
  %216 = fcmp olt double %7, %9
  %217 = zext i1 %216 to i32
  %218 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 470, double %7, double %9, i32 %217) nounwind
  %219 = fcmp ole double %7, %9
  %220 = zext i1 %219 to i32
  %221 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 471, double %7, double %9, i32 %220) nounwind
  %222 = fcmp ord double %7, %10
  %223 = zext i1 %222 to i32
  %224 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 472, double %7, double %10, i32 %223) nounwind
  %225 = fcmp oeq double %7, %10
  %226 = zext i1 %225 to i32
  %227 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 473, double %7, double %10, i32 %226) nounwind
  %228 = fcmp one double %7, %10
  %229 = zext i1 %228 to i32
  %230 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 474, double %7, double %10, i32 %229) nounwind
  %231 = fcmp ogt double %7, %10
  %232 = zext i1 %231 to i32
  %233 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 475, double %7, double %10, i32 %232) nounwind
  %234 = fcmp oge double %7, %10
  %235 = zext i1 %234 to i32
  %236 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 476, double %7, double %10, i32 %235) nounwind
  %237 = fcmp olt double %7, %10
  %238 = zext i1 %237 to i32
  %239 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 477, double %7, double %10, i32 %238) nounwind
  %240 = fcmp ole double %7, %10
  %241 = zext i1 %240 to i32
  %242 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 478, double %7, double %10, i32 %241) nounwind
  %243 = fcmp ord double %7, %11
  %244 = zext i1 %243 to i32
  %245 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 479, double %7, double %11, i32 %244) nounwind
  %246 = fcmp oeq double %7, %11
  %247 = zext i1 %246 to i32
  %248 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 480, double %7, double %11, i32 %247) nounwind
  %249 = fcmp one double %7, %11
  %250 = zext i1 %249 to i32
  %251 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 481, double %7, double %11, i32 %250) nounwind
  %252 = fcmp ogt double %7, %11
  %253 = zext i1 %252 to i32
  %254 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 482, double %7, double %11, i32 %253) nounwind
  %255 = fcmp oge double %7, %11
  %256 = zext i1 %255 to i32
  %257 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 483, double %7, double %11, i32 %256) nounwind
  %258 = fcmp olt double %7, %11
  %259 = zext i1 %258 to i32
  %260 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 484, double %7, double %11, i32 %259) nounwind
  %261 = fcmp ole double %7, %11
  %262 = zext i1 %261 to i32
  %263 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 485, double %7, double %11, i32 %262) nounwind
  %264 = fcmp ord double %8, %5
  %265 = zext i1 %264 to i32
  %266 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 486, double %8, double %5, i32 %265) nounwind
  %267 = fcmp oeq double %8, %5
  %268 = zext i1 %267 to i32
  %269 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 487, double %8, double %5, i32 %268) nounwind
  %270 = fcmp one double %8, %5
  %271 = zext i1 %270 to i32
  %272 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 488, double %8, double %5, i32 %271) nounwind
  %273 = fcmp ogt double %8, %5
  %274 = zext i1 %273 to i32
  %275 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 489, double %8, double %5, i32 %274) nounwind
  %276 = fcmp oge double %8, %5
  %277 = zext i1 %276 to i32
  %278 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 490, double %8, double %5, i32 %277) nounwind
  %279 = fcmp olt double %8, %5
  %280 = zext i1 %279 to i32
  %281 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 491, double %8, double %5, i32 %280) nounwind
  %282 = fcmp ole double %8, %5
  %283 = zext i1 %282 to i32
  %284 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 492, double %8, double %5, i32 %283) nounwind
  %285 = fcmp ord double %8, %9
  %286 = zext i1 %285 to i32
  %287 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 493, double %8, double %9, i32 %286) nounwind
  %288 = fcmp oeq double %8, %9
  %289 = zext i1 %288 to i32
  %290 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 494, double %8, double %9, i32 %289) nounwind
  %291 = fcmp one double %8, %9
  %292 = zext i1 %291 to i32
  %293 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 495, double %8, double %9, i32 %292) nounwind
  %294 = fcmp ogt double %8, %9
  %295 = zext i1 %294 to i32
  %296 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 496, double %8, double %9, i32 %295) nounwind
  %297 = fcmp oge double %8, %9
  %298 = zext i1 %297 to i32
  %299 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 497, double %8, double %9, i32 %298) nounwind
  %300 = fcmp olt double %8, %9
  %301 = zext i1 %300 to i32
  %302 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 498, double %8, double %9, i32 %301) nounwind
  %303 = fcmp ole double %8, %9
  %304 = zext i1 %303 to i32
  %305 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 499, double %8, double %9, i32 %304) nounwind
  %306 = fcmp ord double %8, %10
  %307 = zext i1 %306 to i32
  %308 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 500, double %8, double %10, i32 %307) nounwind
  %309 = fcmp oeq double %8, %10
  %310 = zext i1 %309 to i32
  %311 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 501, double %8, double %10, i32 %310) nounwind
  %312 = fcmp one double %8, %10
  %313 = zext i1 %312 to i32
  %314 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 502, double %8, double %10, i32 %313) nounwind
  %315 = fcmp ogt double %8, %10
  %316 = zext i1 %315 to i32
  %317 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 503, double %8, double %10, i32 %316) nounwind
  %318 = fcmp oge double %8, %10
  %319 = zext i1 %318 to i32
  %320 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 504, double %8, double %10, i32 %319) nounwind
  %321 = fcmp olt double %8, %10
  %322 = zext i1 %321 to i32
  %323 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 505, double %8, double %10, i32 %322) nounwind
  %324 = fcmp ole double %8, %10
  %325 = zext i1 %324 to i32
  %326 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 506, double %8, double %10, i32 %325) nounwind
  %327 = fcmp ord double %8, %11
  %328 = zext i1 %327 to i32
  %329 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_ford, i32 0, i32 0), i32 507, double %8, double %11, i32 %328) nounwind
  %330 = fcmp oeq double %8, %11
  %331 = zext i1 %330 to i32
  %332 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foeq, i32 0, i32 0), i32 508, double %8, double %11, i32 %331) nounwind
  %333 = fcmp one double %8, %11
  %334 = zext i1 %333 to i32
  %335 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fone, i32 0, i32 0), i32 509, double %8, double %11, i32 %334) nounwind
  %336 = fcmp ogt double %8, %11
  %337 = zext i1 %336 to i32
  %338 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fogt, i32 0, i32 0), i32 510, double %8, double %11, i32 %337) nounwind
  %339 = fcmp oge double %8, %11
  %340 = zext i1 %339 to i32
  %341 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_foge, i32 0, i32 0), i32 511, double %8, double %11, i32 %340) nounwind
  %342 = fcmp olt double %8, %11
  %343 = zext i1 %342 to i32
  %344 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_folt, i32 0, i32 0), i32 512, double %8, double %11, i32 %343) nounwind
  %345 = fcmp ole double %8, %11
  %346 = zext i1 %345 to i32
  %347 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fole, i32 0, i32 0), i32 513, double %8, double %11, i32 %346) nounwind
  ret void
}

define void @funo0() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = load double* @nan, align 8
  %7 = load double* @pinf, align 8
  %8 = load double* @ninf, align 8
  %9 = load double* @nan, align 8
  %10 = load double* @pinf, align 8
  %11 = load double* @ninf, align 8
  %12 = fcmp uno double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 514, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ueq double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 515, double %2, double %5, i32 %16) nounwind
  %18 = fcmp une double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 516, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ugt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 517, double %2, double %5, i32 %22) nounwind
  %24 = fcmp uge double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 518, double %2, double %5, i32 %25) nounwind
  %27 = fcmp ult double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 519, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ule double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 520, double %2, double %5, i32 %31) nounwind
  %33 = fcmp uno double %2, %9
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 521, double %2, double %9, i32 %34) nounwind
  %36 = fcmp ueq double %2, %9
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 522, double %2, double %9, i32 %37) nounwind
  %39 = fcmp une double %2, %9
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 523, double %2, double %9, i32 %40) nounwind
  %42 = fcmp ugt double %2, %9
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 524, double %2, double %9, i32 %43) nounwind
  %45 = fcmp uge double %2, %9
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 525, double %2, double %9, i32 %46) nounwind
  %48 = fcmp ult double %2, %9
  %49 = zext i1 %48 to i32
  %50 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 526, double %2, double %9, i32 %49) nounwind
  %51 = fcmp ule double %2, %9
  %52 = zext i1 %51 to i32
  %53 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 527, double %2, double %9, i32 %52) nounwind
  %54 = fcmp uno double %2, %10
  %55 = zext i1 %54 to i32
  %56 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 528, double %2, double %10, i32 %55) nounwind
  %57 = fcmp ueq double %2, %10
  %58 = zext i1 %57 to i32
  %59 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 529, double %2, double %10, i32 %58) nounwind
  %60 = fcmp une double %2, %10
  %61 = zext i1 %60 to i32
  %62 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 530, double %2, double %10, i32 %61) nounwind
  %63 = fcmp ugt double %2, %10
  %64 = zext i1 %63 to i32
  %65 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 531, double %2, double %10, i32 %64) nounwind
  %66 = fcmp uge double %2, %10
  %67 = zext i1 %66 to i32
  %68 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 532, double %2, double %10, i32 %67) nounwind
  %69 = fcmp ult double %2, %10
  %70 = zext i1 %69 to i32
  %71 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 533, double %2, double %10, i32 %70) nounwind
  %72 = fcmp ule double %2, %10
  %73 = zext i1 %72 to i32
  %74 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 534, double %2, double %10, i32 %73) nounwind
  %75 = fcmp uno double %2, %11
  %76 = zext i1 %75 to i32
  %77 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 535, double %2, double %11, i32 %76) nounwind
  %78 = fcmp ueq double %2, %11
  %79 = zext i1 %78 to i32
  %80 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 536, double %2, double %11, i32 %79) nounwind
  %81 = fcmp une double %2, %11
  %82 = zext i1 %81 to i32
  %83 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 537, double %2, double %11, i32 %82) nounwind
  %84 = fcmp ugt double %2, %11
  %85 = zext i1 %84 to i32
  %86 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 538, double %2, double %11, i32 %85) nounwind
  %87 = fcmp uge double %2, %11
  %88 = zext i1 %87 to i32
  %89 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 539, double %2, double %11, i32 %88) nounwind
  %90 = fcmp ult double %2, %11
  %91 = zext i1 %90 to i32
  %92 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 540, double %2, double %11, i32 %91) nounwind
  %93 = fcmp ule double %2, %11
  %94 = zext i1 %93 to i32
  %95 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 541, double %2, double %11, i32 %94) nounwind
  %96 = fcmp uno double %6, %5
  %97 = zext i1 %96 to i32
  %98 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 542, double %6, double %5, i32 %97) nounwind
  %99 = fcmp ueq double %6, %5
  %100 = zext i1 %99 to i32
  %101 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 543, double %6, double %5, i32 %100) nounwind
  %102 = fcmp une double %6, %5
  %103 = zext i1 %102 to i32
  %104 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 544, double %6, double %5, i32 %103) nounwind
  %105 = fcmp ugt double %6, %5
  %106 = zext i1 %105 to i32
  %107 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 545, double %6, double %5, i32 %106) nounwind
  %108 = fcmp uge double %6, %5
  %109 = zext i1 %108 to i32
  %110 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 546, double %6, double %5, i32 %109) nounwind
  %111 = fcmp ult double %6, %5
  %112 = zext i1 %111 to i32
  %113 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 547, double %6, double %5, i32 %112) nounwind
  %114 = fcmp ule double %6, %5
  %115 = zext i1 %114 to i32
  %116 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 548, double %6, double %5, i32 %115) nounwind
  %117 = fcmp uno double %6, %9
  %118 = zext i1 %117 to i32
  %119 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 549, double %6, double %9, i32 %118) nounwind
  %120 = fcmp ueq double %6, %9
  %121 = zext i1 %120 to i32
  %122 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 550, double %6, double %9, i32 %121) nounwind
  %123 = fcmp une double %6, %9
  %124 = zext i1 %123 to i32
  %125 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 551, double %6, double %9, i32 %124) nounwind
  %126 = fcmp ugt double %6, %9
  %127 = zext i1 %126 to i32
  %128 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 552, double %6, double %9, i32 %127) nounwind
  %129 = fcmp uge double %6, %9
  %130 = zext i1 %129 to i32
  %131 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 553, double %6, double %9, i32 %130) nounwind
  %132 = fcmp ult double %6, %9
  %133 = zext i1 %132 to i32
  %134 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 554, double %6, double %9, i32 %133) nounwind
  %135 = fcmp ule double %6, %9
  %136 = zext i1 %135 to i32
  %137 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 555, double %6, double %9, i32 %136) nounwind
  %138 = fcmp uno double %6, %10
  %139 = zext i1 %138 to i32
  %140 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 556, double %6, double %10, i32 %139) nounwind
  %141 = fcmp ueq double %6, %10
  %142 = zext i1 %141 to i32
  %143 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 557, double %6, double %10, i32 %142) nounwind
  %144 = fcmp une double %6, %10
  %145 = zext i1 %144 to i32
  %146 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 558, double %6, double %10, i32 %145) nounwind
  %147 = fcmp ugt double %6, %10
  %148 = zext i1 %147 to i32
  %149 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 559, double %6, double %10, i32 %148) nounwind
  %150 = fcmp uge double %6, %10
  %151 = zext i1 %150 to i32
  %152 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 560, double %6, double %10, i32 %151) nounwind
  %153 = fcmp ult double %6, %10
  %154 = zext i1 %153 to i32
  %155 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 561, double %6, double %10, i32 %154) nounwind
  %156 = fcmp ule double %6, %10
  %157 = zext i1 %156 to i32
  %158 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 562, double %6, double %10, i32 %157) nounwind
  %159 = fcmp uno double %6, %11
  %160 = zext i1 %159 to i32
  %161 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 563, double %6, double %11, i32 %160) nounwind
  %162 = fcmp ueq double %6, %11
  %163 = zext i1 %162 to i32
  %164 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 564, double %6, double %11, i32 %163) nounwind
  %165 = fcmp une double %6, %11
  %166 = zext i1 %165 to i32
  %167 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 565, double %6, double %11, i32 %166) nounwind
  %168 = fcmp ugt double %6, %11
  %169 = zext i1 %168 to i32
  %170 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 566, double %6, double %11, i32 %169) nounwind
  %171 = fcmp uge double %6, %11
  %172 = zext i1 %171 to i32
  %173 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 567, double %6, double %11, i32 %172) nounwind
  %174 = fcmp ult double %6, %11
  %175 = zext i1 %174 to i32
  %176 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 568, double %6, double %11, i32 %175) nounwind
  %177 = fcmp ule double %6, %11
  %178 = zext i1 %177 to i32
  %179 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 569, double %6, double %11, i32 %178) nounwind
  %180 = fcmp uno double %7, %5
  %181 = zext i1 %180 to i32
  %182 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 570, double %7, double %5, i32 %181) nounwind
  %183 = fcmp ueq double %7, %5
  %184 = zext i1 %183 to i32
  %185 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 571, double %7, double %5, i32 %184) nounwind
  %186 = fcmp une double %7, %5
  %187 = zext i1 %186 to i32
  %188 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 572, double %7, double %5, i32 %187) nounwind
  %189 = fcmp ugt double %7, %5
  %190 = zext i1 %189 to i32
  %191 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 573, double %7, double %5, i32 %190) nounwind
  %192 = fcmp uge double %7, %5
  %193 = zext i1 %192 to i32
  %194 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 574, double %7, double %5, i32 %193) nounwind
  %195 = fcmp ult double %7, %5
  %196 = zext i1 %195 to i32
  %197 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 575, double %7, double %5, i32 %196) nounwind
  %198 = fcmp ule double %7, %5
  %199 = zext i1 %198 to i32
  %200 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 576, double %7, double %5, i32 %199) nounwind
  %201 = fcmp uno double %7, %9
  %202 = zext i1 %201 to i32
  %203 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 577, double %7, double %9, i32 %202) nounwind
  %204 = fcmp ueq double %7, %9
  %205 = zext i1 %204 to i32
  %206 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 578, double %7, double %9, i32 %205) nounwind
  %207 = fcmp une double %7, %9
  %208 = zext i1 %207 to i32
  %209 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 579, double %7, double %9, i32 %208) nounwind
  %210 = fcmp ugt double %7, %9
  %211 = zext i1 %210 to i32
  %212 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 580, double %7, double %9, i32 %211) nounwind
  %213 = fcmp uge double %7, %9
  %214 = zext i1 %213 to i32
  %215 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 581, double %7, double %9, i32 %214) nounwind
  %216 = fcmp ult double %7, %9
  %217 = zext i1 %216 to i32
  %218 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 582, double %7, double %9, i32 %217) nounwind
  %219 = fcmp ule double %7, %9
  %220 = zext i1 %219 to i32
  %221 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 583, double %7, double %9, i32 %220) nounwind
  %222 = fcmp uno double %7, %10
  %223 = zext i1 %222 to i32
  %224 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 584, double %7, double %10, i32 %223) nounwind
  %225 = fcmp ueq double %7, %10
  %226 = zext i1 %225 to i32
  %227 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 585, double %7, double %10, i32 %226) nounwind
  %228 = fcmp une double %7, %10
  %229 = zext i1 %228 to i32
  %230 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 586, double %7, double %10, i32 %229) nounwind
  %231 = fcmp ugt double %7, %10
  %232 = zext i1 %231 to i32
  %233 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 587, double %7, double %10, i32 %232) nounwind
  %234 = fcmp uge double %7, %10
  %235 = zext i1 %234 to i32
  %236 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 588, double %7, double %10, i32 %235) nounwind
  %237 = fcmp ult double %7, %10
  %238 = zext i1 %237 to i32
  %239 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 589, double %7, double %10, i32 %238) nounwind
  %240 = fcmp ule double %7, %10
  %241 = zext i1 %240 to i32
  %242 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 590, double %7, double %10, i32 %241) nounwind
  %243 = fcmp uno double %7, %11
  %244 = zext i1 %243 to i32
  %245 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 591, double %7, double %11, i32 %244) nounwind
  %246 = fcmp ueq double %7, %11
  %247 = zext i1 %246 to i32
  %248 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 592, double %7, double %11, i32 %247) nounwind
  %249 = fcmp une double %7, %11
  %250 = zext i1 %249 to i32
  %251 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 593, double %7, double %11, i32 %250) nounwind
  %252 = fcmp ugt double %7, %11
  %253 = zext i1 %252 to i32
  %254 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 594, double %7, double %11, i32 %253) nounwind
  %255 = fcmp uge double %7, %11
  %256 = zext i1 %255 to i32
  %257 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 595, double %7, double %11, i32 %256) nounwind
  %258 = fcmp ult double %7, %11
  %259 = zext i1 %258 to i32
  %260 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 596, double %7, double %11, i32 %259) nounwind
  %261 = fcmp ule double %7, %11
  %262 = zext i1 %261 to i32
  %263 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 597, double %7, double %11, i32 %262) nounwind
  %264 = fcmp uno double %8, %5
  %265 = zext i1 %264 to i32
  %266 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 598, double %8, double %5, i32 %265) nounwind
  %267 = fcmp ueq double %8, %5
  %268 = zext i1 %267 to i32
  %269 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 599, double %8, double %5, i32 %268) nounwind
  %270 = fcmp une double %8, %5
  %271 = zext i1 %270 to i32
  %272 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 600, double %8, double %5, i32 %271) nounwind
  %273 = fcmp ugt double %8, %5
  %274 = zext i1 %273 to i32
  %275 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 601, double %8, double %5, i32 %274) nounwind
  %276 = fcmp uge double %8, %5
  %277 = zext i1 %276 to i32
  %278 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 602, double %8, double %5, i32 %277) nounwind
  %279 = fcmp ult double %8, %5
  %280 = zext i1 %279 to i32
  %281 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 603, double %8, double %5, i32 %280) nounwind
  %282 = fcmp ule double %8, %5
  %283 = zext i1 %282 to i32
  %284 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 604, double %8, double %5, i32 %283) nounwind
  %285 = fcmp uno double %8, %9
  %286 = zext i1 %285 to i32
  %287 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 605, double %8, double %9, i32 %286) nounwind
  %288 = fcmp ueq double %8, %9
  %289 = zext i1 %288 to i32
  %290 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 606, double %8, double %9, i32 %289) nounwind
  %291 = fcmp une double %8, %9
  %292 = zext i1 %291 to i32
  %293 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 607, double %8, double %9, i32 %292) nounwind
  %294 = fcmp ugt double %8, %9
  %295 = zext i1 %294 to i32
  %296 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 608, double %8, double %9, i32 %295) nounwind
  %297 = fcmp uge double %8, %9
  %298 = zext i1 %297 to i32
  %299 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 609, double %8, double %9, i32 %298) nounwind
  %300 = fcmp ult double %8, %9
  %301 = zext i1 %300 to i32
  %302 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 610, double %8, double %9, i32 %301) nounwind
  %303 = fcmp ule double %8, %9
  %304 = zext i1 %303 to i32
  %305 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 611, double %8, double %9, i32 %304) nounwind
  %306 = fcmp uno double %8, %10
  %307 = zext i1 %306 to i32
  %308 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 612, double %8, double %10, i32 %307) nounwind
  %309 = fcmp ueq double %8, %10
  %310 = zext i1 %309 to i32
  %311 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 613, double %8, double %10, i32 %310) nounwind
  %312 = fcmp une double %8, %10
  %313 = zext i1 %312 to i32
  %314 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 614, double %8, double %10, i32 %313) nounwind
  %315 = fcmp ugt double %8, %10
  %316 = zext i1 %315 to i32
  %317 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 615, double %8, double %10, i32 %316) nounwind
  %318 = fcmp uge double %8, %10
  %319 = zext i1 %318 to i32
  %320 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 616, double %8, double %10, i32 %319) nounwind
  %321 = fcmp ult double %8, %10
  %322 = zext i1 %321 to i32
  %323 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 617, double %8, double %10, i32 %322) nounwind
  %324 = fcmp ule double %8, %10
  %325 = zext i1 %324 to i32
  %326 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 618, double %8, double %10, i32 %325) nounwind
  %327 = fcmp uno double %8, %11
  %328 = zext i1 %327 to i32
  %329 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 619, double %8, double %11, i32 %328) nounwind
  %330 = fcmp ueq double %8, %11
  %331 = zext i1 %330 to i32
  %332 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 620, double %8, double %11, i32 %331) nounwind
  %333 = fcmp une double %8, %11
  %334 = zext i1 %333 to i32
  %335 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 621, double %8, double %11, i32 %334) nounwind
  %336 = fcmp ugt double %8, %11
  %337 = zext i1 %336 to i32
  %338 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 622, double %8, double %11, i32 %337) nounwind
  %339 = fcmp uge double %8, %11
  %340 = zext i1 %339 to i32
  %341 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 623, double %8, double %11, i32 %340) nounwind
  %342 = fcmp ult double %8, %11
  %343 = zext i1 %342 to i32
  %344 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 624, double %8, double %11, i32 %343) nounwind
  %345 = fcmp ule double %8, %11
  %346 = zext i1 %345 to i32
  %347 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 625, double %8, double %11, i32 %346) nounwind
  ret void
}

define void @funo1() nounwind {
entry:
  %0 = alloca double, align 8
  %1 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %0) nounwind
  %2 = load double* %0, align 8
  %3 = alloca double, align 8
  %4 = call i32 (i8*, ...)* @"\01__isoc99_scanf"(i8* noalias getelementptr inbounds ([4 x i8]* @scanf_double, i32 0, i32 0), double* %3) nounwind
  %5 = load double* %3, align 8
  %6 = load double* @nan, align 8
  %7 = load double* @pinf, align 8
  %8 = load double* @ninf, align 8
  %9 = load double* @nan, align 8
  %10 = load double* @pinf, align 8
  %11 = load double* @ninf, align 8
  %12 = fcmp uno double %2, %5
  %13 = zext i1 %12 to i32
  %14 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 626, double %2, double %5, i32 %13) nounwind
  %15 = fcmp ueq double %2, %5
  %16 = zext i1 %15 to i32
  %17 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 627, double %2, double %5, i32 %16) nounwind
  %18 = fcmp une double %2, %5
  %19 = zext i1 %18 to i32
  %20 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 628, double %2, double %5, i32 %19) nounwind
  %21 = fcmp ugt double %2, %5
  %22 = zext i1 %21 to i32
  %23 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 629, double %2, double %5, i32 %22) nounwind
  %24 = fcmp uge double %2, %5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 630, double %2, double %5, i32 %25) nounwind
  %27 = fcmp ult double %2, %5
  %28 = zext i1 %27 to i32
  %29 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 631, double %2, double %5, i32 %28) nounwind
  %30 = fcmp ule double %2, %5
  %31 = zext i1 %30 to i32
  %32 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 632, double %2, double %5, i32 %31) nounwind
  %33 = fcmp uno double %2, %9
  %34 = zext i1 %33 to i32
  %35 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 633, double %2, double %9, i32 %34) nounwind
  %36 = fcmp ueq double %2, %9
  %37 = zext i1 %36 to i32
  %38 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 634, double %2, double %9, i32 %37) nounwind
  %39 = fcmp une double %2, %9
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 635, double %2, double %9, i32 %40) nounwind
  %42 = fcmp ugt double %2, %9
  %43 = zext i1 %42 to i32
  %44 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 636, double %2, double %9, i32 %43) nounwind
  %45 = fcmp uge double %2, %9
  %46 = zext i1 %45 to i32
  %47 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 637, double %2, double %9, i32 %46) nounwind
  %48 = fcmp ult double %2, %9
  %49 = zext i1 %48 to i32
  %50 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 638, double %2, double %9, i32 %49) nounwind
  %51 = fcmp ule double %2, %9
  %52 = zext i1 %51 to i32
  %53 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 639, double %2, double %9, i32 %52) nounwind
  %54 = fcmp uno double %2, %10
  %55 = zext i1 %54 to i32
  %56 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 640, double %2, double %10, i32 %55) nounwind
  %57 = fcmp ueq double %2, %10
  %58 = zext i1 %57 to i32
  %59 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 641, double %2, double %10, i32 %58) nounwind
  %60 = fcmp une double %2, %10
  %61 = zext i1 %60 to i32
  %62 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 642, double %2, double %10, i32 %61) nounwind
  %63 = fcmp ugt double %2, %10
  %64 = zext i1 %63 to i32
  %65 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 643, double %2, double %10, i32 %64) nounwind
  %66 = fcmp uge double %2, %10
  %67 = zext i1 %66 to i32
  %68 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 644, double %2, double %10, i32 %67) nounwind
  %69 = fcmp ult double %2, %10
  %70 = zext i1 %69 to i32
  %71 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 645, double %2, double %10, i32 %70) nounwind
  %72 = fcmp ule double %2, %10
  %73 = zext i1 %72 to i32
  %74 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 646, double %2, double %10, i32 %73) nounwind
  %75 = fcmp uno double %2, %11
  %76 = zext i1 %75 to i32
  %77 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 647, double %2, double %11, i32 %76) nounwind
  %78 = fcmp ueq double %2, %11
  %79 = zext i1 %78 to i32
  %80 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 648, double %2, double %11, i32 %79) nounwind
  %81 = fcmp une double %2, %11
  %82 = zext i1 %81 to i32
  %83 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 649, double %2, double %11, i32 %82) nounwind
  %84 = fcmp ugt double %2, %11
  %85 = zext i1 %84 to i32
  %86 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 650, double %2, double %11, i32 %85) nounwind
  %87 = fcmp uge double %2, %11
  %88 = zext i1 %87 to i32
  %89 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 651, double %2, double %11, i32 %88) nounwind
  %90 = fcmp ult double %2, %11
  %91 = zext i1 %90 to i32
  %92 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 652, double %2, double %11, i32 %91) nounwind
  %93 = fcmp ule double %2, %11
  %94 = zext i1 %93 to i32
  %95 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 653, double %2, double %11, i32 %94) nounwind
  %96 = fcmp uno double %6, %5
  %97 = zext i1 %96 to i32
  %98 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 654, double %6, double %5, i32 %97) nounwind
  %99 = fcmp ueq double %6, %5
  %100 = zext i1 %99 to i32
  %101 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 655, double %6, double %5, i32 %100) nounwind
  %102 = fcmp une double %6, %5
  %103 = zext i1 %102 to i32
  %104 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 656, double %6, double %5, i32 %103) nounwind
  %105 = fcmp ugt double %6, %5
  %106 = zext i1 %105 to i32
  %107 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 657, double %6, double %5, i32 %106) nounwind
  %108 = fcmp uge double %6, %5
  %109 = zext i1 %108 to i32
  %110 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 658, double %6, double %5, i32 %109) nounwind
  %111 = fcmp ult double %6, %5
  %112 = zext i1 %111 to i32
  %113 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 659, double %6, double %5, i32 %112) nounwind
  %114 = fcmp ule double %6, %5
  %115 = zext i1 %114 to i32
  %116 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 660, double %6, double %5, i32 %115) nounwind
  %117 = fcmp uno double %6, %9
  %118 = zext i1 %117 to i32
  %119 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 661, double %6, double %9, i32 %118) nounwind
  %120 = fcmp ueq double %6, %9
  %121 = zext i1 %120 to i32
  %122 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 662, double %6, double %9, i32 %121) nounwind
  %123 = fcmp une double %6, %9
  %124 = zext i1 %123 to i32
  %125 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 663, double %6, double %9, i32 %124) nounwind
  %126 = fcmp ugt double %6, %9
  %127 = zext i1 %126 to i32
  %128 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 664, double %6, double %9, i32 %127) nounwind
  %129 = fcmp uge double %6, %9
  %130 = zext i1 %129 to i32
  %131 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 665, double %6, double %9, i32 %130) nounwind
  %132 = fcmp ult double %6, %9
  %133 = zext i1 %132 to i32
  %134 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 666, double %6, double %9, i32 %133) nounwind
  %135 = fcmp ule double %6, %9
  %136 = zext i1 %135 to i32
  %137 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 667, double %6, double %9, i32 %136) nounwind
  %138 = fcmp uno double %6, %10
  %139 = zext i1 %138 to i32
  %140 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 668, double %6, double %10, i32 %139) nounwind
  %141 = fcmp ueq double %6, %10
  %142 = zext i1 %141 to i32
  %143 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 669, double %6, double %10, i32 %142) nounwind
  %144 = fcmp une double %6, %10
  %145 = zext i1 %144 to i32
  %146 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 670, double %6, double %10, i32 %145) nounwind
  %147 = fcmp ugt double %6, %10
  %148 = zext i1 %147 to i32
  %149 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 671, double %6, double %10, i32 %148) nounwind
  %150 = fcmp uge double %6, %10
  %151 = zext i1 %150 to i32
  %152 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 672, double %6, double %10, i32 %151) nounwind
  %153 = fcmp ult double %6, %10
  %154 = zext i1 %153 to i32
  %155 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 673, double %6, double %10, i32 %154) nounwind
  %156 = fcmp ule double %6, %10
  %157 = zext i1 %156 to i32
  %158 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 674, double %6, double %10, i32 %157) nounwind
  %159 = fcmp uno double %6, %11
  %160 = zext i1 %159 to i32
  %161 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 675, double %6, double %11, i32 %160) nounwind
  %162 = fcmp ueq double %6, %11
  %163 = zext i1 %162 to i32
  %164 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 676, double %6, double %11, i32 %163) nounwind
  %165 = fcmp une double %6, %11
  %166 = zext i1 %165 to i32
  %167 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 677, double %6, double %11, i32 %166) nounwind
  %168 = fcmp ugt double %6, %11
  %169 = zext i1 %168 to i32
  %170 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 678, double %6, double %11, i32 %169) nounwind
  %171 = fcmp uge double %6, %11
  %172 = zext i1 %171 to i32
  %173 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 679, double %6, double %11, i32 %172) nounwind
  %174 = fcmp ult double %6, %11
  %175 = zext i1 %174 to i32
  %176 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 680, double %6, double %11, i32 %175) nounwind
  %177 = fcmp ule double %6, %11
  %178 = zext i1 %177 to i32
  %179 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 681, double %6, double %11, i32 %178) nounwind
  %180 = fcmp uno double %7, %5
  %181 = zext i1 %180 to i32
  %182 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 682, double %7, double %5, i32 %181) nounwind
  %183 = fcmp ueq double %7, %5
  %184 = zext i1 %183 to i32
  %185 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 683, double %7, double %5, i32 %184) nounwind
  %186 = fcmp une double %7, %5
  %187 = zext i1 %186 to i32
  %188 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 684, double %7, double %5, i32 %187) nounwind
  %189 = fcmp ugt double %7, %5
  %190 = zext i1 %189 to i32
  %191 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 685, double %7, double %5, i32 %190) nounwind
  %192 = fcmp uge double %7, %5
  %193 = zext i1 %192 to i32
  %194 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 686, double %7, double %5, i32 %193) nounwind
  %195 = fcmp ult double %7, %5
  %196 = zext i1 %195 to i32
  %197 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 687, double %7, double %5, i32 %196) nounwind
  %198 = fcmp ule double %7, %5
  %199 = zext i1 %198 to i32
  %200 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 688, double %7, double %5, i32 %199) nounwind
  %201 = fcmp uno double %7, %9
  %202 = zext i1 %201 to i32
  %203 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 689, double %7, double %9, i32 %202) nounwind
  %204 = fcmp ueq double %7, %9
  %205 = zext i1 %204 to i32
  %206 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 690, double %7, double %9, i32 %205) nounwind
  %207 = fcmp une double %7, %9
  %208 = zext i1 %207 to i32
  %209 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 691, double %7, double %9, i32 %208) nounwind
  %210 = fcmp ugt double %7, %9
  %211 = zext i1 %210 to i32
  %212 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 692, double %7, double %9, i32 %211) nounwind
  %213 = fcmp uge double %7, %9
  %214 = zext i1 %213 to i32
  %215 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 693, double %7, double %9, i32 %214) nounwind
  %216 = fcmp ult double %7, %9
  %217 = zext i1 %216 to i32
  %218 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 694, double %7, double %9, i32 %217) nounwind
  %219 = fcmp ule double %7, %9
  %220 = zext i1 %219 to i32
  %221 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 695, double %7, double %9, i32 %220) nounwind
  %222 = fcmp uno double %7, %10
  %223 = zext i1 %222 to i32
  %224 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 696, double %7, double %10, i32 %223) nounwind
  %225 = fcmp ueq double %7, %10
  %226 = zext i1 %225 to i32
  %227 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 697, double %7, double %10, i32 %226) nounwind
  %228 = fcmp une double %7, %10
  %229 = zext i1 %228 to i32
  %230 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 698, double %7, double %10, i32 %229) nounwind
  %231 = fcmp ugt double %7, %10
  %232 = zext i1 %231 to i32
  %233 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 699, double %7, double %10, i32 %232) nounwind
  %234 = fcmp uge double %7, %10
  %235 = zext i1 %234 to i32
  %236 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 700, double %7, double %10, i32 %235) nounwind
  %237 = fcmp ult double %7, %10
  %238 = zext i1 %237 to i32
  %239 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 701, double %7, double %10, i32 %238) nounwind
  %240 = fcmp ule double %7, %10
  %241 = zext i1 %240 to i32
  %242 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 702, double %7, double %10, i32 %241) nounwind
  %243 = fcmp uno double %7, %11
  %244 = zext i1 %243 to i32
  %245 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 703, double %7, double %11, i32 %244) nounwind
  %246 = fcmp ueq double %7, %11
  %247 = zext i1 %246 to i32
  %248 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 704, double %7, double %11, i32 %247) nounwind
  %249 = fcmp une double %7, %11
  %250 = zext i1 %249 to i32
  %251 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 705, double %7, double %11, i32 %250) nounwind
  %252 = fcmp ugt double %7, %11
  %253 = zext i1 %252 to i32
  %254 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 706, double %7, double %11, i32 %253) nounwind
  %255 = fcmp uge double %7, %11
  %256 = zext i1 %255 to i32
  %257 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 707, double %7, double %11, i32 %256) nounwind
  %258 = fcmp ult double %7, %11
  %259 = zext i1 %258 to i32
  %260 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 708, double %7, double %11, i32 %259) nounwind
  %261 = fcmp ule double %7, %11
  %262 = zext i1 %261 to i32
  %263 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 709, double %7, double %11, i32 %262) nounwind
  %264 = fcmp uno double %8, %5
  %265 = zext i1 %264 to i32
  %266 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 710, double %8, double %5, i32 %265) nounwind
  %267 = fcmp ueq double %8, %5
  %268 = zext i1 %267 to i32
  %269 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 711, double %8, double %5, i32 %268) nounwind
  %270 = fcmp une double %8, %5
  %271 = zext i1 %270 to i32
  %272 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 712, double %8, double %5, i32 %271) nounwind
  %273 = fcmp ugt double %8, %5
  %274 = zext i1 %273 to i32
  %275 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 713, double %8, double %5, i32 %274) nounwind
  %276 = fcmp uge double %8, %5
  %277 = zext i1 %276 to i32
  %278 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 714, double %8, double %5, i32 %277) nounwind
  %279 = fcmp ult double %8, %5
  %280 = zext i1 %279 to i32
  %281 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 715, double %8, double %5, i32 %280) nounwind
  %282 = fcmp ule double %8, %5
  %283 = zext i1 %282 to i32
  %284 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 716, double %8, double %5, i32 %283) nounwind
  %285 = fcmp uno double %8, %9
  %286 = zext i1 %285 to i32
  %287 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 717, double %8, double %9, i32 %286) nounwind
  %288 = fcmp ueq double %8, %9
  %289 = zext i1 %288 to i32
  %290 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 718, double %8, double %9, i32 %289) nounwind
  %291 = fcmp une double %8, %9
  %292 = zext i1 %291 to i32
  %293 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 719, double %8, double %9, i32 %292) nounwind
  %294 = fcmp ugt double %8, %9
  %295 = zext i1 %294 to i32
  %296 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 720, double %8, double %9, i32 %295) nounwind
  %297 = fcmp uge double %8, %9
  %298 = zext i1 %297 to i32
  %299 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 721, double %8, double %9, i32 %298) nounwind
  %300 = fcmp ult double %8, %9
  %301 = zext i1 %300 to i32
  %302 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 722, double %8, double %9, i32 %301) nounwind
  %303 = fcmp ule double %8, %9
  %304 = zext i1 %303 to i32
  %305 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 723, double %8, double %9, i32 %304) nounwind
  %306 = fcmp uno double %8, %10
  %307 = zext i1 %306 to i32
  %308 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 724, double %8, double %10, i32 %307) nounwind
  %309 = fcmp ueq double %8, %10
  %310 = zext i1 %309 to i32
  %311 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 725, double %8, double %10, i32 %310) nounwind
  %312 = fcmp une double %8, %10
  %313 = zext i1 %312 to i32
  %314 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 726, double %8, double %10, i32 %313) nounwind
  %315 = fcmp ugt double %8, %10
  %316 = zext i1 %315 to i32
  %317 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 727, double %8, double %10, i32 %316) nounwind
  %318 = fcmp uge double %8, %10
  %319 = zext i1 %318 to i32
  %320 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 728, double %8, double %10, i32 %319) nounwind
  %321 = fcmp ult double %8, %10
  %322 = zext i1 %321 to i32
  %323 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 729, double %8, double %10, i32 %322) nounwind
  %324 = fcmp ule double %8, %10
  %325 = zext i1 %324 to i32
  %326 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 730, double %8, double %10, i32 %325) nounwind
  %327 = fcmp uno double %8, %11
  %328 = zext i1 %327 to i32
  %329 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_funo, i32 0, i32 0), i32 731, double %8, double %11, i32 %328) nounwind
  %330 = fcmp ueq double %8, %11
  %331 = zext i1 %330 to i32
  %332 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fueq, i32 0, i32 0), i32 732, double %8, double %11, i32 %331) nounwind
  %333 = fcmp une double %8, %11
  %334 = zext i1 %333 to i32
  %335 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fune, i32 0, i32 0), i32 733, double %8, double %11, i32 %334) nounwind
  %336 = fcmp ugt double %8, %11
  %337 = zext i1 %336 to i32
  %338 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fugt, i32 0, i32 0), i32 734, double %8, double %11, i32 %337) nounwind
  %339 = fcmp uge double %8, %11
  %340 = zext i1 %339 to i32
  %341 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fuge, i32 0, i32 0), i32 735, double %8, double %11, i32 %340) nounwind
  %342 = fcmp ult double %8, %11
  %343 = zext i1 %342 to i32
  %344 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fult, i32 0, i32 0), i32 736, double %8, double %11, i32 %343) nounwind
  %345 = fcmp ule double %8, %11
  %346 = zext i1 %345 to i32
  %347 = call i32 (i8*, ...)* @printf(i8* noalias getelementptr inbounds ([24 x i8]* @printf_fule, i32 0, i32 0), i32 737, double %8, double %11, i32 %346) nounwind
  ret void
}

define void @floatTest() nounwind {
entry:
  call void @feq0() nounwind
  call void @feq1() nounwind
  call void @feq2() nounwind
  call void @feq3() nounwind
  call void @feq4() nounwind
  call void @fne0() nounwind
  call void @fne1() nounwind
  call void @fne2() nounwind
  call void @fne3() nounwind
  call void @fne4() nounwind
  call void @flt0() nounwind
  call void @flt1() nounwind
  call void @flt2() nounwind
  call void @flt3() nounwind
  call void @flt4() nounwind
  call void @fle0() nounwind
  call void @fle1() nounwind
  call void @fle2() nounwind
  call void @fle3() nounwind
  call void @fle4() nounwind
  call void @fgt0() nounwind
  call void @fgt1() nounwind
  call void @fgt2() nounwind
  call void @fgt3() nounwind
  call void @fgt4() nounwind
  call void @fge0() nounwind
  call void @fge1() nounwind
  call void @fge2() nounwind
  call void @fge3() nounwind
  call void @fge4() nounwind
  call void @ford0() nounwind
  call void @ford1() nounwind
  call void @funo0() nounwind
  call void @funo1() nounwind
  ret void
}

define i32 @main() nounwind {
entry:
  call void @intTest() nounwind
  call void @floatTest() nounwind
  ret i32 0
}

