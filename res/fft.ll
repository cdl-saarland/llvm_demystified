; ModuleID = 'fft.cpp'
source_filename = "fft.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::basic_ostream" = type { ptr, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", ptr, i8, i8, ptr, ptr, ptr, ptr }
%"class.std::ios_base" = type { ptr, i64, i64, i32, i32, i32, ptr, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, ptr, %"class.std::locale" }
%"struct.std::ios_base::_Words" = type { ptr, i64 }
%"class.std::locale" = type { ptr }
%"class.std::basic_istream" = type { ptr, i64, %"class.std::basic_ios" }
%"class.std::complex" = type { { double, double } }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], ptr, i8, [7 x i8], ptr, ptr, ptr, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ ptr, i32 }>

$_ZSt3powIdESt7complexIT_ERKS2_i = comdat any

@_ZSt4cout = external global %"class.std::basic_ostream", align 8
@.str = private unnamed_addr constant [45 x i8] c"specify array dimension (MUST be power of 2)\00", align 1
@_ZSt3cin = external global %"class.std::basic_istream", align 8
@.str.1 = private unnamed_addr constant [22 x i8] c"specify sampling step\00", align 1
@.str.2 = private unnamed_addr constant [18 x i8] c"specify the array\00", align 1
@.str.3 = private unnamed_addr constant [25 x i8] c"specify element number: \00", align 1
@.str.4 = private unnamed_addr constant [43 x i8] c"...printing the FFT of the array specified\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i32 @_Z4log2i(i32 noundef %N) local_unnamed_addr #0 {
entry:
  %tobool.not3 = icmp eq i32 %N, 0
  br i1 %tobool.not3, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %while.body
  %i.05 = phi i32 [ %inc, %while.body ], [ 0, %entry ]
  %k.04 = phi i32 [ %shr, %while.body ], [ %N, %entry ]
  %shr = ashr i32 %k.04, 1
  %inc = add nuw nsw i32 %i.05, 1
  %tobool.not = icmp ult i32 %k.04, 2
  br i1 %tobool.not, label %while.end, label %while.body, !llvm.loop !5

while.end:                                        ; preds = %while.body, %entry
  %i.0.lcssa = phi i32 [ -1, %entry ], [ %i.05, %while.body ]
  ret i32 %i.0.lcssa
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i32 @_Z5checki(i32 noundef %n) local_unnamed_addr #2 {
entry:
  %cmp = icmp sgt i32 %n, 0
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  %0 = tail call i32 @llvm.ctpop.i32(i32 %n), !range !7
  %cmp1 = icmp ult i32 %0, 2
  %1 = zext i1 %cmp1 to i32
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %conv = phi i32 [ 0, %entry ], [ %1, %land.rhs ]
  ret i32 %conv
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i32 @_Z7reverseii(i32 noundef %N, i32 noundef %n) local_unnamed_addr #0 {
entry:
  %tobool.not3.i = icmp eq i32 %N, 0
  br i1 %tobool.not3.i, label %for.end, label %while.body.i.preheader

while.body.i.preheader:                           ; preds = %entry, %_Z4log2i.exit17
  %p.021 = phi i32 [ %p.1, %_Z4log2i.exit17 ], [ 0, %entry ]
  %j.020 = phi i32 [ %inc, %_Z4log2i.exit17 ], [ 1, %entry ]
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i.preheader, %while.body.i
  %i.05.i = phi i32 [ %inc.i, %while.body.i ], [ 0, %while.body.i.preheader ]
  %k.04.i = phi i32 [ %shr.i, %while.body.i ], [ %N, %while.body.i.preheader ]
  %shr.i = ashr i32 %k.04.i, 1
  %inc.i = add nuw nsw i32 %i.05.i, 1
  %tobool.not.i = icmp ult i32 %k.04.i, 2
  br i1 %tobool.not.i, label %_Z4log2i.exit, label %while.body.i, !llvm.loop !5

_Z4log2i.exit:                                    ; preds = %while.body.i
  %cmp.not = icmp ugt i32 %j.020, %i.05.i
  br i1 %cmp.not, label %for.end, label %while.body.i15

while.body.i15:                                   ; preds = %_Z4log2i.exit, %while.body.i15
  %i.05.i10 = phi i32 [ %inc.i13, %while.body.i15 ], [ 0, %_Z4log2i.exit ]
  %k.04.i11 = phi i32 [ %shr.i12, %while.body.i15 ], [ %N, %_Z4log2i.exit ]
  %shr.i12 = ashr i32 %k.04.i11, 1
  %inc.i13 = add nuw nsw i32 %i.05.i10, 1
  %tobool.not.i14 = icmp ult i32 %k.04.i11, 2
  br i1 %tobool.not.i14, label %_Z4log2i.exit17, label %while.body.i15, !llvm.loop !5

_Z4log2i.exit17:                                  ; preds = %while.body.i15
  %sub = sub nsw i32 %i.05.i10, %j.020
  %shl = shl nuw i32 1, %sub
  %and = and i32 %shl, %n
  %tobool.not = icmp eq i32 %and, 0
  %sub2 = add nsw i32 %j.020, -1
  %shl3 = shl nuw i32 1, %sub2
  %or = select i1 %tobool.not, i32 0, i32 %shl3
  %p.1 = or i32 %or, %p.021
  %inc = add nuw nsw i32 %j.020, 1
  br label %while.body.i.preheader

for.end:                                          ; preds = %_Z4log2i.exit, %entry
  %p.0.lcssa = phi i32 [ 0, %entry ], [ %p.021, %_Z4log2i.exit ]
  ret i32 %p.0.lcssa
}

; Function Attrs: nofree nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @_Z6ordinaPSt7complexIdEi(ptr nocapture noundef %f1, i32 noundef %N) local_unnamed_addr #3 {
entry:
  %f2 = alloca [200 x %"class.std::complex"], align 16
  call void @llvm.lifetime.start.p0(i64 3200, ptr nonnull %f2) #16
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(3200) %f2, i8 0, i64 3200, i1 false)
  %cmp23 = icmp sgt i32 %N, 0
  br i1 %cmp23, label %for.body.lr.ph, label %for.cond.cleanup5

for.body.lr.ph:                                   ; preds = %entry
  %wide.trip.count = zext i32 %N to i64
  br label %while.body.i.preheader.i.preheader

for.cond3.preheader:                              ; preds = %_Z7reverseii.exit
  br i1 %cmp23, label %for.body6.preheader, label %for.cond.cleanup5

for.body6.preheader:                              ; preds = %for.cond3.preheader
  %0 = zext i32 %N to i64
  %1 = shl nuw nsw i64 %0, 4
  call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 8 %f1, ptr nonnull align 16 %f2, i64 %1, i1 false)
  br label %for.cond.cleanup5

while.body.i.preheader.i.preheader:               ; preds = %_Z7reverseii.exit, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %_Z7reverseii.exit ]
  %2 = trunc i64 %indvars.iv to i32
  br label %while.body.i.preheader.i

while.body.i.preheader.i:                         ; preds = %while.body.i.preheader.i.preheader, %_Z4log2i.exit17.i
  %p.021.i = phi i32 [ %p.1.i, %_Z4log2i.exit17.i ], [ 0, %while.body.i.preheader.i.preheader ]
  %j.020.i = phi i32 [ %inc.i, %_Z4log2i.exit17.i ], [ 1, %while.body.i.preheader.i.preheader ]
  br label %while.body.i.i

while.body.i.i:                                   ; preds = %while.body.i.i, %while.body.i.preheader.i
  %i.05.i.i = phi i32 [ %inc.i.i, %while.body.i.i ], [ 0, %while.body.i.preheader.i ]
  %k.04.i.i = phi i32 [ %shr.i.i, %while.body.i.i ], [ %N, %while.body.i.preheader.i ]
  %shr.i.i = ashr i32 %k.04.i.i, 1
  %inc.i.i = add nuw nsw i32 %i.05.i.i, 1
  %tobool.not.i.i = icmp ult i32 %k.04.i.i, 2
  br i1 %tobool.not.i.i, label %_Z4log2i.exit.i, label %while.body.i.i, !llvm.loop !5

_Z4log2i.exit.i:                                  ; preds = %while.body.i.i
  %cmp.not.i = icmp ugt i32 %j.020.i, %i.05.i.i
  br i1 %cmp.not.i, label %_Z7reverseii.exit, label %while.body.i15.i

while.body.i15.i:                                 ; preds = %_Z4log2i.exit.i, %while.body.i15.i
  %i.05.i10.i = phi i32 [ %inc.i13.i, %while.body.i15.i ], [ 0, %_Z4log2i.exit.i ]
  %k.04.i11.i = phi i32 [ %shr.i12.i, %while.body.i15.i ], [ %N, %_Z4log2i.exit.i ]
  %shr.i12.i = ashr i32 %k.04.i11.i, 1
  %inc.i13.i = add nuw nsw i32 %i.05.i10.i, 1
  %tobool.not.i14.i = icmp ult i32 %k.04.i11.i, 2
  br i1 %tobool.not.i14.i, label %_Z4log2i.exit17.i, label %while.body.i15.i, !llvm.loop !5

