Return-Path: <cygwin-patches-return-1772-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22486 invoked by alias); 24 Jan 2002 13:25:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22471 invoked from network); 24 Jan 2002 13:25:33 -0000
Message-ID: <005401c1a4da$c93e3e90$30313c3e@Obsession>
Reply-To: <keith_starsmeare@yahoo.co.uk>
From: "keith_starsmeare@yahoo.co.uk" <kxs@breathemail.net>
To: <cygwin-patches@cygwin.com>
Subject: setup.exe command line options
Date: Thu, 24 Jan 2002 05:25:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0051_01C1A4DA.9C14F710"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00129.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0051_01C1A4DA.9C14F710
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2664

I've attached the diffs for the work in progress implementation of command
line options. I've tried to copy the dialog's terminology when choosing the
options and the variables used within WinMain.

I'm using the PropertyPage Create functions as my interface. In many
instances the Create function can do all the work for that dialog, and can
return false - so no dialog will be created.

However some dialog's (like the create desktop icon dialog) get called
directly using next_dialog. So for these I've currently used the create
function to toggle a static variable which can be used later. This isn't
working very well yet!

I'm having problems with the packagedir and the rootdir Create functions, I
must be missing something. Most importantly I'm having difficulty getting
yyparse called. :(

Much work still to be done, but have a look and let me know how appalled you
all are at my strategy!

Keith

ChangeLog:

2002-01-24  Keith Starsmeare  <keith_starsmeare@yahoo.co.uk>

        * choose.cc (ChooserPage::Create): Add 1 (currently unused) command
line parameter.
        * choose.h (ChooserPage::Create): Ditto.
        * desktop.cc (DesktopSetupPage::Create): Add 1 command line
parameter; toggles (currently unused) static variable.
        * desktop.h (DesktopSetupPage::Create): Add 1 command line
parameter.
        * ini.cc (do_ini_nowindow): New function, based on do_ini.
        * localdir.cc (LocalDirPage::Create): Use 2 new command line
parameters to determine if dialog is needed.
        * localdir.h (LocalDirPage::Create): Add 2 new command line
parameters.
        * main.cc (usage): Raises a dialog listing command line options.
        (WinMain): Process command line arguments, pass relevant arguments
to PropertyPage Create functions.
        * net.cc (NetPage::Create): Use 6 new command line parameters to
determine if dialog is needed.
        * net.h (NetPage::Create): Add 6 new command line parameters.
        * root.cc (RootPage::Create): Use 3 new command line parameters to
determine if dialog is needed.
        * root.h (RootPage::Create): Add 3 new command line parameters.
        * site.cc (SitePage::Create): Use 3 new command line parameters to
determine if dialog is needed.
        * site.h (SitePage::Create): Add 3 new command line parameters.
        * source.cc (SourcePage::Create): Use 3 new command line parameters
to determine if dialog is needed.
        * source.h (SourcePage::Create): Add 3 new command line parameters.
        * splash.cc (SplashPage::Create): Use new command line parameter to
determine if dialog is needed.
        * splash.h (SplashPage::Create): Add new command line parameter.


------=_NextPart_000_0051_01C1A4DA.9C14F710
Content-Type: application/octet-stream;
	name="cinstall.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cinstall.diff"
Content-length: 22792

Index: choose.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v=0A=
retrieving revision 2.88=0A=
diff -p -u -w -r2.88 choose.cc=0A=
--- choose.cc	2002/01/22 06:43:55	2.88=0A=
+++ choose.cc	2002/01/24 12:50:03=0A=
@@ -753,7 +753,7 @@ do_choose_thread (void *p)=0A=
 }=0A=
=20=0A=
 bool=0A=
-ChooserPage::Create ()=0A=
+ChooserPage::Create (bool all_new)=0A=
 {=0A=
   return PropertyPage::Create (IDD_CHOOSER);=0A=
 }=0A=
Index: choose.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/choose.h,v=0A=
retrieving revision 2.14=0A=
diff -p -u -w -r2.14 choose.h=0A=
--- choose.h	2002/01/22 06:36:35	2.14=0A=
+++ choose.h	2002/01/24 12:50:06=0A=
@@ -35,7 +35,7 @@ public:=0A=
=20=0A=
   virtual bool OnMessageApp (UINT uMsg, WPARAM wParam, LPARAM lParam);=0A=
