// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA
// Copyright (C) ENPC
//
// Copyright (C) 2012 - 2016 - Scilab Enterprises
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

function getd(path,option)

    // get all .sci files in the specified directory

    [lhs,rhs]=argn(0);

    if rhs<=0 then
        path="./";
    end

    // convert path according to getos() == 'Windows' flag
    // and with env var substitutions
    path = pathconvert(path,%t,%t);

    // list the sci files
    lst          = listfiles(path+"*.sci",%f);
    lst_filtered = [];

    // remove wrong files extension
    // bug 2289

    for i=1:size(lst,"*")
        if( regexp(lst(i),"/.sci$/") <> [] ) then
            lst_filtered = [lst_filtered;lst(i)];
        end
    end

    lst = lst_filtered;
    clear lst_filtered;

    if lst==[] | lst== "" then
        error(msprintf(gettext("%s: I cannot find any files with extension %s in %s\n"),"getd",".sci",path));
        return ;
    end

    old = who("get");
    //prot = funcprot();funcprot(0)

    for k=1:size(lst,"*");
        if fileparts(lst(k),"extension")==".sci" then
            if execstr("exec(lst(k));","errcatch")<>0 then
                warning(msprintf(gettext("%s: Incorrect function in file %s.\n"),"getd",lst(k)))
            end
        end
    end

    //funcprot(prot);
    new = who("get");
    for i=1:size(old, "*")
        b = find(new == old(i));
        if isempty(b) == %f then
            new(b) = [];
        end
    end

    //new = new(1:(size(new,"*")-nold-2));  // -4 becomes -2: fix the fix for bug 2807
    if new<>[] then
        execstr("["+strcat(new,",")+"]=resume("+strcat(new,",")+")")
    end

endfunction