_Z4log2i.exit17.i:                                ; preds = %while.body.i15.i
  %sub.i = sub nsw i32 %i.05.i10.i, %j.020.i
  %shl.i = shl nuw i32 1, %sub.i
  %and.i = and i32 %shl.i, %2
  %tobool.not.i = icmp eq i32 %and.i, 0
  %sub2.i = add nsw i32 %j.020.i, -1
  %shl3.i = shl nuw i32 1, %sub2.i
  %or.i = select i1 %tobool.not.i, i32 0, i32 %shl3.i
  %p.1.i = or i32 %or.i, %p.021.i
  %inc.i = add nuw nsw i32 %j.020.i, 1
  br label %while.body.i.preheader.i

_Z7reverseii.exit:                                ; preds = %_Z4log2i.exit.i
  %idxprom = sext i32 %p.021.i to i64
  %arrayidx = getelementptr inbounds %"class.std::complex", ptr %f1, i64 %idxprom
  %arrayidx2 = getelementptr inbounds [200 x %"class.std::complex"], ptr %f2, i64 0, i64 %indvars.iv
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %arrayidx2, ptr noundef nonnull align 8 dereferenceable(16) %arrayidx, i64 16, i1 false), !tbaa.struct !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond3.preheader, label %while.body.i.preheader.i.preheader, !llvm.loop !12

for.cond.cleanup5:                                ; preds = %entry, %for.body6.preheader, %for.cond3.preheader
  call void @llvm.lifetime.end.p0(i64 3200, ptr nonnull %f2) #16
  ret void
}

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: uwtable
define dso_local void @_Z9transformPSt7complexIdEi(ptr nocapture noundef %f, i32 noundef %N) local_unnamed_addr #5 {
entry:
  %f2.i = alloca [200 x %"class.std::complex"], align 16
  call void @llvm.lifetime.start.p0(i64 3200, ptr nonnull %f2.i) #16
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(3200) %f2.i, i8 0, i64 3200, i1 false)
  %cmp23.i = icmp sgt i32 %N, 0
  br i1 %cmp23.i, label %for.body.lr.ph.i, label %_Z6ordinaPSt7complexIdEi.exit

for.body.lr.ph.i:                                 ; preds = %entry
  %wide.trip.count.i = zext i32 %N to i64
  br label %while.body.i.preheader.i.preheader.i

for.body6.preheader.i:                            ; preds = %_Z7reverseii.exit.i
  %0 = shl nuw nsw i64 %wide.trip.count.i, 4
  call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 8 %f, ptr nonnull align 16 %f2.i, i64 %0, i1 false)
  br label %_Z6ordinaPSt7complexIdEi.exit

while.body.i.preheader.i.preheader.i:             ; preds = %_Z7reverseii.exit.i, %for.body.lr.ph.i
  %indvars.iv.i = phi i64 [ 0, %for.body.lr.ph.i ], [ %indvars.iv.next.i, %_Z7reverseii.exit.i ]
  %1 = trunc i64 %indvars.iv.i to i32
  br label %while.body.i.preheader.i.i

while.body.i.preheader.i.i:                       ; preds = %_Z4log2i.exit17.i.i, %while.body.i.preheader.i.preheader.i
  %p.021.i.i = phi i32 [ %p.1.i.i, %_Z4log2i.exit17.i.i ], [ 0, %while.body.i.preheader.i.preheader.i ]
  %j.020.i.i = phi i32 [ %inc.i.i, %_Z4log2i.exit17.i.i ], [ 1, %while.body.i.preheader.i.preheader.i ]
  br label %while.body.i.i.i

while.body.i.i.i:                                 ; preds = %while.body.i.i.i, %while.body.i.preheader.i.i
  %i.05.i.i.i = phi i32 [ %inc.i.i.i, %while.body.i.i.i ], [ 0, %while.body.i.preheader.i.i ]
  %k.04.i.i.i = phi i32 [ %shr.i.i.i, %while.body.i.i.i ], [ %N, %while.body.i.preheader.i.i ]
  %shr.i.i.i = ashr i32 %k.04.i.i.i, 1
  %inc.i.i.i = add nuw nsw i32 %i.05.i.i.i, 1
  %tobool.not.i.i.i = icmp ult i32 %k.04.i.i.i, 2
  br i1 %tobool.not.i.i.i, label %_Z4log2i.exit.i.i, label %while.body.i.i.i, !llvm.loop !5

_Z4log2i.exit.i.i:                                ; preds = %while.body.i.i.i
  %cmp.not.i.i = icmp ugt i32 %j.020.i.i, %i.05.i.i.i
  br i1 %cmp.not.i.i, label %_Z7reverseii.exit.i, label %while.body.i15.i.i

while.body.i15.i.i:                               ; preds = %_Z4log2i.exit.i.i, %while.body.i15.i.i
  %i.05.i10.i.i = phi i32 [ %inc.i13.i.i, %while.body.i15.i.i ], [ 0, %_Z4log2i.exit.i.i ]
  %k.04.i11.i.i = phi i32 [ %shr.i12.i.i, %while.body.i15.i.i ], [ %N, %_Z4log2i.exit.i.i ]
  %shr.i12.i.i = ashr i32 %k.04.i11.i.i, 1
  %inc.i13.i.i = add nuw nsw i32 %i.05.i10.i.i, 1
  %tobool.not.i14.i.i = icmp ult i32 %k.04.i11.i.i, 2
  br i1 %tobool.not.i14.i.i, label %_Z4log2i.exit17.i.i, label %while.body.i15.i.i, !llvm.loop !5

_Z4log2i.exit17.i.i:                              ; preds = %while.body.i15.i.i
  %sub.i.i = sub nsw i32 %i.05.i10.i.i, %j.020.i.i
  %shl.i.i = shl nuw i32 1, %sub.i.i
  %and.i.i = and i32 %shl.i.i, %1
  %tobool.not.i.i = icmp eq i32 %and.i.i, 0
  %sub2.i.i = add nsw i32 %j.020.i.i, -1
  %shl3.i.i = shl nuw i32 1, %sub2.i.i
  %or.i.i = select i1 %tobool.not.i.i, i32 0, i32 %shl3.i.i
  %p.1.i.i = or i32 %or.i.i, %p.021.i.i
  %inc.i.i = add nuw nsw i32 %j.020.i.i, 1
  br label %while.body.i.preheader.i.i

_Z7reverseii.exit.i:                              ; preds = %_Z4log2i.exit.i.i
  %idxprom.i = sext i32 %p.021.i.i to i64
  %arrayidx.i = getelementptr inbounds %"class.std::complex", ptr %f, i64 %idxprom.i
  %arrayidx2.i = getelementptr inbounds [200 x %"class.std::complex"], ptr %f2.i, i64 0, i64 %indvars.iv.i
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 16 dereferenceable(16) %arrayidx2.i, ptr noundef nonnull align 8 dereferenceable(16) %arrayidx.i, i64 16, i1 false), !tbaa.struct !8
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i
  br i1 %exitcond.not.i, label %for.body6.preheader.i, label %while.body.i.preheader.i.preheader.i, !llvm.loop !12

_Z6ordinaPSt7complexIdEi.exit:                    ; preds = %entry, %for.body6.preheader.i
  call void @llvm.lifetime.end.p0(i64 3200, ptr nonnull %f2.i) #16
  %div = sdiv i32 %N, 2
  %conv = sext i32 %div to i64
  %mul = shl nsw i64 %conv, 4
  %call = tail call noalias ptr @malloc(i64 noundef %mul) #17
  %conv3 = sitofp i32 %N to double
  %div4 = fdiv double 0xC01921FB54442D18, %conv3
  %call.i = tail call double @cos(double noundef %div4) #16
  %call1.i = tail call double @sin(double noundef %div4) #16
  %arrayidx = getelementptr inbounds %"class.std::complex", ptr %call, i64 1
  store double %call.i, ptr %arrayidx, align 8, !tbaa.struct !8
  %ref.tmp.sroa.4.0.arrayidx.sroa_idx = getelementptr inbounds %"class.std::complex", ptr %call, i64 1, i32 0, i32 1
  store double %call1.i, ptr %ref.tmp.sroa.4.0.arrayidx.sroa_idx, align 8, !tbaa.struct !13
  store <2 x double> <double 1.000000e+00, double 0.000000e+00>, ptr %call, align 8
  %cmp106 = icmp sgt i32 %N, 5
  br i1 %cmp106, label %for.body.preheader, label %for.cond15.preheader

for.body.preheader:                               ; preds = %_Z6ordinaPSt7complexIdEi.exit
  %smax = tail call i32 @llvm.smax.i32(i32 %div, i32 3)
  %wide.trip.count = zext i32 %smax to i64
  br label %for.body

for.cond15.preheader:                             ; preds = %for.body, %_Z6ordinaPSt7complexIdEi.exit
  %tobool.not3.i = icmp eq i32 %N, 0
  %wide.trip.count116 = zext i32 %N to i64
  br label %for.cond15

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ 2, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %2 = trunc i64 %indvars.iv to i32
  %call11 = tail call { double, double } @_ZSt3powIdESt7complexIT_ERKS2_i(ptr noundef nonnull align 8 dereferenceable(16) %arrayidx, i32 noundef %2)
  %3 = extractvalue { double, double } %call11, 0
  %4 = extractvalue { double, double } %call11, 1
  %arrayidx13 = getelementptr inbounds %"class.std::complex", ptr %call, i64 %indvars.iv
  store double %3, ptr %arrayidx13, align 8, !tbaa.struct !8
  %ref.tmp9.sroa.4.0.arrayidx13.sroa_idx = getelementptr inbounds i8, ptr %arrayidx13, i64 8
  store double %4, ptr %ref.tmp9.sroa.4.0.arrayidx13.sroa_idx, align 8, !tbaa.struct !13
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond15.preheader, label %for.body, !llvm.loop !14

