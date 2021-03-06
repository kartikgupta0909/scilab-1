// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2006-2009 - INRIA -Serge Steer
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- NOT FIXED -->
//
// <-- Non-regression test for bug 4024 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=4024
//
// <-- Short Description -->
//    The addition between empty matrix and and integer type array returns empty. 
//    This is not compatible with []+A -->A
mm=mtlb_mode();
mtlb_mode(%f)
if []+int32(2)<>int32(2) then pause,end
if int32(2)+[]<>int32(2) then pause,end
if []-int32(2)<>-int32(2) then pause,end
if int32(2)-[]<>int32(2) then pause,end
mtlb_mode(%t)
if []+int32(2)<>[] then pause,end
if int32(2)+[]<>[] then pause,end
if []-int32(2)<>[] then pause,end
if int32(2)-[]<>[] then pause,end
mtlb_mode(mm)
