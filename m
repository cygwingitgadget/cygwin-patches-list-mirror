Return-Path: <cygwin-patches-return-2017-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9418 invoked by alias); 2 Apr 2002 10:27:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9398 invoked from network); 2 Apr 2002 10:27:13 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: "Cygwin-Patches" <cygwin-patches@sources.redhat.com>
Subject: [PATCH] Setup Chooser integration
Date: Tue, 02 Apr 2002 02:27:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKOEJBCMAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C1D9FE.A98104D0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00001.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C1D9FE.A98104D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1742

ALT-TAB no longer!  This patch integrates the chooser into the wizard interface,
eliminating a field-expedient thread in the process.  Changelog also attached:

2002-04-02  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>

	* choose.cc: Run indent.
	(nextbutton): Remove static variable.
	(default_trust): Remove use of nextbutton.
	(set_view_mode): Ditto.
	(create_listview): Add IDC_CHOOSE_PREV and IDC_CHOOSE_NEXT to ta[] so
	rbset() sets the prev/next/curr radio buttons properly.
	(dialog_cmd): Delete function.
	(dialog_proc): Delete function.  Move WM_INITDIALOG functionality to
	ChooserPage::OnInit.
	(do_choose): Delete function.  Move pre-DialogBox() code to
	ChooserPage::OnInit(), post-DialogBox() code to	ChooserPage::OnNext.
	(WM_APP_START_CHOOSE): Remove define.
	(WM_APP_CHOOSE_IS_FINISHED): Remove define.
	(do_choose_thread): Delete function.
	(ChooserPage::OnActivate): Delete method.
	(ChooserPage::OnMessageApp): Delete method.
	(ChooserPage::OnInit): New method.
	(ChooserPage::OnNext): New method.
	(ChooserPage::OnBack): New method.
	(ChooserPage::OnMessageCmd): New method.
	* choose.h: Run indent.
	(ChooserPage::OnMessageApp): Delete declaration.
	(ChooserPage::OnActivate): Ditto.
	(ChooserPage::OnMessageCmd): New declaration.
	(ChooserPage::OnInit): Ditto.
	(ChooserPage::OnNext): Ditto.
	(ChooserPage::OnBack): Ditto.
	* desktop.cc (DesktopSetupPage::OnBack): Replace use of IDD_CHOOSER
	with IDD_CHOOSE.
	* fromcwd.cc (do_fromcwd): Replace use of IDD_CHOOSER with IDD_CHOOSE.
	* ini.cc (do_ini_thread): Replace use of IDD_CHOOSER with IDD_CHOOSE.
	* res.rc (IDD_CHOOSE): Remove dialog template.
	(IDD_CHOOSER): Alter dialog template to fit wizard size and format.

--
Gary R. Van Sickle
Brewer.  Patriot.

------=_NextPart_000_0005_01C1D9FE.A98104D0
Content-Type: application/octet-stream;
	name="setup-chooser-integration.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setup-chooser-integration.diff"
Content-length: 19300

? GRVSChangeLog=0A=
? res.aps=0A=
Index: choose.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v=0A=
retrieving revision 2.91=0A=
diff -p -u -r2.91 choose.cc=0A=
--- choose.cc	2002/03/20 08:16:38	2.91=0A=
+++ choose.cc	2002/04/02 10:18:35=0A=
@@ -64,7 +64,7 @@ extern ThreeBarProgressPage Progress;=0A=
=20=0A=
 static int initialized =3D 0;=0A=
=20=0A=
-static HWND lv, nextbutton, choose_inst_text;=0A=
+static HWND lv, choose_inst_text;=0A=
 static PickView *chooser =3D NULL;=0A=
=20=0A=
 static void set_view_mode (HWND h, PickView::views mode);=0A=