for.cond15:                                       ; preds = %for.cond15.preheader, %for.cond.cleanup23
  %j.0 = phi i32 [ %inc52, %for.cond.cleanup23 ], [ 0, %for.cond15.preheader ]
  %a.0 = phi i32 [ %div50, %for.cond.cleanup23 ], [ %div, %for.cond15.preheader ]
  %n.0 = phi i32 [ %mul49, %for.cond.cleanup23 ], [ 1, %for.cond15.preheader ]
  br i1 %tobool.not3.i, label %_Z4log2i.exit, label %while.body.i

while.body.i:                                     ; preds = %for.cond15, %while.body.i
  %i.05.i = phi i32 [ %inc.i, %while.body.i ], [ 0, %for.cond15 ]
  %k.04.i = phi i32 [ %shr.i, %while.body.i ], [ %N, %for.cond15 ]
  %shr.i = ashr i32 %k.04.i, 1
  %inc.i = add nuw nsw i32 %i.05.i, 1
  %tobool.not.i = icmp ult i32 %k.04.i, 2
  br i1 %tobool.not.i, label %_Z4log2i.exit, label %while.body.i, !llvm.loop !5

_Z4log2i.exit:                                    ; preds = %while.body.i, %for.cond15
  %i.0.lcssa.i = phi i32 [ -1, %for.cond15 ], [ %i.05.i, %while.body.i ]
  %cmp17 = icmp slt i32 %j.0, %i.0.lcssa.i
  br i1 %cmp17, label %for.cond21.preheader, label %for.cond.cleanup18

for.cond21.preheader:                             ; preds = %_Z4log2i.exit
  br i1 %cmp23.i, label %for.body24.lr.ph, label %for.cond.cleanup23

for.body24.lr.ph:                                 ; preds = %for.cond21.preheader
  %mul28 = mul nsw i32 %n.0, %a.0
  %5 = sext i32 %n.0 to i64
  br label %for.body24

for.cond.cleanup18:                               ; preds = %_Z4log2i.exit
  tail call void @free(ptr noundef %call) #16
  ret void

for.cond.cleanup23:                               ; preds = %for.inc46, %for.cond21.preheader
  %mul49 = shl nsw i32 %n.0, 1
  %div50 = sdiv i32 %a.0, 2
  %inc52 = add nuw nsw i32 %j.0, 1
  br label %for.cond15, !llvm.loop !15

for.body24:                                       ; preds = %for.body24.lr.ph, %for.inc46
  %indvars.iv111 = phi i64 [ 0, %for.body24.lr.ph ], [ %indvars.iv.next112, %for.inc46 ]
  %6 = trunc i64 %indvars.iv111 to i32
  %and = and i32 %n.0, %6
  %tobool.not = icmp eq i32 %and, 0
  br i1 %tobool.not, label %if.then, label %for.inc46

if.then:                                          ; preds = %for.body24
  %arrayidx26 = getelementptr inbounds %"class.std::complex", ptr %f, i64 %indvars.iv111
  %temp.sroa.0.0.copyload = load double, ptr %arrayidx26, align 8, !tbaa.struct !8
  %temp.sroa.5.0.arrayidx26.sroa_idx = getelementptr inbounds i8, ptr %arrayidx26, i64 8
  %temp.sroa.5.0.copyload = load double, ptr %temp.sroa.5.0.arrayidx26.sroa_idx, align 8, !tbaa.struct !13
  %7 = trunc i64 %indvars.iv111 to i32
  %8 = mul i32 %a.0, %7
  %rem = srem i32 %8, %mul28
  %idxprom29 = sext i32 %rem to i64
  %arrayidx30 = getelementptr inbounds %"class.std::complex", ptr %call, i64 %idxprom29
  %9 = add nsw i64 %indvars.iv111, %5
  %arrayidx32 = getelementptr inbounds %"class.std::complex", ptr %f, i64 %9
  %_M_value.imagp.i.i.i = getelementptr inbounds { double, double }, ptr %arrayidx32, i64 0, i32 1
  %10 = load <2 x double>, ptr %arrayidx30, align 8
  %11 = load <2 x double>, ptr %arrayidx32, align 8
  %12 = fmul <2 x double> %10, %11
  %13 = shufflevector <2 x double> %10, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %14 = fmul <2 x double> %13, %11
  %shift = shufflevector <2 x double> %12, <2 x double> poison, <2 x i32> <i32 1, i32 undef>
  %15 = fsub <2 x double> %12, %shift
  %mul_r.i.i = extractelement <2 x double> %15, i64 0
  %shift118 = shufflevector <2 x double> %14, <2 x double> poison, <2 x i32> <i32 1, i32 undef>
  %16 = fadd <2 x double> %14, %shift118
  %mul_i.i.i = extractelement <2 x double> %16, i64 0
  %isnan_cmp.i.i = fcmp uno double %mul_r.i.i, 0.000000e+00
  br i1 %isnan_cmp.i.i, label %complex_mul_imag_nan.i.i, label %_ZStmlIdESt7complexIT_ERKS2_S4_.exit, !prof !16

complex_mul_imag_nan.i.i:                         ; preds = %if.then
  %isnan_cmp4.i.i = fcmp uno double %mul_i.i.i, 0.000000e+00
  br i1 %isnan_cmp4.i.i, label %complex_mul_libcall.i.i, label %_ZStmlIdESt7complexIT_ERKS2_S4_.exit, !prof !16

complex_mul_libcall.i.i:                          ; preds = %complex_mul_imag_nan.i.i
  %17 = extractelement <2 x double> %10, i64 0
  %18 = extractelement <2 x double> %10, i64 1
  %19 = extractelement <2 x double> %11, i64 0
  %20 = extractelement <2 x double> %11, i64 1
  %call5.i.i = tail call noundef { double, double } @__muldc3(double noundef %17, double noundef %18, double noundef %19, double noundef %20) #16
  %21 = extractvalue { double, double } %call5.i.i, 0
  %22 = extractvalue { double, double } %call5.i.i, 1
  br label %_ZStmlIdESt7complexIT_ERKS2_S4_.exit

_ZStmlIdESt7complexIT_ERKS2_S4_.exit:             ; preds = %if.then, %complex_mul_imag_nan.i.i, %complex_mul_libcall.i.i
  %real_mul_phi.i.i = phi double [ %mul_r.i.i, %if.then ], [ %mul_r.i.i, %complex_mul_imag_nan.i.i ], [ %21, %complex_mul_libcall.i.i ]
  %imag_mul_phi.i.i = phi double [ %mul_i.i.i, %if.then ], [ %mul_i.i.i, %complex_mul_imag_nan.i.i ], [ %22, %complex_mul_libcall.i.i ]
  %add.r.i.i = fadd double %temp.sroa.0.0.copyload, %real_mul_phi.i.i
  %add.i.i.i = fadd double %temp.sroa.5.0.copyload, %imag_mul_phi.i.i
  store double %add.r.i.i, ptr %arrayidx26, align 8, !tbaa.struct !8
  store double %add.i.i.i, ptr %temp.sroa.5.0.arrayidx26.sroa_idx, align 8, !tbaa.struct !13
  %sub.r.i.i = fsub double %temp.sroa.0.0.copyload, %real_mul_phi.i.i
  %sub.i.i.i = fsub double %temp.sroa.5.0.copyload, %imag_mul_phi.i.i
  store double %sub.r.i.i, ptr %arrayidx32, align 8, !tbaa.struct !8
  store double %sub.i.i.i, ptr %_M_value.imagp.i.i.i, align 8, !tbaa.struct !13
  br label %for.inc46

for.inc46:                                        ; preds = %for.body24, %_ZStmlIdESt7complexIT_ERKS2_S4_.exit
  %indvars.iv.next112 = add nuw nsw i64 %indvars.iv111, 1
  %exitcond117.not = icmp eq i64 %indvars.iv.next112, %wide.trip.count116
  br i1 %exitcond117.not, label %for.cond.cleanup23, label %for.body24, !llvm.loop !17
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #6

; Function Attrs: inlinehint uwtable
define linkonce_odr dso_local { double, double } @_ZSt3powIdESt7complexIT_ERKS2_i(ptr noundef nonnull align 8 dereferenceable(16) %__z, i32 noundef %__n) local_unnamed_addr #7 comdat {
entry:
  %cmp = icmp slt i32 %__n, 0
  %agg.tmp.sroa.0.0.copyload = load double, ptr %__z, align 8
  %agg.tmp.sroa.2.0..sroa_idx = getelementptr inbounds i8, ptr %__z, i64 8
  %agg.tmp.sroa.2.0.copyload = load double, ptr %agg.tmp.sroa.2.0..sroa_idx, align 8
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %sub = sub i32 0, %__n
  %rem.i = and i32 %sub, 1
  %tobool.not.i = icmp eq i32 %rem.i, 0
  %retval.sroa.5.0.i = select i1 %tobool.not.i, double 0.000000e+00, double %agg.tmp.sroa.2.0.copyload
  %retval.sroa.0.0.i = select i1 %tobool.not.i, double 1.000000e+00, double %agg.tmp.sroa.0.0.copyload
  %tobool1.not29.i = icmp ult i32 %sub, 2
  br i1 %tobool1.not29.i, label %_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit, label %while.body.i

