From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [patch] setup.exe changes for Redownload/Reinstall Current version or Sources only - Part 1
Date: Thu, 03 May 2001 14:06:00 -0000
Message-id: <VA.00000756.0015edd1@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00188.html

Here is the patch I promised to allow setup.exe to download only sources when needed and to 
allow for the Redownloading or Reinstalling of the current version.

This is part 1 (ChangeLog Entry) - Part 2 will follow with the actual diff.

bk

2001-05-03  Brian Keener <bkeener@thesoftwaresource.com>

   * resource.h: Add new field IDC_CHOOSE_INST_TEXT.  Modify 
   _APS_NEXT_CONTROL_VALUE to account for addition of IDC_CHOOSE_INST_TEXT.
   * res.rc (IDD_CHOOSE): Modify choose dialog to use new field
   IDC_CHOOSE_INST_TEXT for screen text.  Modify choose Dialog to allow hot
   keys to select Prev, Curr, Exp.
   * ini.h: Add new actions for ACTION_REDO and ACTION_SRC_ONLY.  Modify
   define for LOOP_PACKAGES to include new actions ACTION_REDO and 
   ACTION_SRC_ONLY.
   * choose.cc:  Add new Trusts for TRUST_REDO and TRUST_SRC_ONLY. 
   (paint):  Modify to check TRUST_SRC_ONLY when determining Bitmap for 
   source Checkbox to use. 
   (build_labels):  Add logic to allow for selection of Source only 
   Download/ReDownload/Install/Reinstall and also to Redownload/Reinstall 
   current version binary.
   (dialog_proc): Add conditional display for file selection prompt based 
   on download vs install using IDC_CHOOSE_INST_TEXT.  
   (do_choose):  Add new logic for TRUST_REDO and TRUST_SRC_ONLY selection 
   and modify logic for TRUST_UNINSTALL, TRUST_KEEP, and TRUST_NONE to
   handle the instance where Source Download/Install was selected.  Modify
   log file to store appropriate information regarding Action selected and
   the new actions that were added (I.E.: ACTION_REDO and ACTION_SRC_ONLY).
   * download.cc:  Add include for <unistd.h> and "port.h". 
   (download_one):  Modify parameter list to include the selected action
   for the file to be downloaded.  Modify size check against expected 
   size to include check for ACTION_REDO and ACTION_SRC_ONLY.  Modify 
   rename of .tmp file to also remove the destination file if exists due to
   ability to redownload source and binary now.
   (do_download):  Modify to also use ACTION_REDO and ACTION_SRC_ONLY in
   calculation of Download Bytes.  Modify to also use ACTION_REDO and
   ACTION_SRC_ONLY in determining files selected for download. 
   * install.cc (uninstall_one):  Add check to treat a Reinstall like an
   upgrade so current version will be uninstalled prior to reinstall.
   (do_install):  Add logic to handle ACTION_REDO and ACTION_SRC_ONLY for
   uninstalling and installing binary and source packages.
   * desktop.cc (make_passwd_group):  Modify logic to account for a Source
   only cygwin install when checking for cygwin to determine need for 
   mkpasswd and mkgroup.


