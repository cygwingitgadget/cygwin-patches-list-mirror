Return-Path: <cygwin-patches-return-1878-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21897 invoked by alias); 24 Feb 2002 07:28:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21864 invoked from network); 24 Feb 2002 07:28:57 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: "Cygwin-Patches" <cygwin-patches@sources.redhat.com>
Subject: [PATCH] Percent complete in Setup.exe window title.
Date: Sun, 24 Feb 2002 00:26:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKAEOKCKAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C1BCD2.A117F360"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00235.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C1BCD2.A117F360
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 839

This one goes good with the new minimizeability of Setup.exe:

2002-02-24  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* res.rc (STRINGTABLE): Add IDS_CYGWIN_SETUP and
	IDS_CYGWIN_SETUP_WITH_PROGRESS strings.
	* resource.h: Add IDS_CYGWIN_SETUP and
	IDS_CYGWIN_SETUP_WITH_PROGRESS IDs.

	* splash.cc (OnInit): Qualify SetWindowText() call with global scope
	operator (::SetWindowText()).

	* threebar.cc: Run indent.
	(cistring.h): Add include.
	(SetText1, SetText2, SetText3): Qualify SetWindowText() call with
	global scope operator.
	(SetBar2): Add logic for writing percent complete into window title.

	* window.h: Run indent.
	(SetWindowText): New function.
	(String): Add forward declaration.
	* window.cc: Run indent.
	(String++.h): Add include.
	(SetWindowText): New function.

-- 
Gary R. Van Sickle
Brewer.  Patriot. 
------=_NextPart_000_0000_01C1BCD2.A117F360
Content-Type: application/octet-stream;
	name="setup-pct-title.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setup-pct-title.diff"
Content-length: 7937

? cinstall-mac-020202-1.patch=0A=
? cinstall-mac-020202-2.patch=0A=
? res.aps=0A=
? Strings.patch=0A=
Index: res.rc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v=0A=
retrieving revision 2.36=0A=
diff -p -u -r2.36 res.rc=0A=
--- res.rc	2002/02/18 12:35:23	2.36=0A=
+++ res.rc	2002/02/24 07:20:37=0A=
@@ -92,7 +92,7 @@ BEGIN=0A=
                     7,0,258,8,NOT WS_GROUP=0A=
 END=0A=
=20=0A=
-IDD_SITE DIALOG DISCARDABLE 0, 0, 317, 179=0A=
+IDD_SITE DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
     WS_CAPTION | WS_SYSMENU=0A=
 EXSTYLE WS_EX_CONTROLPARENT=0A=
@@ -462,6 +462,10 @@ BEGIN=0A=
     IDS_ERR_RENAME          "Can't rename %s to %s: %s"=0A=
     IDS_NOTHING_INSTALLED   "Nothing needed to be installed"=0A=
     IDS_INSTALL_COMPLETE    "Installation Complete"=0A=
+END=0A=
+=0A=
+STRINGTABLE DISCARDABLE=20=0A=
+BEGIN=0A=
     IDS_REBOOT_REQUIRED     "In-use files have been replaced. You need to =
reboot as soon as possible to activate the new versions. Cygwin may operate=
 incorrectly until you reboot."=0A=
 END=0A=
=20=0A=
@@ -480,6 +484,8 @@ BEGIN=0A=
     IDS_DOWNLOAD_INCOMPLETE "Download Incomplete.  Try again?"=0A=
     IDS_INSTALL_INCOMPLETE  "Installation incomplete.  Check /setup.log.fu=
ll for details"=0A=
     IDS_VERSION_INFO        "Setup.exe version %1"=0A=
+    IDS_CYGWIN_SETUP        "Cygwin Setup"=0A=
+    IDS_CYGWIN_SETUP_WITH_PROGRESS "%1!d!%% - Cygwin Setup"=0A=
 END=0A=
=20=0A=
 #endif    // English (U.S.) resources=0A=
Index: resource.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/resource.h,v=0A=
retrieving revision 2.16=0A=
diff -p -u -r2.16 resource.h=0A=
--- resource.h	2002/01/19 13:33:17	2.16=0A=
+++ resource.h	2002/02/24 07:20:37=0A=
@@ -28,6 +28,8 @@=0A=
 #define IDS_DOWNLOAD_INCOMPLETE         26=0A=
 #define IDS_INSTALL_INCOMPLETE          27=0A=
 #define IDS_VERSION_INFO                28=0A=