while.body.i:                                     ; preds = %cond.true, %if.end.i
  %__n.addr.034.i = phi i32 [ %shr35.i, %if.end.i ], [ %sub, %cond.true ]
  %__x.sroa.0.033.i = phi double [ %real_mul_phi.i.i, %if.end.i ], [ %agg.tmp.sroa.0.0.copyload, %cond.true ]
  %__x.sroa.6.032.i = phi double [ %imag_mul_phi.i.i, %if.end.i ], [ %agg.tmp.sroa.2.0.copyload, %cond.true ]
  %retval.sroa.0.131.i = phi double [ %retval.sroa.0.2.i, %if.end.i ], [ %retval.sroa.0.0.i, %cond.true ]
  %retval.sroa.5.130.i = phi double [ %retval.sroa.5.2.i, %if.end.i ], [ %retval.sroa.5.0.i, %cond.true ]
  %shr35.i = lshr i32 %__n.addr.034.i, 1
  %mul_ac.i.i = fmul double %__x.sroa.0.033.i, %__x.sroa.0.033.i
  %mul_bd.i.i = fmul double %__x.sroa.6.032.i, %__x.sroa.6.032.i
  %mul_ad.i.i = fmul double %__x.sroa.0.033.i, %__x.sroa.6.032.i
  %mul_r.i.i = fsub double %mul_ac.i.i, %mul_bd.i.i
  %mul_i.i.i = fadd double %mul_ad.i.i, %mul_ad.i.i
  %isnan_cmp.i.i = fcmp uno double %mul_r.i.i, 0.000000e+00
  br i1 %isnan_cmp.i.i, label %complex_mul_imag_nan.i.i, label %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i, !prof !16

complex_mul_imag_nan.i.i:                         ; preds = %while.body.i
  %isnan_cmp4.i.i = fcmp uno double %mul_i.i.i, 0.000000e+00
  br i1 %isnan_cmp4.i.i, label %complex_mul_libcall.i.i, label %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i, !prof !16

complex_mul_libcall.i.i:                          ; preds = %complex_mul_imag_nan.i.i
  %call5.i.i = tail call noundef { double, double } @__muldc3(double noundef %__x.sroa.0.033.i, double noundef %__x.sroa.6.032.i, double noundef %__x.sroa.0.033.i, double noundef %__x.sroa.6.032.i) #16
  %0 = extractvalue { double, double } %call5.i.i, 0
  %1 = extractvalue { double, double } %call5.i.i, 1
  br label %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i

_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i:        ; preds = %complex_mul_libcall.i.i, %complex_mul_imag_nan.i.i, %while.body.i
  %real_mul_phi.i.i = phi double [ %mul_r.i.i, %while.body.i ], [ %mul_r.i.i, %complex_mul_imag_nan.i.i ], [ %0, %complex_mul_libcall.i.i ]
  %imag_mul_phi.i.i = phi double [ %mul_i.i.i, %while.body.i ], [ %mul_i.i.i, %complex_mul_imag_nan.i.i ], [ %1, %complex_mul_libcall.i.i ]
  %2 = and i32 %__n.addr.034.i, 2
  %tobool3.not.i = icmp eq i32 %2, 0
  br i1 %tobool3.not.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i
  %mul_ac.i14.i = fmul double %retval.sroa.0.131.i, %real_mul_phi.i.i
  %mul_bd.i15.i = fmul double %retval.sroa.5.130.i, %imag_mul_phi.i.i
  %mul_ad.i16.i = fmul double %retval.sroa.0.131.i, %imag_mul_phi.i.i
  %mul_bc.i17.i = fmul double %retval.sroa.5.130.i, %real_mul_phi.i.i
  %mul_r.i18.i = fsub double %mul_ac.i14.i, %mul_bd.i15.i
  %mul_i.i19.i = fadd double %mul_bc.i17.i, %mul_ad.i16.i
  %isnan_cmp.i20.i = fcmp uno double %mul_r.i18.i, 0.000000e+00
  br i1 %isnan_cmp.i20.i, label %complex_mul_imag_nan.i22.i, label %if.end.i, !prof !16

complex_mul_imag_nan.i22.i:                       ; preds = %if.then.i
  %isnan_cmp4.i21.i = fcmp uno double %mul_i.i19.i, 0.000000e+00
  br i1 %isnan_cmp4.i21.i, label %complex_mul_libcall.i24.i, label %if.end.i, !prof !16

complex_mul_libcall.i24.i:                        ; preds = %complex_mul_imag_nan.i22.i
  %call5.i23.i = tail call noundef { double, double } @__muldc3(double noundef %retval.sroa.0.131.i, double noundef %retval.sroa.5.130.i, double noundef %real_mul_phi.i.i, double noundef %imag_mul_phi.i.i) #16
  %3 = extractvalue { double, double } %call5.i23.i, 0
  %4 = extractvalue { double, double } %call5.i23.i, 1
  br label %if.end.i

if.end.i:                                         ; preds = %complex_mul_libcall.i24.i, %complex_mul_imag_nan.i22.i, %if.then.i, %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i
  %retval.sroa.5.2.i = phi double [ %retval.sroa.5.130.i, %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i ], [ %mul_i.i19.i, %if.then.i ], [ %mul_i.i19.i, %complex_mul_imag_nan.i22.i ], [ %4, %complex_mul_libcall.i24.i ]
  %retval.sroa.0.2.i = phi double [ %retval.sroa.0.131.i, %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i ], [ %mul_r.i18.i, %if.then.i ], [ %mul_r.i18.i, %complex_mul_imag_nan.i22.i ], [ %3, %complex_mul_libcall.i24.i ]
  %tobool1.not.i = icmp ult i32 %__n.addr.034.i, 4
  br i1 %tobool1.not.i, label %_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit, label %while.body.i, !llvm.loop !18

_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit: ; preds = %if.end.i, %cond.true
  %retval.sroa.5.1.lcssa.i = phi double [ %retval.sroa.5.0.i, %cond.true ], [ %retval.sroa.5.2.i, %if.end.i ]
  %retval.sroa.0.1.lcssa.i = phi double [ %retval.sroa.0.0.i, %cond.true ], [ %retval.sroa.0.2.i, %if.end.i ]
  %call4.i.i = tail call noundef { double, double } @__divdc3(double noundef 1.000000e+00, double noundef 0.000000e+00, double noundef %retval.sroa.0.1.lcssa.i, double noundef %retval.sroa.5.1.lcssa.i) #16
  br label %cond.end

cond.false:                                       ; preds = %entry
  %rem.i12 = and i32 %__n, 1
  %tobool.not.i13 = icmp eq i32 %rem.i12, 0
  %retval.sroa.5.0.i14 = select i1 %tobool.not.i13, double 0.000000e+00, double %agg.tmp.sroa.2.0.copyload
  %retval.sroa.0.0.i15 = select i1 %tobool.not.i13, double 1.000000e+00, double %agg.tmp.sroa.0.0.copyload
  %tobool1.not29.i16 = icmp ult i32 %__n, 2
  br i1 %tobool1.not29.i16, label %_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit58, label %while.body.i29

while.body.i29:                                   ; preds = %cond.false, %if.end.i53
  %__n.addr.034.i17 = phi i32 [ %shr35.i22, %if.end.i53 ], [ %__n, %cond.false ]
  %__x.sroa.0.033.i18 = phi double [ %real_mul_phi.i.i34, %if.end.i53 ], [ %agg.tmp.sroa.0.0.copyload, %cond.false ]
  %__x.sroa.6.032.i19 = phi double [ %imag_mul_phi.i.i35, %if.end.i53 ], [ %agg.tmp.sroa.2.0.copyload, %cond.false ]
  %retval.sroa.0.131.i20 = phi double [ %retval.sroa.0.2.i51, %if.end.i53 ], [ %retval.sroa.0.0.i15, %cond.false ]
  %retval.sroa.5.130.i21 = phi double [ %retval.sroa.5.2.i50, %if.end.i53 ], [ %retval.sroa.5.0.i14, %cond.false ]
  %shr35.i22 = lshr i32 %__n.addr.034.i17, 1
  %mul_ac.i.i23 = fmul double %__x.sroa.0.033.i18, %__x.sroa.0.033.i18
  %mul_bd.i.i24 = fmul double %__x.sroa.6.032.i19, %__x.sroa.6.032.i19
  %mul_ad.i.i25 = fmul double %__x.sroa.0.033.i18, %__x.sroa.6.032.i19
  %mul_r.i.i26 = fsub double %mul_ac.i.i23, %mul_bd.i.i24
  %mul_i.i.i27 = fadd double %mul_ad.i.i25, %mul_ad.i.i25
  %isnan_cmp.i.i28 = fcmp uno double %mul_r.i.i26, 0.000000e+00
  br i1 %isnan_cmp.i.i28, label %complex_mul_imag_nan.i.i31, label %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i37, !prof !16

complex_mul_imag_nan.i.i31:                       ; preds = %while.body.i29
  %isnan_cmp4.i.i30 = fcmp uno double %mul_i.i.i27, 0.000000e+00
  br i1 %isnan_cmp4.i.i30, label %complex_mul_libcall.i.i33, label %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i37, !prof !16