@@ -280,8 +280,8 @@ set_existence ()=0A=
       while (o <=3D pkg.versions.number () && !mirrors)=0A=
 	{=0A=
 	  packageversion & ver =3D *pkg.versions[o];=0A=
-	  if (((source !=3D IDC_SOURCE_CWD) && (ver.bin.sites.number ()=20=0A=
-	      || ver.src.sites.number ()))=0A=
+	  if (((source !=3D IDC_SOURCE_CWD) && (ver.bin.sites.number ()=0A=
+					      || ver.src.sites.number ()))=0A=
 	      || ver.bin.Cached () || ver.src.Cached ())=0A=
 	    mirrors =3D true;=0A=
 	  ++o;=0A=
@@ -334,8 +334,6 @@ default_trust (HWND h, trusts trust)=0A=
   RECT r;=0A=
   GetClientRect (h, &r);=0A=
   InvalidateRect (h, &r, TRUE);=0A=
-  if (nextbutton)=0A=
-    SetFocus (nextbutton);=0A=
   // and then do the same for categories with no packages.=0A=
   size_t n =3D 1;=0A=
   while (n <=3D db.categories.number ())=0A=
@@ -401,9 +399,6 @@ set_view_mode (HWND h, PickView::views m=0A=
   chooser->scroll_ulc_x =3D chooser->scroll_ulc_y =3D 0;=0A=
=20=0A=
   InvalidateRect (h, &r, TRUE);=0A=
-=0A=
-  if (nextbutton)=0A=
-    SetFocus (nextbutton);=0A=
 }=0A=
=20=0A=
 static void=0A=
@@ -435,74 +430,10 @@ create_listview (HWND dlg, RECT * r)=0A=
       pkg.set_requirements (chooser->deftrust);=0A=
     }=0A=
   /* FIXME: do we need to init the desired fields ? */=0A=
-  static int ta[] =3D { IDC_CHOOSE_CURR, 0 };=0A=
+  static int ta[] =3D { IDC_CHOOSE_PREV, IDC_CHOOSE_CURR, IDC_CHOOSE_EXP, =
0 };=0A=
   rbset (dlg, ta, IDC_CHOOSE_CURR);=0A=
-=0A=
 }=0A=