=20=0A=
-  bool Create ();=0A=
+  bool Create (bool all_new);=0A=
   virtual void OnActivate ();=0A=
 };=0A=
=20=0A=
Index: desktop.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/desktop.cc,v=0A=
retrieving revision 2.22=0A=
diff -p -u -w -r2.22 desktop.cc=0A=
--- desktop.cc	2002/01/20 13:31:04	2.22=0A=
+++ desktop.cc	2002/01/24 12:50:09=0A=
@@ -448,9 +448,12 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
   return 0;=0A=
 }=0A=
=20=0A=
+static bool skip_desktop;=0A=
+=0A=
 bool=0A=
-DesktopSetupPage::Create ()=0A=
+DesktopSetupPage::Create (bool skip)=0A=
 {=0A=
+  skip_desktop =3D skip;=0A=
   return PropertyPage::Create (NULL, dialog_cmd, IDD_DESKTOP);=0A=
 }=0A=
=20=0A=
Index: desktop.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/desktop.h,v=0A=
retrieving revision 2.2=0A=
diff -p -u -w -r2.2 desktop.h=0A=
--- desktop.h	2002/01/03 11:27:11	2.2=0A=
+++ desktop.h	2002/01/24 12:50:09=0A=
@@ -31,7 +31,7 @@ public:=0A=
   {=0A=
   };=0A=
=20=0A=
-  bool Create ();=0A=
+  bool Create (bool skip_desktop);=0A=
=20=0A=
   virtual void OnInit ();=0A=
   virtual bool OnFinish ();=0A=
Index: ini.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/ini.cc,v=0A=
retrieving revision 2.18=0A=
diff -p -u -w -r2.18 ini.cc=0A=
--- ini.cc	2002/01/20 13:31:04	2.18=0A=
+++ ini.cc	2002/01/24 12:50:10=0A=
@@ -207,6 +207,67 @@ do_ini_thread (HINSTANCE h, HWND owner)=0A=
   next_dialog =3D IDD_CHOOSER;=0A=
 }=0A=
=20=0A=
+void=0A=
+do_ini_nowindow ()=0A=
+{=0A=
+  size_t ini_count =3D 0;=0A=
+  if (source !=3D IDC_SOURCE_CWD)=0A=
+  {=0A=
+    fprintf(stderr, "Command line processing error. Sorry!\n");=0A=
+    exit_setup(1);=0A=
+  }=0A=
+  ini_count =3D do_local_ini (NULL);=0A=
+=0A=
+  if (ini_count =3D=3D 0)=0A=
+    return;=0A=
+=0A=
+  if (get_root_dir ())=0A=
+    {=0A=
+      io_stream::mkpath_p (PATH_TO_DIR, "cygfile:///etc/setup");=0A=
+=0A=
+      unsigned int old_timestamp =3D 0;=0A=
+      io_stream *ots =3D=0A=
+	io_stream::open ("cygfile:///etc/setup/timestamp", "rt");=0A=
+      if (ots)=0A=
+	{=0A=
+	  char temp[20];=0A=
+	  memset (temp, '\0', 20);=0A=
+	  if (ots->read (temp, 19))=0A=
+	    sscanf (temp, "%u", &old_timestamp);=0A=
+	  delete ots;=0A=
+	  if (old_timestamp && setup_timestamp=0A=
+	      && (old_timestamp > setup_timestamp))=0A=
+	    fprintf(stderr, "Timestamp problem...\n");=0A=
+	    exit_setup (1);=0A=
+	}=0A=
+      if (setup_timestamp)=0A=
+	{=0A=
+	  io_stream *nts =3D=0A=
+	    io_stream::open ("cygfile:///etc/setup/timestamp", "wt");=0A=
+	  if (nts)=0A=
+	    {=0A=
+	      char temp[20];=0A=
+	      sprintf (temp, "%u", setup_timestamp);=0A=
+	      nts->write (temp, strlen (temp));=0A=
+	      delete nts;=0A=
+	    }=0A=
+	}=0A=
+    }=0A=
+=0A=
+  msg ("setup_version is %s, our_version is %s", setup_version ? : "(null)=
",=0A=
+       version);=0A=
+  if (setup_version)=0A=
+    {=0A=
+      char *ini_version =3D canonicalize_version (setup_version);=0A=
+      char *our_version =3D canonicalize_version (version);=0A=
+      if (strcmp (our_version, ini_version) < 0)=0A=
+      {=0A=
+	fprintf(stderr, "setup_version is %s, our_version is %s\n", setup_version=
 ? : "(null)", version);=0A=
+	exit_setup(1);=0A=
+      }=0A=
+    }=0A=
+}=0A=
+=0A=
 static void=0A=
 do_ini_thread_reflector(void* p)=0A=
 {=0A=
Index: localdir.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/localdir.cc,v=0A=
retrieving revision 2.7=0A=
diff -p -u -w -r2.7 localdir.cc=0A=
--- localdir.cc	2002/01/20 13:31:04	2.7=0A=
+++ localdir.cc	2002/01/24 12:50:11=0A=
@@ -137,9 +137,19 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
   return 0;=0A=
 }=0A=