complex_mul_libcall.i.i33:                        ; preds = %complex_mul_imag_nan.i.i31
  %call5.i.i32 = tail call noundef { double, double } @__muldc3(double noundef %__x.sroa.0.033.i18, double noundef %__x.sroa.6.032.i19, double noundef %__x.sroa.0.033.i18, double noundef %__x.sroa.6.032.i19) #16
  %5 = extractvalue { double, double } %call5.i.i32, 0
  %6 = extractvalue { double, double } %call5.i.i32, 1
  br label %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i37

_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i37:      ; preds = %complex_mul_libcall.i.i33, %complex_mul_imag_nan.i.i31, %while.body.i29
  %real_mul_phi.i.i34 = phi double [ %mul_r.i.i26, %while.body.i29 ], [ %mul_r.i.i26, %complex_mul_imag_nan.i.i31 ], [ %5, %complex_mul_libcall.i.i33 ]
  %imag_mul_phi.i.i35 = phi double [ %mul_i.i.i27, %while.body.i29 ], [ %mul_i.i.i27, %complex_mul_imag_nan.i.i31 ], [ %6, %complex_mul_libcall.i.i33 ]
  %7 = and i32 %__n.addr.034.i17, 2
  %tobool3.not.i36 = icmp eq i32 %7, 0
  br i1 %tobool3.not.i36, label %if.end.i53, label %if.then.i45

if.then.i45:                                      ; preds = %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i37
  %mul_ac.i14.i38 = fmul double %retval.sroa.0.131.i20, %real_mul_phi.i.i34
  %mul_bd.i15.i39 = fmul double %retval.sroa.5.130.i21, %imag_mul_phi.i.i35
  %mul_ad.i16.i40 = fmul double %retval.sroa.0.131.i20, %imag_mul_phi.i.i35
  %mul_bc.i17.i41 = fmul double %retval.sroa.5.130.i21, %real_mul_phi.i.i34
  %mul_r.i18.i42 = fsub double %mul_ac.i14.i38, %mul_bd.i15.i39
  %mul_i.i19.i43 = fadd double %mul_bc.i17.i41, %mul_ad.i16.i40
  %isnan_cmp.i20.i44 = fcmp uno double %mul_r.i18.i42, 0.000000e+00
  br i1 %isnan_cmp.i20.i44, label %complex_mul_imag_nan.i22.i47, label %if.end.i53, !prof !16

complex_mul_imag_nan.i22.i47:                     ; preds = %if.then.i45
  %isnan_cmp4.i21.i46 = fcmp uno double %mul_i.i19.i43, 0.000000e+00
  br i1 %isnan_cmp4.i21.i46, label %complex_mul_libcall.i24.i49, label %if.end.i53, !prof !16

complex_mul_libcall.i24.i49:                      ; preds = %complex_mul_imag_nan.i22.i47
  %call5.i23.i48 = tail call noundef { double, double } @__muldc3(double noundef %retval.sroa.0.131.i20, double noundef %retval.sroa.5.130.i21, double noundef %real_mul_phi.i.i34, double noundef %imag_mul_phi.i.i35) #16
  %8 = extractvalue { double, double } %call5.i23.i48, 0
  %9 = extractvalue { double, double } %call5.i23.i48, 1
  br label %if.end.i53

if.end.i53:                                       ; preds = %complex_mul_libcall.i24.i49, %complex_mul_imag_nan.i22.i47, %if.then.i45, %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i37
  %retval.sroa.5.2.i50 = phi double [ %retval.sroa.5.130.i21, %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i37 ], [ %mul_i.i19.i43, %if.then.i45 ], [ %mul_i.i19.i43, %complex_mul_imag_nan.i22.i47 ], [ %9, %complex_mul_libcall.i24.i49 ]
  %retval.sroa.0.2.i51 = phi double [ %retval.sroa.0.131.i20, %_ZNSt7complexIdEmLIdEERS0_RKS_IT_E.exit.i37 ], [ %mul_r.i18.i42, %if.then.i45 ], [ %mul_r.i18.i42, %complex_mul_imag_nan.i22.i47 ], [ %8, %complex_mul_libcall.i24.i49 ]
  %tobool1.not.i52 = icmp ult i32 %__n.addr.034.i17, 4
  br i1 %tobool1.not.i52, label %_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit58, label %while.body.i29, !llvm.loop !18

_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit58: ; preds = %if.end.i53, %cond.false
  %retval.sroa.5.1.lcssa.i54 = phi double [ %retval.sroa.5.0.i14, %cond.false ], [ %retval.sroa.5.2.i50, %if.end.i53 ]
  %retval.sroa.0.1.lcssa.i55 = phi double [ %retval.sroa.0.0.i15, %cond.false ], [ %retval.sroa.0.2.i51, %if.end.i53 ]
  %.fca.0.insert.i56 = insertvalue { double, double } poison, double %retval.sroa.0.1.lcssa.i55, 0
  %.fca.1.insert.i57 = insertvalue { double, double } %.fca.0.insert.i56, double %retval.sroa.5.1.lcssa.i54, 1
  br label %cond.end

cond.end:                                         ; preds = %_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit58, %_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit
  %call2.pn = phi { double, double } [ %call4.i.i, %_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit ], [ %.fca.1.insert.i57, %_ZSt22__complex_pow_unsignedIdESt7complexIT_ES2_j.exit58 ]
  ret { double, double } %call2.pn
}

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #8

; Function Attrs: mustprogress uwtable
define dso_local void @_Z3FFTPSt7complexIdEid(ptr nocapture noundef %f, i32 noundef %N, double noundef %d) local_unnamed_addr #9 {
entry:
  tail call void @_Z9transformPSt7complexIdEi(ptr noundef %f, i32 noundef %N)
  %cmp5 = icmp sgt i32 %N, 0
  br i1 %cmp5, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = zext i32 %N to i64
  %min.iters.check = icmp eq i32 %N, 1
  br i1 %min.iters.check, label %for.body.preheader9, label %vector.ph

vector.ph:                                        ; preds = %for.body.preheader
  %n.vec = and i64 %wide.trip.count, 4294967294
  %broadcast.splatinsert = insertelement <2 x double> poison, double %d, i64 0
  %broadcast.splat = shufflevector <2 x double> %broadcast.splatinsert, <2 x double> poison, <2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds %"class.std::complex", ptr %f, i64 %index
  %wide.vec = load <4 x double>, ptr %0, align 8
  %strided.vec = shufflevector <4 x double> %wide.vec, <4 x double> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec8 = shufflevector <4 x double> %wide.vec, <4 x double> poison, <2 x i32> <i32 1, i32 3>
  %1 = getelementptr inbounds { double, double }, ptr %0, i64 0, i32 1
  %2 = fmul <2 x double> %strided.vec, %broadcast.splat
  %3 = fmul <2 x double> %strided.vec8, %broadcast.splat
  %4 = getelementptr inbounds double, ptr %1, i64 -1
  %interleaved.vec = shufflevector <2 x double> %2, <2 x double> %3, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  store <4 x double> %interleaved.vec, ptr %4, align 8
  %index.next = add nuw i64 %index, 2
  %5 = icmp eq i64 %index.next, %n.vec
  br i1 %5, label %middle.block, label %vector.body, !llvm.loop !19

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count
  br i1 %cmp.n, label %for.cond.cleanup, label %for.body.preheader9

for.body.preheader9:                              ; preds = %for.body.preheader, %middle.block
  %indvars.iv.ph = phi i64 [ 0, %for.body.preheader ], [ %n.vec, %middle.block ]
  %6 = insertelement <2 x double> poison, double %d, i64 0
  %7 = shufflevector <2 x double> %6, <2 x double> poison, <2 x i32> zeroinitializer
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %middle.block, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader9, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ %indvars.iv.ph, %for.body.preheader9 ]
  %arrayidx = getelementptr inbounds %"class.std::complex", ptr %f, i64 %indvars.iv
  %8 = load <2 x double>, ptr %arrayidx, align 8
  %9 = fmul <2 x double> %8, %7
  store <2 x double> %9, ptr %arrayidx, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !22
}

; Function Attrs: norecurse uwtable
define dso_local noundef i32 @main() local_unnamed_addr #10 {
entry:
  %n = alloca i32, align 4
  %d = alloca double, align 8
  %vec = alloca [200 x %"class.std::complex"], align 16
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %n) #16
  br label %do.body

do.body:                                          ; preds = %_Z5checki.exit, %entry
  %call1.i = call noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull @.str, i64 noundef 44)
  %vtable.i = load ptr, ptr @_ZSt4cout, align 8, !tbaa !23
  %vbase.offset.ptr.i = getelementptr i8, ptr %vtable.i, i64 -24
  %vbase.offset.i = load i64, ptr %vbase.offset.ptr.i, align 8
  %add.ptr.i = getelementptr inbounds i8, ptr @_ZSt4cout, i64 %vbase.offset.i
  %_M_ctype.i.i = getelementptr inbounds %"class.std::basic_ios", ptr %add.ptr.i, i64 0, i32 5
  %0 = load ptr, ptr %_M_ctype.i.i, align 8, !tbaa !25
  %tobool.not.i.i.i = icmp eq ptr %0, null
  br i1 %tobool.not.i.i.i, label %if.then.i.i.i, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i