=20=0A=
-static BOOL=0A=
-dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)=0A=
-{=0A=
-  packagedb db;=0A=
-  switch (id)=0A=
-    {=0A=
-    case IDC_CHOOSE_PREV:=0A=
-      default_trust (lv, TRUST_PREV);=0A=
-      for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
-	{=0A=
-	  packagemeta & pkg =3D *db.packages[n];=0A=
-	  pkg.set_requirements (TRUST_PREV);=0A=
-	}=0A=
-      set_view_mode (lv, chooser->get_view_mode ());=0A=
-      break;=0A=
-    case IDC_CHOOSE_CURR:=0A=
-      default_trust (lv, TRUST_CURR);=0A=
-      for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
-	{=0A=
-	  packagemeta & pkg =3D *db.packages[n];=0A=
-	  pkg.set_requirements (TRUST_CURR);=0A=
-	}=0A=
-      set_view_mode (lv, chooser->get_view_mode ());=0A=
-      break;=0A=
-    case IDC_CHOOSE_EXP:=0A=
-      default_trust (lv, TRUST_TEST);=0A=
-      for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
-	{=0A=
-	  packagemeta & pkg =3D *db.packages[n];=0A=
-	  pkg.set_requirements (TRUST_TEST);=0A=
-	}=0A=
-      set_view_mode (lv, chooser->get_view_mode ());=0A=
-      break;=0A=
-    case IDC_CHOOSE_VIEW:=0A=
-      set_view_mode (lv, ++chooser->get_view_mode ());=0A=
-      if (!SetDlgItemText=0A=
-	  (h, IDC_CHOOSE_VIEWCAPTION, chooser->mode_caption ()))=0A=
-	log (LOG_BABBLE, "Failed to set View button caption %ld",=0A=
-	     GetLastError ());=0A=
-      break;=0A=
-=0A=
-    case IDOK:=0A=
-      if (source =3D=3D IDC_SOURCE_CWD)=0A=
-	NEXT (IDD_S_INSTALL);=0A=
-      else=0A=
-	NEXT (IDD_S_DOWNLOAD);=0A=
-      break;=0A=
-=0A=
-    case IDC_BACK:=0A=
-      initialized =3D 0;=0A=
-      if (source =3D=3D IDC_SOURCE_CWD)=0A=
-	NEXT (IDD_LOCAL_DIR);=0A=
-      else=0A=
-	NEXT (IDD_SITE);=0A=
-      break;=0A=
-=0A=
-    case IDCANCEL:=0A=
-      NEXT (0);=0A=
-      break;=0A=
-    }=0A=
-  return 0;=0A=
-}=0A=
-=0A=
 static void=0A=
 GetParentRect (HWND parent, HWND child, RECT * r)=0A=
 {=0A=
@@ -520,36 +451,6 @@ GetParentRect (HWND parent, HWND child,=20=0A=
   r->bottom =3D p.y;=0A=
 }=0A=
=20=0A=
-static BOOL CALLBACK=0A=
-dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)=0A=
-{=0A=
-  HWND frame;=0A=
-  RECT r;=0A=
-  switch (message)=0A=
-    {=0A=
-    case WM_INITDIALOG:=0A=
-      nextbutton =3D GetDlgItem (h, IDOK);=0A=
-      frame =3D GetDlgItem (h, IDC_LISTVIEW_POS);=0A=
-      choose_inst_text =3D GetDlgItem (h, IDC_CHOOSE_INST_TEXT);=0A=
-      if (source =3D=3D IDC_SOURCE_DOWNLOAD)=0A=
-	SetWindowText (choose_inst_text, "Select packages to download ");=0A=
-      else=0A=
-	SetWindowText (choose_inst_text, "Select packages to install ");=0A=
-      GetParentRect (h, frame, &r);=0A=
-      r.top +=3D 2;=0A=
-      r.bottom -=3D 2;=0A=
-      create_listview (h, &r);=0A=
-=0A=
-#if 0=0A=
-      load_dialog (h);=0A=
-#endif=0A=
-      return TRUE;=0A=
-    case WM_COMMAND:=0A=
-      return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);=0A=
-    }=0A=
-  return FALSE;=0A=
-}=0A=
-=0A=
 /* Find out where to put existing tar file in local directory in=0A=
    known package array. */=0A=
 static void=0A=
@@ -666,14 +567,19 @@ scan_downloaded_files ()=0A=
   find (".", scan2);=0A=
 }=0A=
