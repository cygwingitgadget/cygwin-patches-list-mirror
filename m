From: Christopher Faylor <cgf@redhat.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Tue, 06 Feb 2001 18:40:00 -0000
Message-id: <20010206214102.B14711@redhat.com>
References: <VA.0000062c.02a8582a@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00050.html

On Tue, Feb 06, 2001 at 09:05:18PM -0500, Brian Keener wrote:
>The following change enhances the Setup.exe selection criteria for which 
>files to show in the partial/full lists so that the selection criteria 
>now include the installation method selected and the 
>existence/non-existence of the installation file for each package as well 
>as slightly different logic on Prev, Curr, and Test.
>     
>Sorry about the fact the attachment but the code diff was bigger than my 
>email would allow me to send  but here is the Changelog entry

This looks good but, please check out the Contributing section of the
web page.  It contains a link and some hints on ChangeLog formatting.
This one is a little "off", unfortunately.

I'll leave it to DJ to approve this change though, since it is so
substantial.

cgf

>2001-02-05  Brian Keener   <bkeener@thesoftwaresource.com>
>        *  choose.cc (paint) : modified message for nothing to download  
>        vs nothing to install/update.
>        (list_click) : modified to skip versions in selection process if 
>        installing from local directory and installation file does not   
>        exist. Also leaves Source Action set to N/A if the source file   
>        does not exist and installing from local directory.
>        (check_existance) : new method to check current existence of
>        installation files based on selected installation method.
>        (set_existance) : new method to set the current existence of 
>        installation files based on selected installation method.
>        (best_trust) : decision process modified for best trust to base 
>        decision on current trust selected (IE: prev, curr, or test) and
>        existence of file and installation method selected.
>        (default_trust) : added logic to capture the current trust level 
>        and the trust selected for the given package.
>        (set_full_list) : expanded the decision criteria for displaying a 
>        package in the selection list to include existence/non-existance 
>        of the file and the selected installation method.
>        (build_labels) : modified criteria for label addition to include
>        installation method and file existence/non-existance.
>        (create_listview) : modification to establish the trust on       
>        packages before setting up the display list.  Also modification  
>        to set Current trust button as the default.
>        (dialog_cmd) : set response for Prev, Curr, Test button push to  
>        perform a reset of the selection list as well as setting the     
>        default trust.
>        (scan2) : modification to use the new method get_package_version 
>        and also enhanced handling of the build for the structures       
>        package and extra.
>        (get_package_version) : new method to provide for reusable code  
>        for determining the package version from the file name for a     
>        specified trust.
>        (read_installed_db) : modification to use the new method 
>        get_package_version and also enhanced handling of the build for  
>        the structures package and extra.
>        (do_choose) : modification for additional initialization of      
>        package and extra structures.  Uses read_installed_db all the    
>        time despite install method.  Enhancement and changes to output  
>        display for expanded code meanings and clarified output for      
>        packages and available versions in the setup.log.full log file.
>        *  ini.h :  added install_exists and source_exists and           
>        in_partial_list to the structure definition for package.
>        *  res.rc (IDD_CHOOSE) : Modify to choose dialog such that Prev, 
>        Curr, and Test pushbuttons become Radio Buttons instead thus     
>        allowing the operator to better determine which is selected.