if.then.i.i.i:                                    ; preds = %do.body
  call void @_ZSt16__throw_bad_castv() #18
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i: ; preds = %do.body
  %_M_widen_ok.i.i.i = getelementptr inbounds %"class.std::ctype", ptr %0, i64 0, i32 8
  %1 = load i8, ptr %_M_widen_ok.i.i.i, align 8, !tbaa !36
  %tobool.not.i3.i.i = icmp eq i8 %1, 0
  br i1 %tobool.not.i3.i.i, label %if.end.i.i.i, label %if.then.i4.i.i

if.then.i4.i.i:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i
  %arrayidx.i.i.i = getelementptr inbounds %"class.std::ctype", ptr %0, i64 0, i32 9, i64 10
  %2 = load i8, ptr %arrayidx.i.i.i, align 1, !tbaa !9
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit

if.end.i.i.i:                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %0)
  %vtable.i.i.i = load ptr, ptr %0, align 8, !tbaa !23
  %vfn.i.i.i = getelementptr inbounds ptr, ptr %vtable.i.i.i, i64 6
  %3 = load ptr, ptr %vfn.i.i.i, align 8
  %call.i.i.i = call noundef signext i8 %3(ptr noundef nonnull align 8 dereferenceable(570) %0, i8 noundef signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit: ; preds = %if.then.i4.i.i, %if.end.i.i.i
  %retval.0.i.i.i = phi i8 [ %2, %if.then.i4.i.i ], [ %call.i.i.i, %if.end.i.i.i ]
  %call1.i45 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, i8 noundef signext %retval.0.i.i.i)
  %call.i.i46 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %call1.i45)
  %call2 = call noundef nonnull align 8 dereferenceable(16) ptr @_ZNSirsERi(ptr noundef nonnull align 8 dereferenceable(16) @_ZSt3cin, ptr noundef nonnull align 4 dereferenceable(4) %n)
  %4 = load i32, ptr %n, align 4, !tbaa !39
  %cmp.i = icmp sgt i32 %4, 0
  br i1 %cmp.i, label %land.rhs.i, label %_Z5checki.exit

land.rhs.i:                                       ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit
  %5 = call i32 @llvm.ctpop.i32(i32 %4), !range !7
  %cmp1.i = icmp ult i32 %5, 2
  %6 = zext i1 %cmp1.i to i32
  br label %_Z5checki.exit

_Z5checki.exit:                                   ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit, %land.rhs.i
  %conv.i = phi i32 [ 0, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit ], [ %6, %land.rhs.i ]
  %tobool.not = icmp eq i32 %conv.i, 0
  br i1 %tobool.not, label %do.body, label %do.end, !llvm.loop !40

do.end:                                           ; preds = %_Z5checki.exit
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %d) #16
  %call1.i32 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull @.str.1, i64 noundef 21)
  %vtable.i47 = load ptr, ptr @_ZSt4cout, align 8, !tbaa !23
  %vbase.offset.ptr.i48 = getelementptr i8, ptr %vtable.i47, i64 -24
  %vbase.offset.i49 = load i64, ptr %vbase.offset.ptr.i48, align 8
  %add.ptr.i50 = getelementptr inbounds i8, ptr @_ZSt4cout, i64 %vbase.offset.i49
  %_M_ctype.i.i51 = getelementptr inbounds %"class.std::basic_ios", ptr %add.ptr.i50, i64 0, i32 5
  %7 = load ptr, ptr %_M_ctype.i.i51, align 8, !tbaa !25
  %tobool.not.i.i.i52 = icmp eq ptr %7, null
  br i1 %tobool.not.i.i.i52, label %if.then.i.i.i53, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i56

if.then.i.i.i53:                                  ; preds = %do.end
  call void @_ZSt16__throw_bad_castv() #18
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i56: ; preds = %do.end
  %_M_widen_ok.i.i.i54 = getelementptr inbounds %"class.std::ctype", ptr %7, i64 0, i32 8
  %8 = load i8, ptr %_M_widen_ok.i.i.i54, align 8, !tbaa !36
  %tobool.not.i3.i.i55 = icmp eq i8 %8, 0
  br i1 %tobool.not.i3.i.i55, label %if.end.i.i.i62, label %if.then.i4.i.i58

if.then.i4.i.i58:                                 ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i56
  %arrayidx.i.i.i57 = getelementptr inbounds %"class.std::ctype", ptr %7, i64 0, i32 9, i64 10
  %9 = load i8, ptr %arrayidx.i.i.i57, align 1, !tbaa !9
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit66

if.end.i.i.i62:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i56
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %7)
  %vtable.i.i.i59 = load ptr, ptr %7, align 8, !tbaa !23
  %vfn.i.i.i60 = getelementptr inbounds ptr, ptr %vtable.i.i.i59, i64 6
  %10 = load ptr, ptr %vfn.i.i.i60, align 8
  %call.i.i.i61 = call noundef signext i8 %10(ptr noundef nonnull align 8 dereferenceable(570) %7, i8 noundef signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit66

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit66: ; preds = %if.then.i4.i.i58, %if.end.i.i.i62
  %retval.0.i.i.i63 = phi i8 [ %9, %if.then.i4.i.i58 ], [ %call.i.i.i61, %if.end.i.i.i62 ]
  %call1.i64 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, i8 noundef signext %retval.0.i.i.i63)
  %call.i.i65 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %call1.i64)
  %call.i34 = call noundef nonnull align 8 dereferenceable(16) ptr @_ZNSi10_M_extractIdEERSiRT_(ptr noundef nonnull align 8 dereferenceable(16) @_ZSt3cin, ptr noundef nonnull align 8 dereferenceable(8) %d)
  call void @llvm.lifetime.start.p0(i64 3200, ptr nonnull %vec) #16
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 16 dereferenceable(3200) %vec, i8 0, i64 3200, i1 false)
  %call1.i36 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull @.str.2, i64 noundef 17)
  %vtable.i67 = load ptr, ptr @_ZSt4cout, align 8, !tbaa !23
  %vbase.offset.ptr.i68 = getelementptr i8, ptr %vtable.i67, i64 -24
  %vbase.offset.i69 = load i64, ptr %vbase.offset.ptr.i68, align 8
  %add.ptr.i70 = getelementptr inbounds i8, ptr @_ZSt4cout, i64 %vbase.offset.i69
  %_M_ctype.i.i71 = getelementptr inbounds %"class.std::basic_ios", ptr %add.ptr.i70, i64 0, i32 5
  %11 = load ptr, ptr %_M_ctype.i.i71, align 8, !tbaa !25
  %tobool.not.i.i.i72 = icmp eq ptr %11, null
  br i1 %tobool.not.i.i.i72, label %if.then.i.i.i73, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i76

if.then.i.i.i73:                                  ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit66
  call void @_ZSt16__throw_bad_castv() #18
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i76: ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit66
  %_M_widen_ok.i.i.i74 = getelementptr inbounds %"class.std::ctype", ptr %11, i64 0, i32 8
  %12 = load i8, ptr %_M_widen_ok.i.i.i74, align 8, !tbaa !36
  %tobool.not.i3.i.i75 = icmp eq i8 %12, 0
  br i1 %tobool.not.i3.i.i75, label %if.end.i.i.i82, label %if.then.i4.i.i78

if.then.i4.i.i78:                                 ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i76
  %arrayidx.i.i.i77 = getelementptr inbounds %"class.std::ctype", ptr %11, i64 0, i32 9, i64 10
  %13 = load i8, ptr %arrayidx.i.i.i77, align 1, !tbaa !9
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit86

if.end.i.i.i82:                                   ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i76
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %11)
  %vtable.i.i.i79 = load ptr, ptr %11, align 8, !tbaa !23
  %vfn.i.i.i80 = getelementptr inbounds ptr, ptr %vtable.i.i.i79, i64 6
  %14 = load ptr, ptr %vfn.i.i.i80, align 8
  %call.i.i.i81 = call noundef signext i8 %14(ptr noundef nonnull align 8 dereferenceable(570) %11, i8 noundef signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit86

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit86: ; preds = %if.then.i4.i.i78, %if.end.i.i.i82
  %retval.0.i.i.i83 = phi i8 [ %13, %if.then.i4.i.i78 ], [ %call.i.i.i81, %if.end.i.i.i82 ]
  %call1.i84 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, i8 noundef signext %retval.0.i.i.i83)
  %call.i.i85 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %call1.i84)
  %15 = load i32, ptr %n, align 4, !tbaa !39
  %cmp148 = icmp sgt i32 %15, 0
  br i1 %cmp148, label %for.body, label %for.cond.cleanup.thread

for.cond.cleanup.thread:                          ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit86
  call void @_Z9transformPSt7complexIdEi(ptr noundef nonnull %vec, i32 noundef %15)
  br label %_Z3FFTPSt7complexIdEid.exit

for.cond.cleanup:                                 ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit126
  %16 = load double, ptr %d, align 8, !tbaa !41
  call void @_Z9transformPSt7complexIdEi(ptr noundef nonnull %vec, i32 noundef %37)
  %cmp5.i = icmp sgt i32 %37, 0
  br i1 %cmp5.i, label %for.body.preheader.i, label %_Z3FFTPSt7complexIdEid.exit

