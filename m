From: Christopher Faylor <cgf@redhat.com>
To: cygwin patches <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Wed, 07 Feb 2001 19:42:00 -0000
Message-id: <20010207224256.A22298@redhat.com>
References: <200102070226.VAA23607@envy.delorie.com> <VA.00000633.00299ba0@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00066.html

Deja vu.

"This looks good but, please check out the Contributing section of the
web page.  It contains a link and some hints on ChangeLog formatting.
This one is a little 'off', unfortunately."

cgf

On Wed, Feb 07, 2001 at 10:35:27PM -0500, Brian Keener wrote:
>Okay I will try this again.  The following change enhances the Setup.exe 
>selection criteria for which files to show in the partial/full lists so 
>that the selection criteria now include the installation method selected 
>and the existence/non-existence of the installation file for each package 
>as well as slightly different logic on Prev, Curr, and Test.  No,  the 
>basic scheme still works they way it did.  The difference is what is 
>displayed and whether they are shown as needing updating or if they 
>default to skip or keep.  If I am in partial list then it comes up by 
>default with current selected like it did and if I selected an install 
>method of Netinstall then all packages with a current that is not 
>currently installed would be displayed.  On the other hand if I selected 
>download then only packages with a current version that is not 
>installed and does not already exist on my local drive would be displayed 
>for selection and if I selected install from local directory then only 
>those whose current install file existed on disk and where the 
>current version is not installed would be displayed.  This same logic 
>follows if I then selected Prev or Test the selection list changes 
>accordingly.
>
>Sorry about the fact that I use and attachment but the code diff was 
>bigger than my email would allow me to send  but here is the Changelog 
>entry
>
>2001-02-05  Brian Keener   <bkeener@thesoftwaresource.com>
>        *  choose.cc (paint) : modified message for nothing to download  
>        vs nothing to install/update.
>        (list_click) : modified to skip versions in selection process if 
>        installing from local directory and installation file does not   
>        exist.  Also leaves Source Action set to N/A if the source file  
>        does not exist and installing from local directory.
>        (check_existence) : new method to check current existence of
>        installation files based on selected installation method.
>        (set_existence) : new method to set the current existence of 
>        installation files based on selected installation method.
>        (best_trust) : decision process modified for best trust to base 
>        decision on current trust selected (IE: prev, curr, or test) and
>        existence of file and installation method selected.
>        (default_trust) : added logic to capture the current trust level 
>        and the trust selected for the given package.
>        (set_full_list) : expanded the decision criteria for displaying a 
>        package in the selection list to include existence/non-existence 
>        of the file and the selected installation method.
>        (build_labels) : modified criteria for label addition to include
>        installation method and file existence/non-existence.
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
>        partial_list_display to the structure definition for package.
>        *  res.rc (IDD_CHOOSE) : Modify to choose dialog such that Prev, 
>        Curr, and Test pushbuttons become Radio Buttons instead thus     
>        allowing the operator to better determine which is selected.
>
>
>



-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
