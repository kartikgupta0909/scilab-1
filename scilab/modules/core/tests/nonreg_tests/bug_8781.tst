// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2014 - Scilab Enterprises - Charlotte HECQUET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- Non-regression test for bug 8781 -->
//
// <-- CLI SHELL MODE -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/8781
//
// <-- Short Description -->
// Calling error with complex value is ok for Scilab

msg1 = msprintf(gettext("%s: Wrong type for input argument #%d.\n"), "error", 1);
msg1bis = msprintf(gettext("%s: Wrong type for input argument #%d: string expected.\n"), "error", 1);
msg2 = msprintf(gettext("%s: Wrong type for input argument #%d.\n"), "error", 2);
assert_checkerror("error(1+%i)", msg1bis);
assert_checkerror("error(%i, 1)", msg2);
assert_checkerror("error(45+%i, [''A''; ''multi'';''line'';''error'';''message''])", msg1);
assert_checkerror("error(52, %i)", msg2);