=20=0A=
-void=0A=
-do_choose (HINSTANCE h, HWND owner)=0A=
+bool=0A=
+ChooserPage::Create ()=0A=
 {=0A=
-  int rv;=0A=
+  return PropertyPage::Create (IDD_CHOOSE);=0A=
+}=0A=
=20=0A=
-  nextbutton =3D 0;=0A=
+void=0A=
+ChooserPage::OnInit ()=0A=
+{=0A=
+  HWND frame;=0A=
+  RECT r;=0A=
=20=0A=
-  register_windows (h);=0A=
+  register_windows (GetInstance ());=0A=
=20=0A=
   if (source =3D=3D IDC_SOURCE_DOWNLOAD || source =3D=3D IDC_SOURCE_CWD)=
=0A=
     scan_downloaded_files ();=0A=
@@ -681,10 +587,32 @@ do_choose (HINSTANCE h, HWND owner)=0A=
   set_existence ();=0A=
   fill_missing_category ();=0A=
=20=0A=
-  rv =3D DialogBox (h, MAKEINTRESOURCE (IDD_CHOOSE), owner, dialog_proc);=
=0A=
-  if (rv =3D=3D -1)=0A=
-    fatal (owner, IDS_DIALOG_FAILED);=0A=
+  frame =3D GetDlgItem (IDC_LISTVIEW_POS);=0A=
+  choose_inst_text =3D GetDlgItem (IDC_CHOOSE_INST_TEXT);=0A=
+  if (source =3D=3D IDC_SOURCE_DOWNLOAD)=0A=
+    ::SetWindowText (choose_inst_text, "Select packages to download ");=0A=
+  else=0A=
+    ::SetWindowText (choose_inst_text, "Select packages to install ");=0A=
+  GetParentRect (GetHWND (), frame, &r);=0A=
+  r.top +=3D 2;=0A=
+  r.bottom -=3D 2;=0A=
+  create_listview (GetHWND (), &r);=0A=
+}=0A=
=20=0A=
+long=0A=
+ChooserPage::OnNext ()=0A=
+{=0A=
+  if (source =3D=3D IDC_SOURCE_CWD)=0A=
+    {=0A=
+      // Next, install=0A=
+      Progress.SetActivateTask (WM_APP_START_INSTALL);=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      // Next, start download from internet=0A=
+      Progress.SetActivateTask (WM_APP_START_DOWNLOAD);=0A=
+    }=0A=
+=0A=
   log (LOG_BABBLE, "Chooser results...");=0A=
   packagedb db;=0A=
   for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
@@ -744,85 +672,88 @@ do_choose (HINSTANCE h, HWND owner)=0A=
 	}=0A=
 #endif=0A=
     }=0A=
-}=0A=
-=0A=
-#define WM_APP_START_CHOOSE        WM_APP+0=0A=
-#define WM_APP_CHOOSE_IS_FINISHED  WM_APP+1=0A=
-=0A=
-extern void do_choose (HINSTANCE h, HWND owner);=0A=
-=0A=
-void=0A=
-do_choose_thread (void *p)=0A=
-{=0A=
-  ChooserPage *cp;=0A=
-=0A=
-  cp =3D static_cast < ChooserPage * >(p);=0A=
-=0A=
-  do_choose (cp->GetInstance (), cp->GetHWND ());=0A=
=20=0A=
-  cp->PostMessage (WM_APP_CHOOSE_IS_FINISHED);=0A=
-=0A=
-  _endthread ();=0A=
+  return IDD_INSTATUS;=0A=
 }=0A=
=20=0A=
-bool ChooserPage::Create ()=0A=
+long=0A=
+ChooserPage::OnBack ()=0A=
 {=0A=
-  return PropertyPage::Create (IDD_CHOOSER);=0A=
+  initialized =3D 0;=0A=
+  if (source =3D=3D IDC_SOURCE_CWD)=0A=
+    return IDD_LOCAL_DIR;=0A=
+  else=0A=
+    return IDD_SITE;=0A=
 }=0A=
