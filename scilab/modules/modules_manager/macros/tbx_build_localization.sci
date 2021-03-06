// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - Scilab Enterprises - Antoine ELIAS
//
// Copyright (C) 2012 - 2016 - Scilab Enterprises
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.

function tbx_build_localization(tbx_name, tbx_path)

    rhs = argn(2);

    if and(rhs <> [1 2]) then
        error(msprintf(gettext("%s: Wrong number of input arguments: %d to %d expected.\n"),"tbx_build_localization",1,2));
    end

    if type(tbx_name) <> 10 then
        error(tbx_name(gettext("%s: Wrong type for input argument #%d: A string array expected.\n"),"tbx_build_localization",1));
    end

    if rhs < 2 then
        tbx_path = pwd();
    else
        if type(tbx_path) <> 10 then
            error(msprintf(gettext("%s: Wrong type for input argument #%d: string expected.\n"),"tbx_build_localization",2));
        end

        if size(tbx_path,"*") <> 1 then
            error(msprintf(gettext("%s: Wrong size for input argument #%d: string expected.\n"),"tbx_build_localization",2));
        end

        if ~isdir(tbx_path) then
            error(msprintf(gettext("%s: The directory ''%s'' doesn''t exist or is not read accessible.\n"),"tbx_build_localization", tbx_path));
        end
    end

    //forge command
    localePath = tbx_path + "locales/";

    if isdir(localePath) == %f then
        error(msprintf(gettext("%s: The directory ''%s'' doesn''t exist or is not read accessible.\n"),"tbx_build_localization",localePath));
    end

    //find list of .po files
    poFiles = gsort(findfiles(localePath, "*.po"), "lr", "i");

    if getos() == "Windows" then
        cmd = SCI + filesep() + "tools/gettext/msgfmt";
    else
        cmd = "msgfmt";
    end

    mprintf(gettext("Generating localization\n"));
    for i=1:size(poFiles, "*")
        //generate moFile name and path
        lang = fileparts(poFiles(i), "fname");
        printf("-- Building for ""%s"" --\n", lang);
        moFile = localePath + lang + "/LC_MESSAGES/";
        mkdir(moFile); //to be sure path exists
        poFile = moFile + tbx_name + ".po";
        moFile = moFile + tbx_name + ".mo";


        //check mo file is newest po, don't need to generate it
        if newest(poFiles(i), moFile) == 1 then
            copyfile(localePath + poFiles(i), poFile);
            cmd1 = cmd + " -o " + moFile + " " + poFile;
            host(cmd1)
        end
    end
endfunction
