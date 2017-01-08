; ModuleID = 'cc_hello.cpp'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128"
target triple = "x86_64-unknown-linux-gnu"

%0 = type { i32, void ()* }
%struct..0__pthread_mutex_s = type { i32, i32, i32, i32, i32, i32, %struct.__pthread_list_t }
%struct.__pthread_list_t = type { %struct.__pthread_list_t*, %struct.__pthread_list_t* }
%struct.pthread_attr_t = type { i64, [48 x i8] }
%struct.pthread_mutex_t = type { %struct..0__pthread_mutex_s }
%struct.pthread_mutexattr_t = type { i32 }
%"struct.std::basic_ios<char,std::char_traits<char> >" = type { %"struct.std::ios_base", %"struct.std::basic_ostream<char,std::char_traits<char> >"*, i8, i8, %"struct.std::basic_streambuf<char,std::char_traits<char> >"*, %"struct.std::ctype<char>"*, %"struct.std::num_get<char,std::istreambuf_iterator<char, std::char_traits<char> > >"*, %"struct.std::num_get<char,std::istreambuf_iterator<char, std::char_traits<char> > >"* }
%"struct.std::basic_ostream<char,std::char_traits<char> >" = type { i32 (...)**, %"struct.std::basic_ios<char,std::char_traits<char> >" }
%"struct.std::basic_streambuf<char,std::char_traits<char> >" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"struct.std::locale" }
%"struct.std::ctype<char>" = type { %"struct.std::locale::facet", i32*, i8, i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8 }
%"struct.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"struct.std::locale" }
%"struct.std::ios_base::Init" = type <{ i8 }>
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"struct.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"struct.std::locale" = type { %"struct.std::locale::_Impl"* }
%"struct.std::locale::_Impl" = type { i32, %"struct.std::locale::facet"**, i64, %"struct.std::locale::facet"**, i8** }
%"struct.std::locale::facet" = type { i32 (...)**, i32 }
%"struct.std::num_get<char,std::istreambuf_iterator<char, std::char_traits<char> > >" = type { %"struct.std::locale::facet" }