=20=0A=
-void=0A=
-ChooserPage::OnActivate ()=0A=
+bool=0A=
+ChooserPage::OnMessageCmd (int id, HWND hwndctl, UINT code)=0A=
 {=0A=
-  GetOwner ()->SetButtons (0);=0A=
-  PostMessage (WM_APP_START_CHOOSE);=0A=
-}=0A=
+  if (code !=3D BN_CLICKED)=0A=
+    {=0A=
+      // Not a click notification, we don't care.=0A=
+      return false;=0A=
+    }=0A=
=20=0A=
-bool ChooserPage::OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lParam)=
=0A=
-{=0A=
-  switch (uMsg)=0A=
+  packagedb db;=0A=
+  switch (id)=0A=
     {=0A=
-    case WM_APP_START_CHOOSE:=0A=
-      {=0A=
-	// Start the chooser thread.=0A=
-	_beginthread (do_choose_thread, 0, this);=0A=
-	break;=0A=
-      }=0A=
-    case WM_APP_CHOOSE_IS_FINISHED:=0A=
-      {=0A=
-	switch (next_dialog)=0A=
-	  {=0A=
-	  case 0:=0A=
-	    {=0A=
-	      // Cancel=0A=
-	      GetOwner ()->PressButton (PSBTN_CANCEL);=0A=
-	      break;=0A=
-	    }=0A=
-	  case IDD_LOCAL_DIR:=0A=
-	  case IDD_SITE:=0A=
+    case IDC_CHOOSE_PREV:=0A=
+      if (IsDlgButtonChecked (GetHWND (), id))=0A=
+	{=0A=
+	  default_trust (lv, TRUST_PREV);=0A=
+	  for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
 	    {=0A=
-	      // Back=0A=
-	      GetOwner ()->SetActivePageByID (next_dialog);=0A=
-	      break;=0A=
+	      packagemeta & pkg =3D *db.packages[n];=0A=
+	      pkg.set_requirements (TRUST_PREV);=0A=
 	    }=0A=
-	  case IDD_S_DOWNLOAD:=0A=
+	  set_view_mode (lv, chooser->get_view_mode ());=0A=
+	  break;=0A=
+	}=0A=
+      else=0A=
+	return false;=0A=
+    case IDC_CHOOSE_CURR:=0A=
+      if (IsDlgButtonChecked (GetHWND (), id))=0A=
+	{=0A=
+	  default_trust (lv, TRUST_CURR);=0A=
+	  for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
 	    {=0A=
-	      // Next, start download from internet=0A=
-	      Progress.SetActivateTask (WM_APP_START_DOWNLOAD);=0A=
-	      GetOwner ()->SetActivePageByID (IDD_INSTATUS);=0A=
-	      break;=0A=
+	      packagemeta & pkg =3D *db.packages[n];=0A=
+	      pkg.set_requirements (TRUST_CURR);=0A=
 	    }=0A=
-	  case IDD_S_INSTALL:=0A=
+	  set_view_mode (lv, chooser->get_view_mode ());=0A=
+	  break;=0A=
+	}=0A=
+      else=0A=
+	return false;=0A=
+    case IDC_CHOOSE_EXP:=0A=
+      if (IsDlgButtonChecked (GetHWND (), id))=0A=
+	{=0A=
+	  default_trust (lv, TRUST_TEST);=0A=
+	  for (size_t n =3D 1; n <=3D db.packages.number (); n++)=0A=
 	    {=0A=
-	      // Next, install=0A=
-	      Progress.SetActivateTask (WM_APP_START_INSTALL);=0A=
-	      GetOwner ()->SetActivePageByID (IDD_INSTATUS);=0A=
-	      break;=0A=
+	      packagemeta & pkg =3D *db.packages[n];=0A=
+	      pkg.set_requirements (TRUST_TEST);=0A=
 	    }=0A=
-	  }=0A=
-      }=0A=
+	  set_view_mode (lv, chooser->get_view_mode ());=0A=
+	  break;=0A=
+	}=0A=
+      else=0A=
+	return false;=0A=
+    case IDC_CHOOSE_VIEW:=0A=
+      set_view_mode (lv, ++chooser->get_view_mode ());=0A=
+      if (!SetDlgItemText=0A=
+	  (GetHWND (), IDC_CHOOSE_VIEWCAPTION, chooser->mode_caption ()))=0A=
+	log (LOG_BABBLE, "Failed to set View button caption %ld",=0A=
+	     GetLastError ());=0A=
+      break;=0A=
+=0A=
+=0A=
     default:=0A=
+      // Wasn't recognized or handled.=0A=
       return false;=0A=
-      break;=0A=
     }=0A=
+=0A=
+  // Was handled since we never got to default above.=0A=
   return true;=0A=
 }=0A=
Index: choose.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/choose.h,v=0A=
retrieving revision 2.14=0A=
diff -p -u -r2.14 choose.h=0A=
--- choose.h	2002/01/22 06:36:35	2.14=0A=
+++ choose.h	2002/04/02 10:18:35=0A=
@@ -33,10 +33,12 @@ public:=0A=
   {=0A=
   };=0A=
