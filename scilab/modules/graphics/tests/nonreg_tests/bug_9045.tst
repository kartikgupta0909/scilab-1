// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - Calixte DENIZET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->

// <-- Non-regression test for bug 9045 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/9045
//
// <-- Short Description -->
// plot2d did not support overloading

if execstr("plot2d(int32(1:10),int32(1:10))", "errcatch") <> 0 then pause, end