@_ZStL8__ioinit = internal global %"struct.std::ios_base::Init" zeroinitializer ; <%"struct.std::ios_base::Init"*> [#uses=2]
@__dso_handle = external global i8*               ; <i8**> [#uses=1]
@_ZSt4cout = external global %"struct.std::basic_ostream<char,std::char_traits<char> >" ; <%"struct.std::basic_ostream<char,std::char_traits<char> >"*> [#uses=2]
@.str = private constant [13 x i8] c"Hello world!\00", align 1 ; <[13 x i8]*> [#uses=1]
@llvm.global_ctors = appending global [1 x %0] [%0 { i32 65535, void ()* @_GLOBAL__I_main }] ; <[1 x %0]*> [#uses=0]

@_ZL20__gthrw_pthread_oncePiPFvvE = alias weak i32 (i32*, void ()*)* @pthread_once ; <i32 (i32*, void ()*)*> [#uses=0]
@_ZL27__gthrw_pthread_getspecificj = alias weak i8* (i32)* @pthread_getspecific ; <i8* (i32)*> [#uses=0]
@_ZL27__gthrw_pthread_setspecificjPKv = alias weak i32 (i32, i8*)* @pthread_setspecific ; <i32 (i32, i8*)*> [#uses=0]
@_ZL22__gthrw_pthread_createPmPK14pthread_attr_tPFPvS3_ES3_ = alias weak i32 (i64*, %struct.pthread_attr_t*, i8* (i8*)*, i8*)* @pthread_create ; <i32 (i64*, %struct.pthread_attr_t*, i8* (i8*)*, i8*)*> [#uses=0]
@_ZL22__gthrw_pthread_cancelm = alias weak i32 (i64)* @pthread_cancel ; <i32 (i64)*> [#uses=0]
@_ZL26__gthrw_pthread_mutex_lockP15pthread_mutex_t = alias weak i32 (%struct.pthread_mutex_t*)* @pthread_mutex_lock ; <i32 (%struct.pthread_mutex_t*)*> [#uses=0]
@_ZL29__gthrw_pthread_mutex_trylockP15pthread_mutex_t = alias weak i32 (%struct.pthread_mutex_t*)* @pthread_mutex_trylock ; <i32 (%struct.pthread_mutex_t*)*> [#uses=0]
@_ZL28__gthrw_pthread_mutex_unlockP15pthread_mutex_t = alias weak i32 (%struct.pthread_mutex_t*)* @pthread_mutex_unlock ; <i32 (%struct.pthread_mutex_t*)*> [#uses=0]
@_ZL26__gthrw_pthread_mutex_initP15pthread_mutex_tPK19pthread_mutexattr_t = alias weak i32 (%struct.pthread_mutex_t*, %struct.pthread_mutexattr_t*)* @pthread_mutex_init ; <i32 (%struct.pthread_mutex_t*, %struct.pthread_mutexattr_t*)*> [#uses=0]
@_ZL26__gthrw_pthread_key_createPjPFvPvE = alias weak i32 (i32*, void (i8*)*)* @pthread_key_create ; <i32 (i32*, void (i8*)*)*> [#uses=0]
@_ZL26__gthrw_pthread_key_deletej = alias weak i32 (i32)* @pthread_key_delete ; <i32 (i32)*> [#uses=0]
@_ZL30__gthrw_pthread_mutexattr_initP19pthread_mutexattr_t = alias weak i32 (%struct.pthread_mutexattr_t*)* @pthread_mutexattr_init ; <i32 (%struct.pthread_mutexattr_t*)*> [#uses=0]
@_ZL33__gthrw_pthread_mutexattr_settypeP19pthread_mutexattr_ti = alias weak i32 (%struct.pthread_mutexattr_t*, i32)* @pthread_mutexattr_settype ; <i32 (%struct.pthread_mutexattr_t*, i32)*> [#uses=0]
@_ZL33__gthrw_pthread_mutexattr_destroyP19pthread_mutexattr_t = alias weak i32 (%struct.pthread_mutexattr_t*)* @pthread_mutexattr_destroy ; <i32 (%struct.pthread_mutexattr_t*)*> [#uses=0]

define i32 @main(i32 %argc, i8** nocapture %argv) {
entry:
  %0 = tail call %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZSt4cout, i8* getelementptr inbounds ([13 x i8]* @.str, i64 0, i64 0)) ; <%"struct.std::basic_ostream<char,std::char_traits<char> >"*> [#uses=0]
  %1 = tail call %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZNSolsEPFRSoS_E(%"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZSt4cout, %"struct.std::basic_ostream<char,std::char_traits<char> >"* (%"struct.std::basic_ostream<char,std::char_traits<char> >"*)* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_) ; <%"struct.std::basic_ostream<char,std::char_traits<char> >"*> [#uses=0]
  ret i32 0
}

define internal void @_GLOBAL__I_main() {
entry:
  tail call fastcc void @_Z41__static_initialization_and_destruction_0ii()
  ret void
}

define linkonce_odr i32 @_ZStorSt12_Ios_IostateS_(i32 %__a, i32 %__b) nounwind readnone {
entry:
  %0 = or i32 %__b, %__a                          ; <i32> [#uses=1]
  ret i32 %0
}

define available_externally %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZNSolsEPFRSoS_E(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %this, %"struct.std::basic_ostream<char,std::char_traits<char> >"* (%"struct.std::basic_ostream<char,std::char_traits<char> >"*)* nocapture %__pf) {
entry:
  %0 = tail call %"struct.std::basic_ostream<char,std::char_traits<char> >"* %__pf(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %this) ; <%"struct.std::basic_ostream<char,std::char_traits<char> >"*> [#uses=1]
  ret %"struct.std::basic_ostream<char,std::char_traits<char> >"* %0
}

define available_externally i32 @_ZNKSt9basic_iosIcSt11char_traitsIcEE7rdstateEv(%"struct.std::basic_ios<char,std::char_traits<char> >"* nocapture %this) nounwind readonly {
entry:
  %0 = getelementptr inbounds %"struct.std::basic_ios<char,std::char_traits<char> >"* %this, i64 0, i32 0, i32 5 ; <i32*> [#uses=1]
  %1 = load i32* %0, align 8                      ; <i32> [#uses=1]
  ret i32 %1
}

define internal fastcc void @_Z41__static_initialization_and_destruction_0ii() {
entry:
  tail call void @_ZNSt8ios_base4InitC1Ev(%"struct.std::ios_base::Init"* @_ZStL8__ioinit)
  %0 = tail call i32 @__cxa_atexit(void (i8*)* @__tcf_0, i8* null, i8* bitcast (i8** @__dso_handle to i8*)) nounwind ; <i32> [#uses=0]
  ret void
}

declare void @_ZNSt8ios_base4InitC1Ev(%"struct.std::ios_base::Init"*)

declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) nounwind

define internal void @__tcf_0(i8* nocapture %unnamed_arg) {
entry:
  tail call void @_ZNSt8ios_base4InitD1Ev(%"struct.std::ios_base::Init"* @_ZStL8__ioinit)
  ret void
}

declare void @_ZNSt8ios_base4InitD1Ev(%"struct.std::ios_base::Init"*)

define available_externally void @_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate(%"struct.std::basic_ios<char,std::char_traits<char> >"* %this, i32 %__state) {
entry:
  %0 = tail call i32 @_ZNKSt9basic_iosIcSt11char_traitsIcEE7rdstateEv(%"struct.std::basic_ios<char,std::char_traits<char> >"* %this) ; <i32> [#uses=1]
  %1 = tail call i32 @_ZStorSt12_Ios_IostateS_(i32 %0, i32 %__state) nounwind ; <i32> [#uses=1]
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"struct.std::basic_ios<char,std::char_traits<char> >"* %this, i32 %1)
  ret void
}

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"struct.std::basic_ios<char,std::char_traits<char> >"*, i32)

define linkonce_odr i64 @_ZNSt11char_traitsIcE6lengthEPKc(i8* nocapture %__s) nounwind readonly {
entry:
  %0 = tail call i64 @strlen(i8* %__s) nounwind readonly ; <i64> [#uses=1]
  ret i64 %0
}

declare i64 @strlen(i8* nocapture) nounwind readonly

define available_externally %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %__out, i8* %__s) {
entry:
  %0 = icmp eq i8* %__s, null                     ; <i1> [#uses=1]
  br i1 %0, label %bb, label %bb1

bb:                                               ; preds = %entry
  %1 = getelementptr inbounds %"struct.std::basic_ostream<char,std::char_traits<char> >"* %__out, i64 0, i32 0 ; <i32 (...)***> [#uses=1]
  %2 = load i32 (...)*** %1, align 8              ; <i32 (...)**> [#uses=1]
  %3 = getelementptr inbounds i32 (...)** %2, i64 -3 ; <i32 (...)**> [#uses=1]
  %4 = bitcast i32 (...)** %3 to i64*             ; <i64*> [#uses=1]
  %5 = load i64* %4, align 8                      ; <i64> [#uses=1]
  %6 = ptrtoint %"struct.std::basic_ostream<char,std::char_traits<char> >"* %__out to i64 ; <i64> [#uses=1]
  %7 = add i64 %5, %6                             ; <i64> [#uses=1]
  %8 = inttoptr i64 %7 to %"struct.std::basic_ios<char,std::char_traits<char> >"* ; <%"struct.std::basic_ios<char,std::char_traits<char> >"*> [#uses=1]
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate(%"struct.std::basic_ios<char,std::char_traits<char> >"* %8, i32 1)
  ret %"struct.std::basic_ostream<char,std::char_traits<char> >"* %__out

bb1:                                              ; preds = %entry
  %9 = tail call i64 @_ZNSt11char_traitsIcE6lengthEPKc(i8* %__s) nounwind ; <i64> [#uses=1]
  %10 = tail call %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %__out, i8* %__s, i64 %9) ; <%"struct.std::basic_ostream<char,std::char_traits<char> >"*> [#uses=0]
  ret %"struct.std::basic_ostream<char,std::char_traits<char> >"* %__out
}

declare %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"struct.std::basic_ostream<char,std::char_traits<char> >"*, i8*, i64)

define available_externally %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %__os) {
entry:
  %0 = getelementptr inbounds %"struct.std::basic_ostream<char,std::char_traits<char> >"* %__os, i64 0, i32 0 ; <i32 (...)***> [#uses=1]
  %1 = load i32 (...)*** %0, align 8              ; <i32 (...)**> [#uses=1]
  %2 = getelementptr inbounds i32 (...)** %1, i64 -3 ; <i32 (...)**> [#uses=1]
  %3 = bitcast i32 (...)** %2 to i64*             ; <i64*> [#uses=1]
  %4 = load i64* %3, align 8                      ; <i64> [#uses=1]
  %5 = ptrtoint %"struct.std::basic_ostream<char,std::char_traits<char> >"* %__os to i64 ; <i64> [#uses=1]
  %6 = add i64 %4, %5                             ; <i64> [#uses=1]
  %7 = inttoptr i64 %6 to %"struct.std::basic_ios<char,std::char_traits<char> >"* ; <%"struct.std::basic_ios<char,std::char_traits<char> >"*> [#uses=1]
  %8 = tail call signext i8 @_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc(%"struct.std::basic_ios<char,std::char_traits<char> >"* %7, i8 signext 10) ; <i8> [#uses=1]
  %9 = tail call %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZNSo3putEc(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %__os, i8 signext %8) ; <%"struct.std::basic_ostream<char,std::char_traits<char> >"*> [#uses=1]
  %10 = tail call %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZSt5flushIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %9) ; <%"struct.std::basic_ostream<char,std::char_traits<char> >"*> [#uses=1]
  ret %"struct.std::basic_ostream<char,std::char_traits<char> >"* %10
}

define available_externally %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZSt5flushIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %__os) {
entry:
  %0 = tail call %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZNSo5flushEv(%"struct.std::basic_ostream<char,std::char_traits<char> >"* %__os) ; <%"struct.std::basic_ostream<char,std::char_traits<char> >"*> [#uses=1]
  ret %"struct.std::basic_ostream<char,std::char_traits<char> >"* %0
}

declare %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZNSo5flushEv(%"struct.std::basic_ostream<char,std::char_traits<char> >"*)

declare signext i8 @_ZNKSt9basic_iosIcSt11char_traitsIcEE5widenEc(%"struct.std::basic_ios<char,std::char_traits<char> >"*, i8 signext)

declare %"struct.std::basic_ostream<char,std::char_traits<char> >"* @_ZNSo3putEc(%"struct.std::basic_ostream<char,std::char_traits<char> >"*, i8 signext)

declare extern_weak i32 @pthread_once(i32*, void ()*)

declare extern_weak i8* @pthread_getspecific(i32)

declare extern_weak i32 @pthread_setspecific(i32, i8*)

declare extern_weak i32 @pthread_create(i64*, %struct.pthread_attr_t*, i8* (i8*)*, i8*)

declare extern_weak i32 @pthread_cancel(i64)

declare extern_weak i32 @pthread_mutex_lock(%struct.pthread_mutex_t*)

declare extern_weak i32 @pthread_mutex_trylock(%struct.pthread_mutex_t*)

declare extern_weak i32 @pthread_mutex_unlock(%struct.pthread_mutex_t*)

declare extern_weak i32 @pthread_mutex_init(%struct.pthread_mutex_t*, %struct.pthread_mutexattr_t*)

declare extern_weak i32 @pthread_key_create(i32*, void (i8*)*)

declare extern_weak i32 @pthread_key_delete(i32)

declare extern_weak i32 @pthread_mutexattr_init(%struct.pthread_mutexattr_t*)

declare extern_weak i32 @pthread_mutexattr_settype(%struct.pthread_mutexattr_t*, i32)

declare extern_weak i32 @pthread_mutexattr_destroy(%struct.pthread_mutexattr_t*)