=20=0A=
-  virtual bool OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lParam);=0A=
+  virtual bool OnMessageCmd (int id, HWND hwndctl, UINT code);=0A=
=20=0A=
   bool Create ();=0A=
-  virtual void OnActivate ();=0A=
+  virtual void OnInit ();=0A=
+  virtual long OnNext ();=0A=
+  virtual long OnBack ();=0A=
 };=0A=
=20=0A=
 #endif /* __cplusplus */=0A=
Index: desktop.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/desktop.cc,v=0A=
retrieving revision 2.27=0A=
diff -p -u -r2.27 desktop.cc=0A=
--- desktop.cc	2002/03/27 04:20:45	2.27=0A=
+++ desktop.cc	2002/04/02 10:18:36=0A=
@@ -531,7 +531,7 @@ DesktopSetupPage::OnBack ()=0A=
   HWND h =3D GetHWND ();=0A=
   save_dialog (h);=0A=
   NEXT (IDD_CHOOSE);=0A=
-  return IDD_CHOOSER;=0A=
+  return IDD_CHOOSE;=0A=
 }=0A=
=20=0A=
 bool=0A=
Index: fromcwd.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/fromcwd.cc,v=0A=
retrieving revision 2.22=0A=
diff -p -u -r2.22 fromcwd.cc=0A=
--- fromcwd.cc	2002/02/18 13:53:06	2.22=0A=
+++ fromcwd.cc	2002/04/02 10:18:37=0A=
@@ -158,7 +158,7 @@ do_fromcwd (HINSTANCE h, HWND owner)=0A=
       return;=0A=
     }=0A=
=20=0A=
-  next_dialog =3D IDD_CHOOSER;=0A=
+  next_dialog =3D IDD_CHOOSE;=0A=
=20=0A=
   find (".", found_file);=0A=
=20=0A=
Index: ini.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/ini.cc,v=0A=
retrieving revision 2.20=0A=
diff -p -u -r2.20 ini.cc=0A=
--- ini.cc	2002/02/18 13:53:06	2.20=0A=
+++ ini.cc	2002/04/02 10:18:37=0A=
@@ -208,7 +208,7 @@ do_ini_thread (HINSTANCE h, HWND owner)=0A=
 	note (owner, IDS_OLD_SETUP_VERSION, version, setup_version);=0A=
     }=0A=
=20=0A=
-  next_dialog =3D IDD_CHOOSER;=0A=
+  next_dialog =3D IDD_CHOOSE;=0A=
 }=0A=
=20=0A=
 static void=0A=
Index: res.rc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v=0A=
retrieving revision 2.37=0A=
diff -p -u -r2.37 res.rc=0A=
--- res.rc	2002/02/24 10:59:19	2.37=0A=
+++ res.rc	2002/04/02 10:18:38=0A=
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
@@ -226,34 +226,6 @@ BEGIN=0A=
                     IDC_STATIC,115,33,195,54=0A=
 END=0A=
