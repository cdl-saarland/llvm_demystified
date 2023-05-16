; ModuleID = 'div.ll'
source_filename = "div.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: mustprogress nofree nosync nounwind willreturn memory(none) uwtable
define dso_local noundef i32 @_Z6dividejj(i32 noundef %N, i32 noundef %D) local_unnamed_addr #0 {
entry:
  %0 = tail call i32 @llvm.ctlz.i32(i32 %D, i1 false), !range !5
  %1 = tail call i32 @llvm.ctlz.i32(i32 %N, i1 false), !range !5
  %sub = sub nsw i32 %0, %1
  %cmp21.not = icmp eq i32 %N, 0
  br i1 %cmp21.not, label %for.cond.cleanup, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %entry
  %sub3 = sub nuw nsw i32 32, %1
  %shl = shl i32 %D, %sub
  %conv4 = zext i32 %shl to i64
  %smax = tail call i32 @llvm.smax.i32(i32 %sub3, i32 1)
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %Q.0.lcssa = phi i32 [ 0, %entry ], [ %shl9, %for.body ]
  %shr = lshr i32 %Q.0.lcssa, %sub
  ret i32 %shr

for.body:                                         ; preds = %for.body, %for.body.lr.ph
  %N.addr.024 = phi i32 [ %N, %for.body.lr.ph ], [ %shl8, %for.body ]
  %i.023 = phi i32 [ 0, %for.body.lr.ph ], [ %inc, %for.body ]
  %Q.022 = phi i32 [ 0, %for.body.lr.ph ], [ %shl9, %for.body ]
  %conv = zext i32 %N.addr.024 to i64
  %sub5 = sub nsw i64 %conv, %conv4
  %cmp6 = icmp sgt i64 %sub5, -1
  %conv7 = trunc i64 %sub5 to i32
  %or = zext i1 %cmp6 to i32
  %Q.1 = or i32 %Q.022, %or
  %N.addr.1 = select i1 %cmp6, i32 %conv7, i32 %N.addr.024
  %shl8 = shl i32 %N.addr.1, 1
  %shl9 = shl i32 %Q.1, 1
  %inc = add nuw nsw i32 %i.023, 1
  %exitcond.not = icmp eq i32 %inc, %smax
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !6
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.ctlz.i32(i32, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #1

attributes #0 = { mustprogress nofree nosync nounwind willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="znver4" "target-features"="+adx,+aes,+avx,+avx2,+avx512bf16,+avx512bitalg,+avx512bw,+avx512cd,+avx512dq,+avx512f,+avx512ifma,+avx512vbmi,+avx512vbmi2,+avx512vl,+avx512vnni,+avx512vpopcntdq,+bmi,+bmi2,+clflushopt,+clwb,+clzero,+crc32,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+gfni,+invpcid,+lzcnt,+mmx,+movbe,+mwaitx,+pclmul,+pku,+popcnt,+prfchw,+rdpid,+rdpru,+rdrnd,+rdseed,+sahf,+sha,+shstk,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+sse4a,+ssse3,+vaes,+vpclmulqdq,+wbnoinvd,+x87,+xsave,+xsavec,+xsaveopt,+xsaves" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.linker.options = !{}
!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"Debian clang version 16.0.2 (++20230405063154+02aa966c1351-1~exp1~20230405063253.70)"}
!5 = !{i32 0, i32 33}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