=20=0A=
+void do_ini_nowindow();=0A=
+=0A=
 bool=0A=
-LocalDirPage::Create ()=0A=
+LocalDirPage::Create (bool packagedir, char *localdir)=0A=
 {=0A=
+  if (packagedir) {=0A=
+    local_dir =3D strdup (localdir);=0A=
+    save_local_dir();=0A=
+    do_ini (GetInstance (), GetHWND ());=0A=
+    if (source =3D=3D IDC_SOURCE_CWD)=0A=
+      do_fromcwd (GetInstance (), GetHWND ());=0A=
+    return false;=0A=
+  }=0A=
   return PropertyPage::Create (NULL, dialog_cmd, IDD_LOCAL_DIR);=0A=
 }=0A=
=20=0A=
Index: localdir.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/localdir.h,v=0A=
retrieving revision 2.2=0A=
diff -p -u -w -r2.2 localdir.h=0A=
--- localdir.h	2002/01/03 11:27:11	2.2=0A=
+++ localdir.h	2002/01/24 12:50:11=0A=
@@ -32,7 +32,7 @@ public:=0A=
   {=0A=
   };=0A=
=20=0A=
-  bool Create ();=0A=
+  bool Create (bool packagedir, char *localdir);=0A=
=20=0A=
   virtual void OnActivate ();=0A=
   virtual void OnInit ();=0A=
Index: main.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/main.cc,v=0A=
retrieving revision 2.11=0A=
diff -p -u -w -r2.11 main.cc=0A=
--- main.cc	2002/01/20 13:31:04	2.11=0A=
+++ main.cc	2002/01/24 12:50:13=0A=
@@ -33,6 +33,7 @@ static const char *cvsid =3D=0A=
=20=0A=
 #include <stdio.h>=0A=
 #include <stdlib.h>=0A=
+#include <getopt.h>=0A=
 #include "resource.h"=0A=
 #include "dialog.h"=0A=
 #include "state.h"=0A=
@@ -137,6 +138,53 @@ out:=0A=
   FreeSid (sid);=0A=
 }=0A=
=20=0A=
+static void=0A=
+usage (void)=0A=
+{=0A=
+  fprintf (stderr, "Usage: %s [OPTION]\n"=0A=
+      "-v, --version		show splash screen\n"=0A=
+      "-n, --netinstall		install from the internet\n"=0A=
+      "-d, --netdownload		download from the internet\n"=0A=
+      "-l, --localinstall		install from a local directory\n"=0A=
+      "-p, --packagedir path	specify the location to store the packages\n"=
=0A=
+      "-r, --rootdir path		specify the cygwin root directory\n"=0A=
+      "-D, --dos			use text mode mounts\n"=0A=
+      "-u, --unix (default) 		use binary mode mounts\n"=0A=
+      "-a, --allusers (default)	use system mounts\n"=0A=
+      "-m, --justme		use user mounts\n"=0A=
+      "-o, --noproxy		use direct connection to internet\n"=0A=
+      "-X, --ie			use Internet Explorer\'s internet settings\n"=0A=
+      "-x, --proxy proxy		specify a proxy of the form proxy:port\n"=0A=
+      "-f, --ftpsite URL		specify the ftpsite to use\n"=0A=
+      "-e, --allnew		download all new packages\n"=0A=
+      "-s, --skipdesktop		don't create icon and shortcut\n"=0A=
+      "-h, --help			show this window\n",=0A=
+      __argv[0]);=0A=
+  ExitProcess(1);=0A=
+}=0A=
+=0A=
+namespace CommandLineOptions {=0A=
+  enum {=0A=
+    version,=0A=
+    netinstall,=0A=
+    netdownload,=0A=
+    localinstall,=0A=
+    packagedir,=0A=
+    rootdir,=0A=
+    dos,=0A=
+    unix,=0A=
+    all_users,=0A=
+    justme,=0A=
+    noproxy,=0A=
+    ie,=0A=
+    proxy,=0A=
+    ftpsite,=0A=
+    allnew,=0A=
+    skipdesktop,=0A=
+    option_count // Must be the last element=0A=
+  };=0A=
+}=0A=
+=0A=
 // Other threads talk to this page, so we need to have it externable.=0A=
 ThreeBarProgressPage Progress;=0A=
