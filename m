From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Tue, 27 Feb 2001 09:22:00 -0000
Message-id: <20010227182216.S4275@cygbert.vinschen.de>
References: <VA.0000062c.02a8582a@thesoftwaresource.com> <VA.0000066f.003b71be@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00126.html

Brian,

I have some difficulties to apply your patch cleanly. Would you please
send it again as diff -up relative to the current version from CVS?

Thanks,
Corinna

On Tue, Feb 20, 2001 at 10:23:30PM -0500, Brian Keener wrote:
> Okay,  trying this one more time - can't say I haven't tried.  Hope this one measures up. Again 
> sorry about sending the code as an attachment.
> 
> 2001-02-05  Brian Keener <bkeener@thesoftwaresource.com>
>    * choose.cc (paint): Modify message for nothing to download vs 
>    nothing to install/update based on installation method.
>    (list_click): Modify to skip versions in selection process if
>    installing from local directory and installation file does not exist.  
>    Also leaves Source Action set to N/A if the source file does not exist 
>    and installing from local directory.
>    (check_existence): New method to check current existence of installation
>    files based on selected installation method.
>    (set_existence): New method to set the current existence of installation
>    files based on selected installation method.
>    (best_trust): Modify decision process for best trust to base decision on
>    current trust selected (IE: Prev, Curr, or Test), existence of file and
>    installation method selected.
>    (default_trust): Add logic to capture the current trust level and the 
>    trust selected for the given package.
>    (set_full_list): Expand decision criteria for displaying a package in 
>    the selection list to include file existence/non-existence and selected
>    installation method.
>    (build_labels): Modify criteria for label addition to include
>    installation method and file existence/non-existence.
>    (create_listview): Modify to establish package trust level for each 
>    package before setting up the display list.  Also modification to set 
>    current trust button as the default.
>    (dialog_cmd): Set response for Prev, Curr, Test button push to perform
>    a reset of the selection list in addition to setting the default trust.
>    (get_package_version): New method to provide reusable code for
>    determining the package version from the file name for a specified
>    trust.
>    (scan2): Modify to use new method get_package_version and
>    also enhance handling of the build for the structures package and 
>    extra.
>    (read_installed_db): Modify to use the new method 
>    get_package_version and also enhance handling of the build for the 
>    structures package and extra.
>    (do_choose): Add additional initialization of package and extra 
>    structures.  Modify to use read_installed_db all the time despite 
>    install method.  Modify output to setup.log.full log file to increase 
>    readability by adding additional spacing, expanded code and available 
>    versions.        
>    * ini.h: Add new fields install_exists, source_exists and 
>    partial_list_display to the structure definition for package.
>    * res.rc (IDD_CHOOSE): Modify choose dialog Prev, Curr, and Test 
>    pushbuttons by replacing with Radio Buttons thus allowing the 
>    operator to better determine which is selected.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