+#define IDS_CYGWIN_SETUP                29=0A=
+#define IDS_CYGWIN_SETUP_WITH_PROGRESS  30=0A=
 #define IDD_ROOT                        101=0A=
 #define IDD_SOURCE                      102=0A=
 #define IDD_OTHER_URL                   103=0A=
@@ -111,7 +113,7 @@=0A=
 #define IDC_STATIC_WELCOME_TITLE        1061=0A=
 #define IDC_EDIT_USER_URL               1062=0A=
 #define IDC_BUTTON_ADD_URL              1063=0A=
-#define IDS_REBOOT_REQUIRED		1064=0A=
+#define IDS_REBOOT_REQUIRED             1064=0A=
 #define IDC_STATIC                      -1=0A=
=20=0A=
 // Next default values for new objects=0A=
Index: splash.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/splash.cc,v=0A=
retrieving revision 2.8=0A=
diff -p -u -r2.8 splash.cc=0A=
--- splash.cc	2002/01/03 11:27:11	2.8=0A=
+++ splash.cc	2002/02/24 07:20:38=0A=
@@ -35,7 +35,7 @@ SplashPage::OnInit ()=0A=
=20=0A=
   ver.Format (IDS_VERSION_INFO, version[0] ? version : "[unknown]");=0A=
=20=0A=
-  SetWindowText (GetDlgItem (IDC_VERSION), ver.c_str ());=0A=
+  ::SetWindowText (GetDlgItem (IDC_VERSION), ver.c_str ());=0A=
=20=0A=
   // Set the font for the IDC_STATIC_WELCOME_TITLE=0A=
   SetDlgItemFont(IDC_STATIC_WELCOME_TITLE, "Ariel", 12, FW_BOLD);=0A=
Index: threebar.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/threebar.cc,v=0A=
retrieving revision 2.2=0A=
diff -p -u -r2.2 threebar.cc=0A=
--- threebar.cc	2002/01/03 11:27:11	2.2=0A=
+++ threebar.cc	2002/02/24 07:20:38=0A=
@@ -25,9 +25,9 @@=0A=
=20=0A=
 #include "propsheet.h"=0A=
 #include "threebar.h"=0A=
+#include "cistring.h"=0A=
=20=0A=
-bool=0A=
-ThreeBarProgressPage::Create ()=0A=
+bool ThreeBarProgressPage::Create ()=0A=
 {=0A=
   return PropertyPage::Create (IDD_INSTATUS);=0A=
 }=0A=
@@ -52,19 +52,19 @@ ThreeBarProgressPage::OnInit ()=0A=
 void=0A=
 ThreeBarProgressPage::SetText1 (const TCHAR * t)=0A=
 {=0A=
-  SetWindowText (ins_action, t);=0A=
+  ::SetWindowText (ins_action, t);=0A=
 }=0A=
=20=0A=
 void=0A=
 ThreeBarProgressPage::SetText2 (const TCHAR * t)=0A=
 {=0A=
-  SetWindowText (ins_pkgname, t);=0A=
+  ::SetWindowText (ins_pkgname, t);=0A=
 }=0A=