=20=0A=
-IDD_CHOOSE DIALOG DISCARDABLE  0, 0, 430, 266=0A=
-STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
-    WS_CAPTION | WS_SYSMENU=0A=
-EXSTYLE WS_EX_CONTROLPARENT=0A=
-CAPTION "Cygwin Setup"=0A=
-FONT 8, "MS Sans Serif"=0A=
-BEGIN=0A=
-    DEFPUSHBUTTON   "&Next -->",IDOK,311,242,45,15,WS_GROUP=0A=
-    PUSHBUTTON      "Cancel",IDCANCEL,375,242,45,15=0A=
-    PUSHBUTTON      "<-- &Back",IDC_BACK,266,242,45,15=0A=
-    CONTROL         "&Prev",IDC_CHOOSE_PREV,"Button",BS_AUTORADIOBUTTON |=
=20=0A=
-                    WS_GROUP | WS_TABSTOP,265,5,27,10=0A=
-    CONTROL         "&Curr",IDC_CHOOSE_CURR,"Button",BS_AUTORADIOBUTTON,29=
7,=0A=
-                    5,25,10=0A=
-    CONTROL         "E&xp",IDC_CHOOSE_EXP,"Button",BS_AUTORADIOBUTTON,323,=
5,=0A=
-                    25,10=0A=
-    PUSHBUTTON      "&View",IDC_CHOOSE_VIEW,353,5,20,10,WS_GROUP=0A=
-    ICON            IDI_CYGWIN,IDC_STATIC,0,2,20,20=0A=
-    LTEXT           "Select packages to install",IDC_CHOOSE_INST_TEXT,125,=
5,=0A=
-                    99,8=0A=
-    CONTROL         "",IDC_LISTVIEW_POS,"Static",SS_BLACKFRAME | NOT=20=0A=
-                    WS_VISIBLE,22,17,398,217=0A=
-    CONTROL         "SPIN",IDC_STATIC,"Static",SS_BITMAP,22,235,15,13=0A=
-    LTEXT           "=3D click to choose action, (p) =3D previous version,=
 (x) =3D experimental",=0A=
-                    IDC_STATIC,35,234,220,8=0A=
-    LTEXT           "",IDC_CHOOSE_VIEWCAPTION,390,5,30,10=0A=
-END=0A=
-=0A=
 IDD_DESKTOP DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_3DLOOK | DS_CENTER | WS_CHILD | WS_VISIBLE |=20=
=0A=
     WS_CAPTION | WS_SYSMENU=0A=
@@ -290,14 +262,29 @@ BEGIN=0A=
     PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15=0A=
 END=0A=
=20=0A=
-IDD_CHOOSER DIALOG DISCARDABLE  0, 0, 247, 116=0A=
+IDD_CHOOSE DIALOG DISCARDABLE  0, 0, 317, 179=0A=
 STYLE DS_MODALFRAME | DS_3DLOOK | WS_CHILD | WS_VISIBLE | WS_CAPTION |=20=
=0A=
     WS_SYSMENU=0A=
 CAPTION "Cygwin Setup"=0A=
 FONT 8, "MS Sans Serif"=0A=
 BEGIN=0A=
-    CTEXT           "This space intentionally left blank",IDC_STATIC,57,45=
,=0A=
-                    134,8=0A=
+    CONTROL         "&Prev",IDC_CHOOSE_PREV,"Button",BS_AUTORADIOBUTTON |=
=20=0A=
+                    WS_GROUP | WS_TABSTOP,150,30,27,10=0A=
+    CONTROL         "&Curr",IDC_CHOOSE_CURR,"Button",BS_AUTORADIOBUTTON,18=
5,=0A=
+                    30,25,10=0A=
+    CONTROL         "E&xp",IDC_CHOOSE_EXP,"Button",BS_AUTORADIOBUTTON,220,=
30,=0A=
+                    25,10=0A=
+    PUSHBUTTON      "&View",IDC_CHOOSE_VIEW,255,30,20,10,WS_GROUP=0A=
+    CONTROL         "",IDC_STATIC,"Static",SS_BLACKFRAME | SS_SUNKEN,0,28,=
=0A=
+                    317,1=0A=
+    CONTROL         "",IDC_LISTVIEW_POS,"Static",SS_BLACKFRAME | NOT=20=0A=
+                    WS_VISIBLE,7,41,303,134=0A=
+    ICON            IDI_CYGWIN,IDC_STATIC,290,0,20,20=0A=
+    LTEXT           "Select the packages you want setup to install.",=0A=
+                    IDC_STATIC,21,9,239,16,NOT WS_GROUP=0A=
+    LTEXT           "Select Packages",IDC_STATIC_HEADER_TITLE,7,0,258,8,NO=
T=20=0A=
+                    WS_GROUP=0A=
+    LTEXT           "",IDC_CHOOSE_VIEWCAPTION,280,30,30,10=0A=
 END=0A=
