From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@sources.redhat.com
Subject: [patch]  Setup.exe size change for site selection dialog
Date: Wed, 13 Sep 2000 21:10:00 -0000
Message-id: <VA.000004f7.00593c5a@thesoftwaresource.com>
X-SW-Source: 2000-q3/msg00091.html

2000-09-06  Brian Keener  <bkeener@thesoftwaresource.com>

        * res.rc: increased the size of the site dialog (IDD_SITE) & the 
   corresponding list box to provide for more URL's to be listed.  
   Modified the position of the Back, Next and Cancel buttons to 
   correspond to the new size of the dialog.


Index: res.rc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v
retrieving revision 2.6
diff -p -2 -r2.6 res.rc
*** res.rc 2000/09/08 00:14:21 2.6
--- res.rc 2000/09/14 03:04:12
*************** BEGIN
*** 83,97 ****
  END
  
! IDD_SITE DIALOG DISCARDABLE  0, 0, 215, 95
  STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU
  CAPTION "Cygwin Setup"
  FONT 8, "MS Sans Serif"
  BEGIN
!     DEFPUSHBUTTON   "Next -->",IDOK,100,75,45,15
!     PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15
      LTEXT           "Select Download Site",IDC_STATIC,55,5,135,11
!     PUSHBUTTON      "<-- Back",IDC_BACK,55,75,45,15
      ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20
!     LISTBOX         IDC_URL_LIST,55,20,155,51,LBS_NOINTEGRALHEIGHT | 
                      WS_VSCROLL | WS_HSCROLL | WS_TABSTOP
  END
--- 83,97 ----
  END
  
! IDD_SITE DIALOG DISCARDABLE  0, 0, 222, 206
  STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU
  CAPTION "Cygwin Setup"
  FONT 8, "MS Sans Serif"
  BEGIN
!     DEFPUSHBUTTON   "Next -->",IDOK,105,185,45,15
!     PUSHBUTTON      "Cancel",IDCANCEL,170,185,45,15
      LTEXT           "Select Download Site",IDC_STATIC,55,5,135,11
!     PUSHBUTTON      "<-- Back",IDC_BACK,60,185,45,15
      ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20
!     LISTBOX         IDC_URL_LIST,55,20,160,155,LBS_NOINTEGRALHEIGHT | 
                      WS_VSCROLL | WS_HSCROLL | WS_TABSTOP
  END