for.body.preheader.i:                             ; preds = %for.cond.cleanup
  %wide.trip.count.i = zext i32 %37 to i64
  %min.iters.check = icmp eq i32 %37, 1
  br i1 %min.iters.check, label %for.body.i.preheader, label %vector.ph

vector.ph:                                        ; preds = %for.body.preheader.i
  %n.vec = and i64 %wide.trip.count.i, 4294967294
  %broadcast.splatinsert = insertelement <2 x double> poison, double %16, i64 0
  %broadcast.splat = shufflevector <2 x double> %broadcast.splatinsert, <2 x double> poison, <2 x i32> zeroinitializer
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %17 = getelementptr inbounds %"class.std::complex", ptr %vec, i64 %index
  %wide.vec = load <4 x double>, ptr %17, align 16
  %strided.vec = shufflevector <4 x double> %wide.vec, <4 x double> poison, <2 x i32> <i32 0, i32 2>
  %strided.vec159 = shufflevector <4 x double> %wide.vec, <4 x double> poison, <2 x i32> <i32 1, i32 3>
  %18 = getelementptr inbounds { double, double }, ptr %17, i64 0, i32 1
  %19 = fmul <2 x double> %broadcast.splat, %strided.vec
  %20 = fmul <2 x double> %broadcast.splat, %strided.vec159
  %21 = getelementptr inbounds double, ptr %18, i64 -1
  %interleaved.vec = shufflevector <2 x double> %19, <2 x double> %20, <4 x i32> <i32 0, i32 2, i32 1, i32 3>
  store <4 x double> %interleaved.vec, ptr %21, align 16
  %index.next = add nuw i64 %index, 2
  %22 = icmp eq i64 %index.next, %n.vec
  br i1 %22, label %middle.block, label %vector.body, !llvm.loop !43

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %n.vec, %wide.trip.count.i
  br i1 %cmp.n, label %_Z3FFTPSt7complexIdEid.exit, label %for.body.i.preheader

for.body.i.preheader:                             ; preds = %for.body.preheader.i, %middle.block
  %indvars.iv.i.ph = phi i64 [ 0, %for.body.preheader.i ], [ %n.vec, %middle.block ]
  %23 = insertelement <2 x double> poison, double %16, i64 0
  %24 = shufflevector <2 x double> %23, <2 x double> poison, <2 x i32> zeroinitializer
  br label %for.body.i

for.body.i:                                       ; preds = %for.body.i.preheader, %for.body.i
  %indvars.iv.i = phi i64 [ %indvars.iv.next.i, %for.body.i ], [ %indvars.iv.i.ph, %for.body.i.preheader ]
  %arrayidx.i = getelementptr inbounds %"class.std::complex", ptr %vec, i64 %indvars.iv.i
  %25 = load <2 x double>, ptr %arrayidx.i, align 16
  %26 = fmul <2 x double> %24, %25
  store <2 x double> %26, ptr %arrayidx.i, align 16
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i
  br i1 %exitcond.not.i, label %_Z3FFTPSt7complexIdEid.exit, label %for.body.i, !llvm.loop !44

_Z3FFTPSt7complexIdEid.exit:                      ; preds = %for.body.i, %middle.block, %for.cond.cleanup.thread, %for.cond.cleanup
  %call1.i39 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull @.str.4, i64 noundef 42)
  %vtable.i87 = load ptr, ptr @_ZSt4cout, align 8, !tbaa !23
  %vbase.offset.ptr.i88 = getelementptr i8, ptr %vtable.i87, i64 -24
  %vbase.offset.i89 = load i64, ptr %vbase.offset.ptr.i88, align 8
  %add.ptr.i90 = getelementptr inbounds i8, ptr @_ZSt4cout, i64 %vbase.offset.i89
  %_M_ctype.i.i91 = getelementptr inbounds %"class.std::basic_ios", ptr %add.ptr.i90, i64 0, i32 5
  %27 = load ptr, ptr %_M_ctype.i.i91, align 8, !tbaa !25
  %tobool.not.i.i.i92 = icmp eq ptr %27, null
  br i1 %tobool.not.i.i.i92, label %if.then.i.i.i93, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i96

if.then.i.i.i93:                                  ; preds = %_Z3FFTPSt7complexIdEid.exit
  call void @_ZSt16__throw_bad_castv() #18
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i96: ; preds = %_Z3FFTPSt7complexIdEid.exit
  %_M_widen_ok.i.i.i94 = getelementptr inbounds %"class.std::ctype", ptr %27, i64 0, i32 8
  %28 = load i8, ptr %_M_widen_ok.i.i.i94, align 8, !tbaa !36
  %tobool.not.i3.i.i95 = icmp eq i8 %28, 0
  br i1 %tobool.not.i3.i.i95, label %if.end.i.i.i102, label %if.then.i4.i.i98

if.then.i4.i.i98:                                 ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i96
  %arrayidx.i.i.i97 = getelementptr inbounds %"class.std::ctype", ptr %27, i64 0, i32 9, i64 10
  %29 = load i8, ptr %arrayidx.i.i.i97, align 1, !tbaa !9
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit106

if.end.i.i.i102:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i96
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %27)
  %vtable.i.i.i99 = load ptr, ptr %27, align 8, !tbaa !23
  %vfn.i.i.i100 = getelementptr inbounds ptr, ptr %vtable.i.i.i99, i64 6
  %30 = load ptr, ptr %vfn.i.i.i100, align 8
  %call.i.i.i101 = call noundef signext i8 %30(ptr noundef nonnull align 8 dereferenceable(570) %27, i8 noundef signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit106

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit106: ; preds = %if.then.i4.i.i98, %if.end.i.i.i102
  %retval.0.i.i.i103 = phi i8 [ %29, %if.then.i4.i.i98 ], [ %call.i.i.i101, %if.end.i.i.i102 ]
  %call1.i104 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, i8 noundef signext %retval.0.i.i.i103)
  %call.i.i105 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %call1.i104)
  %31 = load i32, ptr %n, align 4, !tbaa !39
  %cmp16150 = icmp sgt i32 %31, 0
  br i1 %cmp16150, label %for.body18, label %for.cond.cleanup17

for.body:                                         ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit86, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit126
  %indvars.iv = phi i64 [ %indvars.iv.next, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit126 ], [ 0, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit86 ]
  %call1.i42 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull @.str.3, i64 noundef 24)
  %32 = trunc i64 %indvars.iv to i32
  %call10 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEi(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, i32 noundef %32)
  %vtable.i107 = load ptr, ptr %call10, align 8, !tbaa !23
  %vbase.offset.ptr.i108 = getelementptr i8, ptr %vtable.i107, i64 -24
  %vbase.offset.i109 = load i64, ptr %vbase.offset.ptr.i108, align 8
  %add.ptr.i110 = getelementptr inbounds i8, ptr %call10, i64 %vbase.offset.i109
  %_M_ctype.i.i111 = getelementptr inbounds %"class.std::basic_ios", ptr %add.ptr.i110, i64 0, i32 5
  %33 = load ptr, ptr %_M_ctype.i.i111, align 8, !tbaa !25
  %tobool.not.i.i.i112 = icmp eq ptr %33, null
  br i1 %tobool.not.i.i.i112, label %if.then.i.i.i113, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i116

if.then.i.i.i113:                                 ; preds = %for.body
  call void @_ZSt16__throw_bad_castv() #18
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i116: ; preds = %for.body
  %_M_widen_ok.i.i.i114 = getelementptr inbounds %"class.std::ctype", ptr %33, i64 0, i32 8
  %34 = load i8, ptr %_M_widen_ok.i.i.i114, align 8, !tbaa !36
  %tobool.not.i3.i.i115 = icmp eq i8 %34, 0
  br i1 %tobool.not.i3.i.i115, label %if.end.i.i.i122, label %if.then.i4.i.i118

if.then.i4.i.i118:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i116
  %arrayidx.i.i.i117 = getelementptr inbounds %"class.std::ctype", ptr %33, i64 0, i32 9, i64 10
  %35 = load i8, ptr %arrayidx.i.i.i117, align 1, !tbaa !9
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit126

if.end.i.i.i122:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i116
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %33)
  %vtable.i.i.i119 = load ptr, ptr %33, align 8, !tbaa !23
  %vfn.i.i.i120 = getelementptr inbounds ptr, ptr %vtable.i.i.i119, i64 6
  %36 = load ptr, ptr %vfn.i.i.i120, align 8
  %call.i.i.i121 = call noundef signext i8 %36(ptr noundef nonnull align 8 dereferenceable(570) %33, i8 noundef signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit126

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit126: ; preds = %if.then.i4.i.i118, %if.end.i.i.i122
  %retval.0.i.i.i123 = phi i8 [ %35, %if.then.i4.i.i118 ], [ %call.i.i.i121, %if.end.i.i.i122 ]
  %call1.i124 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) %call10, i8 noundef signext %retval.0.i.i.i123)
  %call.i.i125 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %call1.i124)
  %arrayidx = getelementptr inbounds [200 x %"class.std::complex"], ptr %vec, i64 0, i64 %indvars.iv
  %call12 = call noundef nonnull align 8 dereferenceable(16) ptr @_ZStrsIdcSt11char_traitsIcEERSt13basic_istreamIT0_T1_ES6_RSt7complexIT_E(ptr noundef nonnull align 8 dereferenceable(16) @_ZSt3cin, ptr noundef nonnull align 8 dereferenceable(16) %arrayidx)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %37 = load i32, ptr %n, align 4, !tbaa !39
  %38 = sext i32 %37 to i64
  %cmp = icmp slt i64 %indvars.iv.next, %38
  br i1 %cmp, label %for.body, label %for.cond.cleanup, !llvm.loop !45