=20=0A=
=20=0A=
@@ -404,11 +391,6 @@ BEGIN=0A=
         BOTTOMMARGIN, 116=0A=
     END=0A=
=20=0A=
-    IDD_CHOOSE, DIALOG=0A=
-    BEGIN=0A=
-        RIGHTMARGIN, 429=0A=
-    END=0A=
-=0A=
     IDD_DESKTOP, DIALOG=0A=
     BEGIN=0A=
         RIGHTMARGIN, 285=0A=
@@ -420,12 +402,12 @@ BEGIN=0A=
         BOTTOMMARGIN, 49=0A=
     END=0A=
=20=0A=
-    IDD_CHOOSER, DIALOG=0A=
+    IDD_CHOOSE, DIALOG=0A=
     BEGIN=0A=
         LEFTMARGIN, 7=0A=
-        RIGHTMARGIN, 240=0A=
+        RIGHTMARGIN, 310=0A=
         TOPMARGIN, 7=0A=
-        BOTTOMMARGIN, 109=0A=
+        BOTTOMMARGIN, 172=0A=
     END=0A=
 END=0A=
 #endif    // APSTUDIO_INVOKED=0A=
@@ -462,6 +444,10 @@ BEGIN=0A=
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

------=_NextPart_000_0005_01C1D9FE.A98104D0
Content-Type: application/octet-stream;
	name="ChangeLog-chooser-integration"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog-chooser-integration"
Content-length: 1680

2002-04-02  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>=0A=
=0A=
	* choose.cc: Run indent.=0A=
	(nextbutton): Remove static variable.=0A=
	(default_trust): Remove use of nextbutton.=0A=
	(set_view_mode): Ditto.=0A=
	(create_listview): Add IDC_CHOOSE_PREV and IDC_CHOOSE_NEXT to ta[] so=0A=
	rbset() sets the prev/next/curr radio buttons properly.=0A=
	(dialog_cmd): Delete function.=0A=
	(dialog_proc): Delete function.  Move WM_INITDIALOG functionality to=0A=
	ChooserPage::OnInit.=0A=
	(do_choose): Delete function.  Move pre-DialogBox() code to=0A=
	ChooserPage::OnInit(), post-DialogBox() code to	ChooserPage::OnNext.=0A=
	(WM_APP_START_CHOOSE): Remove define.=0A=
	(WM_APP_CHOOSE_IS_FINISHED): Remove define.=0A=
	(do_choose_thread): Delete function.=0A=
	(ChooserPage::OnActivate): Delete method.=0A=
	(ChooserPage::OnMessageApp): Delete method.=0A=
	(ChooserPage::OnInit): New method.=0A=
	(ChooserPage::OnNext): New method.=0A=
	(ChooserPage::OnBack): New method.=0A=
	(ChooserPage::OnMessageCmd): New method.=0A=
	* choose.h: Run indent.=0A=
	(ChooserPage::OnMessageApp): Delete declaration.=0A=
	(ChooserPage::OnActivate): Ditto.=0A=
	(ChooserPage::OnMessageCmd): New declaration.=0A=
	(ChooserPage::OnInit): Ditto.=0A=
	(ChooserPage::OnNext): Ditto.=0A=
	(ChooserPage::OnBack): Ditto.=0A=
	* desktop.cc (DesktopSetupPage::OnBack): Replace use of IDD_CHOOSER=0A=
	with IDD_CHOOSE.=0A=
	* fromcwd.cc (do_fromcwd): Replace use of IDD_CHOOSER with IDD_CHOOSE.=0A=
	* ini.cc (do_ini_thread): Replace use of IDD_CHOOSER with IDD_CHOOSE.=0A=
	* res.rc (IDD_CHOOSE): Remove dialog template.=0A=
	(IDD_CHOOSER): Alter dialog template to fit wizard size and format.=0A=

------=_NextPart_000_0005_01C1D9FE.A98104D0--