=20=0A=
 void=0A=
 ThreeBarProgressPage::SetText3 (const TCHAR * t)=0A=
 {=0A=
-  SetWindowText (ins_filename, t);=0A=
+  ::SetWindowText (ins_filename, t);=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -79,6 +79,9 @@ ThreeBarProgressPage::SetBar2 (long prog=0A=
 {=0A=
   int percent =3D (int) (100.0 * ((double) progress) / (double) max);=0A=
   SendMessage (ins_iprogress, PBM_SETPOS, (WPARAM) percent, 0);=0A=
+  cistring s;=0A=
+  s.Format (IDS_CYGWIN_SETUP_WITH_PROGRESS, percent);=0A=
+  GetOwner ()->SetWindowText (s.c_str ());=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -126,7 +129,7 @@ ThreeBarProgressPage::OnActivate ()=0A=
 }=0A=
=20=0A=
 bool=0A=
-ThreeBarProgressPage::OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lPara=
m)=0A=
+  ThreeBarProgressPage::OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lPa=
ram)=0A=
 {=0A=
   switch (uMsg)=0A=
     {=0A=
Index: window.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/window.cc,v=0A=
retrieving revision 2.3=0A=
diff -p -u -r2.3 window.cc=0A=
--- window.cc	2002/01/03 11:27:11	2.3=0A=
+++ window.cc	2002/02/24 07:20:39=0A=
@@ -19,6 +19,7 @@=0A=
=20=0A=
 #include <windows.h>=0A=
 #include "window.h"=0A=
+#include "String++.h"=0A=
=20=0A=
 ATOM Window::WindowClassAtom =3D 0;=0A=
 HINSTANCE Window::AppInstance =3D NULL;=0A=
@@ -314,4 +315,10 @@ bool=0A=
   FontCounter++;=0A=
=20=0A=
   return true;=0A=
+}=0A=
+=0A=
+void=0A=
+Window::SetWindowText (const String & s)=0A=
+{=0A=
+  ::SetWindowText (WindowHandle, s.cstr_oneuse ());=0A=
 }=0A=
Index: window.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/window.h,v=0A=
retrieving revision 2.3=0A=
diff -p -u -r2.3 window.h=0A=
--- window.h	2002/01/03 11:27:11	2.3=0A=
+++ window.h	2002/02/24 07:20:39=0A=
@@ -22,6 +22,8 @@=0A=
=20=0A=
 #include <windows.h>=0A=
=20=0A=
+class String;=0A=
+=0A=
 class Window=0A=
 {=0A=
   static ATOM WindowClassAtom;=0A=
@@ -84,8 +86,9 @@ public:=0A=
   {=0A=
     return::GetDlgItem (GetHWND (), id);=0A=
   };=0A=
-  bool SetDlgItemFont(int id, const TCHAR *fontname, int Pointsize,=0A=
-	  int Weight =3D FW_NORMAL, bool Italic =3D false, bool Underline =3D fal=
se, bool Strikeout =3D false);=0A=
+  bool SetDlgItemFont (int id, const TCHAR * fontname, int Pointsize,=0A=
+		       int Weight =3D FW_NORMAL, bool Italic =3D=0A=
+		       false, bool Underline =3D false, bool Strikeout =3D false);=0A=
=20=0A=
   UINT IsButtonChecked (int nIDButton) const;=0A=
=20=0A=
@@ -104,6 +107,9 @@ public:=0A=
=20=0A=
   // Center the window on the parent, or on screen if no parent.=0A=
   void CenterWindow ();=0A=
+=0A=
+  // Set the title of the window.=0A=
+  void SetWindowText (const String & s);=0A=
=20=0A=
 };=0A=
=20=0A=

------=_NextPart_000_0000_01C1BCD2.A117F360
Content-Type: application/octet-stream;
	name="ChangeLog.setup.grvs"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.setup.grvs"
Content-length: 822

2002-02-24  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>=0A=
=0A=
	* res.rc (STRINGTABLE): Add IDS_CYGWIN_SETUP and=0A=
	IDS_CYGWIN_SETUP_WITH_PROGRESS strings.=0A=
	* resource.h: Add IDS_CYGWIN_SETUP and=0A=
	IDS_CYGWIN_SETUP_WITH_PROGRESS IDs.=0A=
=0A=
	* splash.cc (OnInit): Qualify SetWindowText() call with global scope=0A=
	operator (::SetWindowText()).=0A=
=0A=
	* threebar.cc: Run indent.=0A=
	(cistring.h): Add include.=0A=
	(SetText1, SetText2, SetText3): Qualify SetWindowText() call with=0A=
	global scope operator.=0A=
	(SetBar2): Add logic for writing percent complete into window title.=0A=
=0A=
	* window.h: Run indent.=0A=
	(SetWindowText): New function.=0A=
	(String): Add forward declaration.=0A=
	* window.cc: Run indent.=0A=
	(String++.h): Add include.=0A=
	(SetWindowText): New function.=0A=

------=_NextPart_000_0000_01C1BCD2.A117F360--