for.cond.cleanup17:                               ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit146, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit106
  call void @llvm.lifetime.end.p0(i64 3200, ptr nonnull %vec) #16
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %d) #16
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %n) #16
  ret i32 0

for.body18:                                       ; preds = %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit106, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit146
  %indvars.iv154 = phi i64 [ %indvars.iv.next155, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit146 ], [ 0, %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit106 ]
  %arrayidx20 = getelementptr inbounds [200 x %"class.std::complex"], ptr %vec, i64 0, i64 %indvars.iv154
  %call21 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsIdcSt11char_traitsIcEERSt13basic_ostreamIT0_T1_ES6_RKSt7complexIT_E(ptr noundef nonnull align 8 dereferenceable(8) @_ZSt4cout, ptr noundef nonnull align 8 dereferenceable(16) %arrayidx20)
  %vtable.i127 = load ptr, ptr %call21, align 8, !tbaa !23
  %vbase.offset.ptr.i128 = getelementptr i8, ptr %vtable.i127, i64 -24
  %vbase.offset.i129 = load i64, ptr %vbase.offset.ptr.i128, align 8
  %add.ptr.i130 = getelementptr inbounds i8, ptr %call21, i64 %vbase.offset.i129
  %_M_ctype.i.i131 = getelementptr inbounds %"class.std::basic_ios", ptr %add.ptr.i130, i64 0, i32 5
  %39 = load ptr, ptr %_M_ctype.i.i131, align 8, !tbaa !25
  %tobool.not.i.i.i132 = icmp eq ptr %39, null
  br i1 %tobool.not.i.i.i132, label %if.then.i.i.i133, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i136

if.then.i.i.i133:                                 ; preds = %for.body18
  call void @_ZSt16__throw_bad_castv() #18
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i136: ; preds = %for.body18
  %_M_widen_ok.i.i.i134 = getelementptr inbounds %"class.std::ctype", ptr %39, i64 0, i32 8
  %40 = load i8, ptr %_M_widen_ok.i.i.i134, align 8, !tbaa !36
  %tobool.not.i3.i.i135 = icmp eq i8 %40, 0
  br i1 %tobool.not.i3.i.i135, label %if.end.i.i.i142, label %if.then.i4.i.i138

if.then.i4.i.i138:                                ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i136
  %arrayidx.i.i.i137 = getelementptr inbounds %"class.std::ctype", ptr %39, i64 0, i32 9, i64 10
  %41 = load i8, ptr %arrayidx.i.i.i137, align 1, !tbaa !9
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit146

if.end.i.i.i142:                                  ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i.i136
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570) %39)
  %vtable.i.i.i139 = load ptr, ptr %39, align 8, !tbaa !23
  %vfn.i.i.i140 = getelementptr inbounds ptr, ptr %vtable.i.i.i139, i64 6
  %42 = load ptr, ptr %vfn.i.i.i140, align 8
  %call.i.i.i141 = call noundef signext i8 %42(ptr noundef nonnull align 8 dereferenceable(570) %39, i8 noundef signext 10)
  br label %_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit146

_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_.exit146: ; preds = %if.then.i4.i.i138, %if.end.i.i.i142
  %retval.0.i.i.i143 = phi i8 [ %41, %if.then.i4.i.i138 ], [ %call.i.i.i141, %if.end.i.i.i142 ]
  %call1.i144 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8) %call21, i8 noundef signext %retval.0.i.i.i143)
  %call.i.i145 = call noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8) %call1.i144)
  %indvars.iv.next155 = add nuw nsw i64 %indvars.iv154, 1
  %43 = load i32, ptr %n, align 4, !tbaa !39
  %44 = sext i32 %43 to i64
  %cmp16 = icmp slt i64 %indvars.iv.next155, %44
  br i1 %cmp16, label %for.body18, label %for.cond.cleanup17, !llvm.loop !46
}

declare noundef nonnull align 8 dereferenceable(16) ptr @_ZNSirsERi(ptr noundef nonnull align 8 dereferenceable(16), ptr noundef nonnull align 4 dereferenceable(4)) local_unnamed_addr #11

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSolsEi(ptr noundef nonnull align 8 dereferenceable(8), i32 noundef) local_unnamed_addr #11

declare noundef nonnull align 8 dereferenceable(16) ptr @_ZStrsIdcSt11char_traitsIcEERSt13basic_istreamIT0_T1_ES6_RSt7complexIT_E(ptr noundef nonnull align 8 dereferenceable(16), ptr noundef nonnull align 8 dereferenceable(16)) local_unnamed_addr #11

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZStlsIdcSt11char_traitsIcEERSt13basic_ostreamIT0_T1_ES6_RKSt7complexIT_E(ptr noundef nonnull align 8 dereferenceable(8), ptr noundef nonnull align 8 dereferenceable(16)) local_unnamed_addr #11

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare double @cos(double noundef) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare double @sin(double noundef) local_unnamed_addr #12

declare { double, double } @__divdc3(double, double, double, double) local_unnamed_addr

declare { double, double } @__muldc3(double, double, double, double) local_unnamed_addr

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(ptr noundef nonnull align 8 dereferenceable(8), ptr noundef, i64 noundef) local_unnamed_addr #11

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo3putEc(ptr noundef nonnull align 8 dereferenceable(8), i8 noundef signext) local_unnamed_addr #11

declare noundef nonnull align 8 dereferenceable(8) ptr @_ZNSo5flushEv(ptr noundef nonnull align 8 dereferenceable(8)) local_unnamed_addr #11

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() local_unnamed_addr #13

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(ptr noundef nonnull align 8 dereferenceable(570)) local_unnamed_addr #11

declare noundef nonnull align 8 dereferenceable(16) ptr @_ZNSi10_M_extractIdEERSiRT_(ptr noundef nonnull align 8 dereferenceable(16), ptr noundef nonnull align 8 dereferenceable(8)) local_unnamed_addr #11

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.ctpop.i32(i32) #14

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #15

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #14

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nofree nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nosync nounwind memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { inlinehint uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { mustprogress uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { norecurse uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { mustprogress nofree nounwind willreturn memory(write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { noreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #14 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #15 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #16 = { nounwind }
attributes #17 = { nounwind allocsize(0) }
attributes #18 = { noreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 16.0.4 (gh:llvm/llvm-project.git 3c1576cc0c54898ef180b4685896f3d7453bde6e)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{i32 0, i32 33}
!8 = !{i64 0, i64 16, !9}
!9 = !{!10, !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C++ TBAA"}
!12 = distinct !{!12, !6}
!13 = !{i64 0, i64 8, !9}
!14 = distinct !{!14, !6}
!15 = distinct !{!15, !6}
!16 = !{!"branch_weights", i32 1, i32 1048575}
!17 = distinct !{!17, !6}
!18 = distinct !{!18, !6}
!19 = distinct !{!19, !6, !20, !21}
!20 = !{!"llvm.loop.isvectorized", i32 1}
!21 = !{!"llvm.loop.unroll.runtime.disable"}
!22 = distinct !{!22, !6, !21, !20}
!23 = !{!24, !24, i64 0}
!24 = !{!"vtable pointer", !11, i64 0}
!25 = !{!26, !31, i64 240}
!26 = !{!"_ZTSSt9basic_iosIcSt11char_traitsIcEE", !27, i64 0, !31, i64 216, !10, i64 224, !35, i64 225, !31, i64 232, !31, i64 240, !31, i64 248, !31, i64 256}
!27 = !{!"_ZTSSt8ios_base", !28, i64 8, !28, i64 16, !29, i64 24, !30, i64 28, !30, i64 32, !31, i64 40, !32, i64 48, !10, i64 64, !33, i64 192, !31, i64 200, !34, i64 208}
!28 = !{!"long", !10, i64 0}
!29 = !{!"_ZTSSt13_Ios_Fmtflags", !10, i64 0}
!30 = !{!"_ZTSSt12_Ios_Iostate", !10, i64 0}
!31 = !{!"any pointer", !10, i64 0}
!32 = !{!"_ZTSNSt8ios_base6_WordsE", !31, i64 0, !28, i64 8}
!33 = !{!"int", !10, i64 0}
!34 = !{!"_ZTSSt6locale", !31, i64 0}
!35 = !{!"bool", !10, i64 0}
!36 = !{!37, !10, i64 56}
!37 = !{!"_ZTSSt5ctypeIcE", !38, i64 0, !31, i64 16, !35, i64 24, !31, i64 32, !31, i64 40, !31, i64 48, !10, i64 56, !10, i64 57, !10, i64 313, !10, i64 569}
!38 = !{!"_ZTSNSt6locale5facetE", !33, i64 8}
!39 = !{!33, !33, i64 0}
!40 = distinct !{!40, !6}
!41 = !{!42, !42, i64 0}
!42 = !{!"double", !10, i64 0}
!43 = distinct !{!43, !6, !20, !21}
!44 = distinct !{!44, !6, !21, !20}
!45 = distinct !{!45, !6}
!46 = distinct !{!46, !6}