=20=0A=
@@ -150,6 +198,38 @@ WinMain (HINSTANCE h,=0A=
=20=0A=
   log (LOG_TIMESTAMP, "Starting cygwin install, version %s", version);=0A=
=20=0A=
+  static struct option long_options[] =3D {=0A=
+    {"dos",		no_argument,		NULL, 'D'},=0A=
+    {"ie",		no_argument,		NULL, 'X'},=0A=
+    {"allusers",	no_argument,		NULL, 'a'},=0A=
+    {"netdownload",	no_argument,		NULL, 'd'},=0A=
+    {"allnew",		no_argument,		NULL, 'e'},=0A=
+    {"ftpsite",		required_argument,	NULL, 'f'},=0A=
+    {"help",		no_argument,		NULL, 'h'},=0A=
+    {"localinstall",	no_argument,		NULL, 'l'},=0A=
+    {"justme",		no_argument,		NULL, 'm'},=0A=
+    {"netinstall",	no_argument,		NULL, 'n'},=0A=
+    {"noproxy",		no_argument,		NULL, 'o'},=0A=
+    {"packagedir",	required_argument,	NULL, 'p'},=0A=
+    {"rootdir",		required_argument,	NULL, 'r'},=0A=
+    {"skipdesktop",	no_argument,		NULL, 's'},=0A=
+    {"unix",		no_argument,		NULL, 'u'},=0A=
+    {"version",		no_argument,		NULL, 'v'},=0A=
+    {"proxy",		required_argument,	NULL, 'x'},=0A=
+    {0, 0, 0, 0}=0A=
+  };=0A=
+  int option_index;=0A=
+  char options[] =3D "DXadef:hlmnop:r:suvx:";=0A=
+=0A=
+  char *root_dir =3D 0;=0A=
+  char *mirror_site =3D 0;=0A=
+  char *proxy_host =3D 0;=0A=
+  char *colon =3D 0;=0A=
+  int proxy_port =3D 0;=0A=
+  using namespace CommandLineOptions;=0A=
+  bool clops[option_count] =3D {false};=0A=
+  int i;=0A=
+=0A=
   SplashPage Splash;=0A=
   SourcePage Source;=0A=
   RootPage Root;=0A=
@@ -167,6 +247,7 @@ WinMain (HINSTANCE h,=0A=
   strcpy (local_dir, cwd);=0A=
   log (0, "Current Directory: %s", cwd);=0A=
=20=0A=
+  /* Parse the commandline into a argc, argv pair */=0A=
   char **argv;=0A=
   int argc;=0A=
   log (LOG_TIMESTAMP, "Command line parameters\n");=0A=
@@ -174,6 +255,89 @@ WinMain (HINSTANCE h,=0A=
     log (LOG_TIMESTAMP, "%d - '%s'\n", argc++, *argv);=0A=
   log (LOG_TIMESTAMP, "%d parameters passed\n", argc);=0A=
=20=0A=
+  argv =3D __argv;=0A=
+  if (argc > 1)=0A=
+    clops[CommandLineOptions::version] =3D false;=0A=
+  opterr =3D 0;=0A=
+  while ((i =3D getopt_long (argc, argv, options, long_options, &option_in=
dex)) !=3D EOF)=0A=
+    switch(i)=0A=
+    {=0A=
+      case 'v':=0A=
+	clops[CommandLineOptions::version] =3D true;=0A=
+	break;=0A=
+      case 'D':=0A=
+	clops[dos] =3D true;=0A=
+	root_text =3D IDC_ROOT_TEXT;=0A=
+	break;=0A=
+      case 'X':=0A=
+	clops[noproxy] =3D false;=0A=
+	clops[ie] =3D true;=0A=
+	clops[proxy] =3D false;=0A=
+	break;=0A=
+      case 'a':=0A=
+	clops[all_users] =3D true;=0A=
+	root_scope =3D IDC_ROOT_SYSTEM;=0A=
+	break;=0A=
+      case 'd':=0A=
+	clops[netinstall] =3D false;=0A=
+	clops[netdownload] =3D true;=0A=
+	clops[localinstall] =3D false;=0A=
+	break;=0A=
+      case 'e':=0A=
+	clops[allnew] =3D true;=0A=
+	break;=0A=
+      case 'f':=0A=
+	clops[ftpsite] =3D true;=0A=
+	mirror_site =3D strdup(optarg);=0A=
+	break;=0A=
+      case 'l':=0A=
+	clops[netinstall] =3D false;=0A=
+	clops[netdownload] =3D false;=0A=
+	clops[localinstall] =3D true;=0A=
+	break;=0A=
+      case 'm':=0A=
+	clops[justme] =3D true;=0A=
+	root_scope =3D IDC_ROOT_USER;=0A=
+	break;=0A=
+      case 'n':=0A=
+	clops[netinstall] =3D true;=0A=
+	clops[netdownload] =3D false;=0A=
+	clops[localinstall] =3D false;=0A=
+	break;=0A=
+      case 'o':=0A=
+	clops[noproxy] =3D true;=0A=
+	clops[ie] =3D false;=0A=
+	clops[proxy] =3D false;=0A=
+	break;=0A=
+      case 'p':=0A=
+	clops[packagedir] =3D true;=0A=
+	local_dir =3D strdup(optarg);=0A=
+	break;=0A=
+      case 'r':=0A=
+	clops[rootdir] =3D true;=0A=
+	root_dir =3D strdup(optarg);=0A=
+	break;=0A=
+      case 's':=0A=
+	clops[skipdesktop] =3D true;=0A=
+	break;=0A=
+      case 'u':=0A=
+	clops[unix] =3D true;=0A=
+	root_text =3D IDC_ROOT_BINARY;=0A=
+	break;=0A=
+      case 'x':=0A=
+	clops[noproxy] =3D false;=0A=
+	clops[ie] =3D false;=0A=
+	clops[proxy] =3D true;=0A=
+	proxy_host =3D strdup(optarg);=0A=
+	colon =3D proxy_host;=0A=
+	while (*colon && (*colon !=3D ':')) colon++;=0A=
+	*colon++ =3D 0;=0A=
+	proxy_port =3D atoi(colon);=0A=
+	break;=0A=
+      default:=0A=
+	usage();=0A=
+    }=0A=
+=0A=
   /* Set the default DACL only on NT/W2K. 9x/ME has no idea of access=0A=
      control lists and security at all. */=0A=
   if (iswinnt)=0A=
@@ -184,27 +348,25 @@ WinMain (HINSTANCE h,=0A=
=20=0A=
   // Init window class lib=0A=
   Window::SetAppInstance (h);=0A=
-=0A=
-  // Create pages=0A=
-  Splash.Create ();=0A=
-  Source.Create ();=0A=
-  Root.Create ();=0A=
-  LocalDir.Create ();=0A=
-  Net.Create ();=0A=
-  Site.Create ();=0A=
-  Chooser.Create ();=0A=
-  Progress.Create ();=0A=
-  Desktop.Create ();=0A=
=20=0A=
-  // Add pages to sheet=0A=
+  // Check command line options, create necessary pages and add to sheet=
=0A=
+  if (Splash.Create(clops[CommandLineOptions::version]))=0A=
   MainWindow.AddPage (&Splash);=0A=
+  if (Source.Create(clops[netinstall], clops[netdownload], clops[localinst=
all]))=0A=
   MainWindow.AddPage (&Source);=0A=
+  if (Root.Create(clops[netdownload], clops[rootdir], root_dir))=0A=
   MainWindow.AddPage (&Root);=0A=
+  if (LocalDir.Create (clops[packagedir], local_dir))=0A=
   MainWindow.AddPage (&LocalDir);=0A=
+  if (Net.Create (clops[localinstall], clops[noproxy], clops[ie], clops[pr=
oxy], proxy_host, proxy_port))=0A=
   MainWindow.AddPage (&Net);=0A=
+  if (Site.Create (clops[localinstall], clops[ftpsite], mirror_site))=0A=
   MainWindow.AddPage (&Site);=0A=
+  if (Chooser.Create (clops[allnew]))=0A=
   MainWindow.AddPage (&Chooser);=0A=
+  if (Progress.Create ())=0A=
   MainWindow.AddPage (&Progress);=0A=
+  if (Desktop.Create (clops[skipdesktop]))=0A=
   MainWindow.AddPage (&Desktop);=0A=
=20=0A=
   // Create the PropSheet main window=0A=
Index: net.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/net.cc,v=0A=
retrieving revision 2.9=0A=
diff -p -u -w -r2.9 net.cc=0A=
--- net.cc	2002/01/03 11:27:11	2.9=0A=
+++ net.cc	2002/01/24 12:50:13=0A=
@@ -84,8 +84,23 @@ save_dialog (HWND h)=0A=
 }=0A=
=20=0A=
 bool=0A=
-NetPage::Create ()=0A=
+NetPage::Create (bool localinstall, bool noproxy, bool ie, bool proxy, cha=
r *proxy_host, int proxy_port)=0A=
 {=0A=
+  if (localinstall) return false;=0A=
+  if (noproxy) {=0A=
+    net_method =3D IDC_NET_DIRECT;=0A=
+    return false;=0A=
+  }=0A=
+  if (ie) {=0A=
+    net_method =3D IDC_NET_IE5;=0A=
+    return false;=0A=
+  }=0A=
+  if (proxy) {=0A=
+    net_method =3D IDC_NET_PROXY;=0A=
+    net_proxy_host =3D proxy_host;=0A=
+    net_proxy_port =3D proxy_port;=0A=
+    return false;=0A=
+  }=0A=
   return PropertyPage::Create (IDD_NET);=0A=
 }=0A=
=20=0A=
Index: net.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/net.h,v=0A=
retrieving revision 2.2=0A=
diff -p -u -w -r2.2 net.h=0A=
--- net.h	2002/01/03 11:27:11	2.2=0A=
+++ net.h	2002/01/24 12:50:13=0A=
@@ -34,7 +34,7 @@ public:=0A=
   {=0A=
   };=0A=
=20=0A=
-  bool Create ();=0A=
+  bool Create (bool localinstall, bool noproxy, bool ie, bool proxy, char =
*proxy_host, int proxy_port);=0A=
=20=0A=
   virtual void OnInit ();=0A=
   virtual long OnNext ();=0A=
Index: root.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/root.cc,v=0A=
retrieving revision 2.8=0A=
diff -p -u -w -r2.8 root.cc=0A=
--- root.cc	2001/12/23 12:13:29	2.8=0A=
+++ root.cc	2002/01/24 12:50:14=0A=
@@ -149,8 +149,15 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
 }=0A=
=20=0A=
 bool=0A=
-RootPage::Create ()=0A=
+RootPage::Create (bool netdownload, bool rootdir, char *root_dir)=0A=
 {=0A=
+  if (netdownload) return false;=0A=
+  if (rootdir) {=0A=
+    if (!get_root_dir ())=0A=
+      read_mounts ();=0A=
+    set_root_dir(root_dir);=0A=
+    return false;=0A=
+  }=0A=
   return PropertyPage::Create (NULL, dialog_cmd, IDD_ROOT);=0A=
 }=0A=
=20=0A=
Index: root.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/root.h,v=0A=
retrieving revision 2.2=0A=
diff -p -u -w -r2.2 root.h=0A=
--- root.h	2002/01/03 11:27:11	2.2=0A=
+++ root.h	2002/01/24 12:50:14=0A=
@@ -13,7 +13,7 @@ public:=0A=
   {=0A=
   };=0A=
=20=0A=
-  bool Create ();=0A=
+  bool Create (bool netdownload, bool rootdir, char *root_dir);=0A=
=20=0A=
   virtual void OnInit ();=0A=
   virtual long OnNext ();=0A=
Index: site.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/site.cc,v=0A=
retrieving revision 2.13=0A=
diff -p -u -w -r2.13 site.cc=0A=
--- site.cc	2002/01/20 13:31:04	2.13=0A=
+++ site.cc	2002/01/24 12:50:16=0A=
@@ -291,8 +291,20 @@ do_download_site_info (HINSTANCE hinst,=20=0A=
=20=0A=
 }=0A=
=20=0A=
-bool SitePage::Create ()=0A=
+bool SitePage::Create (bool localinstall, bool ftpsite, char *site)=0A=
 {=0A=
+  if (localinstall) return false;=0A=
+  if (ftpsite)=0A=
+  {=0A=
+    site_list_type *newsite =3D new site_list_type (site);=0A=
+    site_list_type &listobj =3D all_site_list.registerbyobject (*newsite);=
=0A=
+    if (&listobj !=3D newsite)=0A=
+      /* That site was already registered */=0A=
+      delete newsite;=0A=
+    site_list.registerbyobject (listobj);=0A=
+=0A=
+    return false;=0A=
+  }=0A=
   return PropertyPage::Create (IDD_SITE);=0A=
 }=0A=
=20=0A=
Index: site.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/site.h,v=0A=
retrieving revision 2.4=0A=
diff -p -u -w -r2.4 site.h=0A=
--- site.h	2002/01/20 13:31:04	2.4=0A=
+++ site.h	2002/01/24 12:50:16=0A=
@@ -33,7 +33,7 @@ public:=0A=
   {=0A=
   };=0A=
=20=0A=
-  bool Create ();=0A=
+  bool Create (bool localinstall, bool ftpsite, char *mirror_site);=0A=
=20=0A=
   virtual void OnInit ();=0A=
   virtual void OnActivate ();=0A=
Index: source.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/source.cc,v=0A=
retrieving revision 2.10=0A=
diff -p -u -w -r2.10 source.cc=0A=
--- source.cc	2001/12/23 12:13:29	2.10=0A=
+++ source.cc	2002/01/24 12:50:16=0A=
@@ -70,8 +70,20 @@ dialog_cmd (HWND h, int id, HWND hwndctl=0A=
 }=0A=
=20=0A=
 bool=0A=
-SourcePage::Create ()=0A=
+SourcePage::Create (bool netinstall, bool netdownload, bool localinstall)=
=0A=
 {=0A=
+  if (netinstall) {=0A=
+    source =3D IDC_SOURCE_NETINST;=0A=
+    return false;=0A=
+  }=0A=
+  if (netdownload) {=0A=
+    source =3D IDC_SOURCE_DOWNLOAD;=0A=
+    return false;=0A=
+  }=0A=
+  if (localinstall) {=0A=
+    source =3D IDC_SOURCE_CWD;=20=0A=
+    return false;=0A=
+  }=0A=
   return PropertyPage::Create (NULL, dialog_cmd, IDD_SOURCE);=0A=
 }=0A=
=20=0A=
Index: source.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/source.h,v=0A=
retrieving revision 2.2=0A=
diff -p -u -w -r2.2 source.h=0A=
--- source.h	2002/01/03 11:27:11	2.2=0A=
+++ source.h	2002/01/24 12:50:16=0A=
@@ -32,7 +32,7 @@ public:=0A=
   {=0A=
   };=0A=
=20=0A=
-  bool Create ();=0A=
+  bool Create (bool netinstall, bool netdownload, bool localinstall);=0A=
=20=0A=
   virtual void OnActivate ();=0A=
   virtual void OnDeactivate ();=0A=
Index: splash.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/splash.cc,v=0A=
retrieving revision 2.8=0A=
diff -p -u -w -r2.8 splash.cc=0A=
--- splash.cc	2002/01/03 11:27:11	2.8=0A=
+++ splash.cc	2002/01/24 12:50:17=0A=
@@ -23,8 +23,9 @@=0A=
 #include "splash.h"=0A=
=20=0A=
 bool=0A=
-SplashPage::Create ()=0A=
+SplashPage::Create (bool version)=0A=
 {=0A=
+  if (!version) return false;=0A=
   return PropertyPage::Create (IDD_SPLASH);=0A=
 }=0A=
=20=0A=
Index: splash.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/splash.h,v=0A=
retrieving revision 2.2=0A=
diff -p -u -w -r2.2 splash.h=0A=
--- splash.h	2002/01/03 11:27:11	2.2=0A=
+++ splash.h	2002/01/24 12:50:17=0A=
@@ -31,7 +31,7 @@ public:=0A=
   {=0A=
   };=0A=
=20=0A=
-  bool Create ();=0A=
+  bool Create (bool version);=0A=
   virtual void OnInit ();=0A=
 };=0A=
=20=0A=

------=_NextPart_000_0051_01C1A4DA.9C14F710--
