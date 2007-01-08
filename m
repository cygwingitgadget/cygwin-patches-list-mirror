Return-Path: <cygwin-patches-return-6030-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14061 invoked by alias); 8 Jan 2007 18:33:19 -0000
Received: (qmail 14049 invoked by uid 22791); 8 Jan 2007 18:33:17 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout01.sul.t-online.com (HELO mailout01.sul.t-online.com) (194.25.134.80)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 08 Jan 2007 18:33:08 +0000
Received: from fwd33.aul.t-online.de  	by mailout01.sul.t-online.com with smtp  	id 1H3zIv-00037P-04; Mon, 08 Jan 2007 19:33:05 +0100
Received: from [10.3.2.2] (Zwh7nvZ-ge-1CIT4wdbZ8dPPkNyuL9k+nIl1uojPb76T57vnvaC3o-@[217.235.225.173]) by fwd33.sul.t-online.de 	with esmtp id 1H3zIk-16nFbM0; Mon, 8 Jan 2007 19:32:54 +0100
Message-ID: <45A28E57.1040301@t-online.de>
Date: Mon, 08 Jan 2007 18:33:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [Patch] cygpath -O and -F options (was: Two short scripts for Cygwin-Windows  interoperation)
References: <loom.20070104T172439-137@post.gmane.org> <Pine.GSO.4.63.0701041220120.15041@access1.cims.nyu.edu> <459D5852.8010407@t-online.de> <Pine.GSO.4.63.0701041641350.15041@access1.cims.nyu.edu> <459D822A.103@t-online.de> <20070105093149.GA28768@calimero.vinschen.de> <45A15636.9000109@t-online.de> <20070108094743.GA22258@calimero.vinschen.de>
In-Reply-To: <20070108094743.GA22258@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------080507010802080408030106"
X-ID: Zwh7nvZ-ge-1CIT4wdbZ8dPPkNyuL9k+nIl1uojPb76T57vnvaC3o-
X-TOI-MSGID: 75f814bf-fb49-4d76-aad9-e51e811d3eb9
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00011.txt.bz2

This is a multi-part message in MIME format.
--------------080507010802080408030106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 378

[Initially sent to cygwin instead of cygwin-patches]

2007-01-07    Christian Franke <franke@computer.org>

   * cygpath.cc (usage): Add -O and -F, remove tabs.
   (get_special_folder): New function.
   (get_user_folder): New function.
   (dowin): Add -O and -F, better -D, -P error handling.
   (main): Add -O and -F.
   * utils.sgml (cygpath): Document -O and -F.

Christian


--------------080507010802080408030106
Content-Type: text/plain;
 name="cygpath-folders.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygpath-folders.patch.txt"
Content-length: 10428

diff -urp cygwin-1.5.23-2.orig/winsup/utils/cygpath.cc cygwin-1.5.23-2/winsup/utils/cygpath.cc
--- cygwin-1.5.23-2.orig/winsup/utils/cygpath.cc	2006-02-17 13:17:47.001000000 +0100
+++ cygwin-1.5.23-2/winsup/utils/cygpath.cc	2007-01-07 20:27:10.890625000 +0100
@@ -25,7 +25,7 @@ details. */
 static const char version[] = "$Revision: 1.42 $";
 
 static char *prog_name;
-static char *file_arg;
+static char *file_arg, *output_arg;
 static int path_flag, unix_flag, windows_flag, absolute_flag;
 static int shortname_flag, longname_flag;
 static int ignore_flag, allusers_flag, output_flag;
@@ -52,13 +52,15 @@ static struct option long_options[] = {
   {(char *) "allusers", no_argument, NULL, 'A'},
   {(char *) "desktop", no_argument, NULL, 'D'},
   {(char *) "homeroot", no_argument, NULL, 'H'},
+  {(char *) "mydocs", no_argument, NULL, 'O'},
   {(char *) "smprograms", no_argument, NULL, 'P'},
   {(char *) "sysdir", no_argument, NULL, 'S'},
   {(char *) "windir", no_argument, NULL, 'W'},
+  {(char *) "folder", required_argument, NULL, 'F'},
   {0, no_argument, 0, 0}
 };
 
-static char options[] = "ac:df:hilmMopst:uvwADHPSW";
+static char options[] = "ac:df:hilmMopst:uvwADHOPSWF:";
 
 static void
 usage (FILE * stream, int status)
@@ -67,29 +69,32 @@ usage (FILE * stream, int status)
     fprintf (stream, "\
 Usage: %s (-d|-m|-u|-w|-t TYPE) [-f FILE] [OPTION]... NAME...\n\
        %s [-c HANDLE] \n\
-       %s [-ADHPSW] \n\
+       %s [-ADHOPSW] \n\
+       %s [-F ID] \n\
 Convert Unix and Windows format paths, or output system path information\n\
 \n\
 Output type options:\n\
-  -d, --dos	        print DOS (short) form of NAMEs (C:\\PROGRA~1\\)\n\
+  -d, --dos             print DOS (short) form of NAMEs (C:\\PROGRA~1\\)\n\
   -m, --mixed           like --windows, but with regular slashes (C:/WINNT)\n\
-  -M, --mode		report on mode of file (binmode or textmode)\n\
-  -u, --unix	        (default) print Unix form of NAMEs (/cygdrive/c/winnt)\n\
+  -M, --mode            report on mode of file (binmode or textmode)\n\
+  -u, --unix            (default) print Unix form of NAMEs (/cygdrive/c/winnt)\n\
   -w, --windows         print Windows form of NAMEs (C:\\WINNT)\n\
   -t, --type TYPE       print TYPE form: 'dos', 'mixed', 'unix', or 'windows'\n\
 Path conversion options:\n\
   -a, --absolute        output absolute path\n\
-  -l, --long-name	print Windows long form of NAMEs (with -w, -m only)\n\
-  -p, --path	        NAME is a PATH list (i.e., '/bin:/usr/bin')\n\
-  -s, --short-name	print DOS (short) form of NAMEs (with -w, -m only)\n\
+  -l, --long-name       print Windows long form of NAMEs (with -w, -m only)\n\
+  -p, --path            NAME is a PATH list (i.e., '/bin:/usr/bin')\n\
+  -s, --short-name      print DOS (short) form of NAMEs (with -w, -m only)\n\
 System information:\n\
-  -A, --allusers        use `All Users' instead of current user for -D, -P\n\
-  -D, --desktop		output `Desktop' directory and exit\n\
+  -A, --allusers        use `All Users' instead of current user for -D, -O, -P\n\
+  -D, --desktop         output `Desktop' directory and exit\n\
   -H, --homeroot        output `Profiles' directory (home root) and exit\n\
-  -P, --smprograms	output Start Menu `Programs' directory and exit\n\
-  -S, --sysdir		output system directory and exit\n\
-  -W, --windir		output `Windows' directory and exit\n\
-", prog_name, prog_name, prog_name);
+  -O, --mydocs          output `My Documents' directory and exit\n\
+  -P, --smprograms      output Start Menu `Programs' directory and exit\n\
+  -S, --sysdir          output system directory and exit\n\
+  -W, --windir          output `Windows' directory and exit\n\
+  -F, --folder ID       output special folder with numeric ID and exit\n\
+", prog_name, prog_name, prog_name, prog_name);
   if (ignore_flag)
     /* nothing to do */;
   else if (stream != stdout)
@@ -101,9 +106,9 @@ Other options:\n\
   -f, --file FILE       read FILE for input; use - to read from STDIN\n\
   -o, --option          read options from FILE as well (for use with --file)\n\
   -c, --close HANDLE    close HANDLE (for use in captured process)\n\
-  -i, --ignore		ignore missing argument\n\
+  -i, --ignore          ignore missing argument\n\
   -h, --help            output usage information and exit\n\
-  -v, --version		output version information and exit\n\
+  -v, --version         output version information and exit\n\
 ");
     }
   exit (ignore_flag ? 0 : status);
@@ -330,41 +335,60 @@ get_mixed_name (const char* filename)
   return mixed_buf;
 }
 
+static bool
+get_special_folder (char* path, int id)
+{
+  path[0] = 0;
+  LPITEMIDLIST pidl = 0;
+  if (SHGetSpecialFolderLocation (NULL, id, &pidl) != S_OK)
+    return false;
+  if (!SHGetPathFromIDList (pidl, path) || !path[0])
+    return false;
+  return true;
+}
+
+static void
+get_user_folder (char* path, int id, int allid)
+{
+  if (!get_special_folder (path, allusers_flag ? allid : id) && allusers_flag)
+    get_special_folder (path, id); // Fix for Win9x without any "All Users"
+}
+
 static void
 dowin (char option)
 {
   char *buf, buf1[MAX_PATH], buf2[MAX_PATH];
   DWORD len = MAX_PATH;
   WIN32_FIND_DATA w32_fd;
-  LPITEMIDLIST id;
   HINSTANCE k32;
   BOOL (*GetProfilesDirectoryAPtr) (LPSTR, LPDWORD) = 0;
 
   buf = buf1;
+  buf[0] = 0;
   switch (option)
     {
     case 'D':
-      SHGetSpecialFolderLocation (NULL, allusers_flag ?
-	CSIDL_COMMON_DESKTOPDIRECTORY : CSIDL_DESKTOPDIRECTORY, &id);
-      SHGetPathFromIDList (id, buf);
-      /* This if clause is a Fix for Win95 without any "All Users" */
-      if (strlen (buf) == 0)
-	{
-	  SHGetSpecialFolderLocation (NULL, CSIDL_DESKTOPDIRECTORY, &id);
-	  SHGetPathFromIDList (id, buf);
-	}
+      get_user_folder (buf, CSIDL_DESKTOPDIRECTORY, CSIDL_COMMON_DESKTOPDIRECTORY);
       break;
 
     case 'P':
-      SHGetSpecialFolderLocation (NULL, allusers_flag ?
-	CSIDL_COMMON_PROGRAMS : CSIDL_PROGRAMS, &id);
-      SHGetPathFromIDList (id, buf);
-      /* This if clause is a Fix for Win95 without any "All Users" */
-      if (strlen (buf) == 0)
-	{
-	  SHGetSpecialFolderLocation (NULL, CSIDL_PROGRAMS, &id);
-	  SHGetPathFromIDList (id, buf);
-	}
+      get_user_folder (buf, CSIDL_PROGRAMS, CSIDL_COMMON_PROGRAMS);
+      break;
+
+    case 'O':
+      get_user_folder (buf, CSIDL_PERSONAL, CSIDL_COMMON_DOCUMENTS);
+      break;
+
+    case 'F':
+      {
+	int val = -1, len = -1;
+	if (!(sscanf (output_arg, "%i%n", &val, &len) == 1 && len == strlen (output_arg) && val >= 0))
+	  {
+	    fprintf (stderr, "%s: syntax error in special folder ID %s\n", prog_name, output_arg);
+	    exit (1);
+	  }
+        get_special_folder (buf, val);
+      }
       break;
 
     case 'H':
@@ -395,7 +419,11 @@ dowin (char option)
       usage (stderr, 1);
     }
 
-  if (!windows_flag)
+  if (!buf[0])
+    {
+      fprintf (stderr, "%s: failed to retrieve special folder path\n", prog_name);
+    }
+  else if (!windows_flag)
     {
       if (cygwin_conv_to_posix_path (buf, buf2))
 	fprintf (stderr, "%s: error converting \"%s\" - %s\n",
@@ -671,6 +699,7 @@ main (int argc, char **argv)
 
 	case 'D':
 	case 'H':
+	case 'O':
 	case 'P':
 	case 'S':
 	case 'W':
@@ -680,6 +709,14 @@ main (int argc, char **argv)
 	  o = c;
 	  break;
 
+	case 'F':
+	  if (output_flag || !optarg)
+	    usage (stderr, 1);
+	  output_flag = 1;
+	  output_arg = optarg;
+	  o = c;
+	  break;
+
 	case 'i':
 	  ignore_flag = 1;
 	  break;
@@ -789,6 +826,7 @@ main (int argc, char **argv)
 		    break;
 		  case 'D':
 		  case 'H':
+		  case 'O':
 		  case 'P':
 		  case 'S':
 		  case 'W':
diff -urp cygwin-1.5.23-2.orig/winsup/utils/utils.sgml cygwin-1.5.23-2/winsup/utils/utils.sgml
--- cygwin-1.5.23-2.orig/winsup/utils/utils.sgml	2006-03-03 10:43:35.001000000 +0100
+++ cygwin-1.5.23-2/winsup/utils/utils.sgml	2007-01-07 20:27:17.781250000 +0100
@@ -191,13 +191,14 @@ for example:</para>
 <screen>
 Usage: cygpath (-d|-m|-u|-w|-t TYPE) [-f FILE] [OPTION]... NAME...
        cygpath [-c HANDLE] 
-       cygpath [-ADHPSW] 
+       cygpath [-ADHOPSW] 
+       cygpath [-F ID] 
 Convert Unix and Windows format paths, or output system path information
 
 Output type options:
   -d, --dos             print DOS (short) form of NAMEs (C:\PROGRA~1\)
   -m, --mixed           like --windows, but with regular slashes (C:/WINNT)
-  -M, --mode		report on mode of file (currently binmode or textmode)
+  -M, --mode            report on mode of file (currently binmode or textmode)
   -u, --unix            (default) print Unix form of NAMEs (/cygdrive/c/winnt)
   -w, --windows         print Windows form of NAMEs (C:\WINNT)
   -t, --type TYPE       print TYPE form: 'dos', 'mixed', 'unix', or 'windows'
@@ -210,9 +211,11 @@ System information:
   -A, --allusers        use `All Users' instead of current user for -D, -P
   -D, --desktop         output `Desktop' directory and exit
   -H, --homeroot        output `Profiles' directory (home root) and exit
+  -O, --mydocs          output `My Documents' directory and exit
   -P, --smprograms      output Start Menu `Programs' directory and exit
   -S, --sysdir          output system directory and exit
   -W, --windir          output `Windows' directory and exit
+  -F, --folder ID       output special folder with numeric ID and exit
 Other options:
   -f, --file FILE       read FILE for input; use - to read from STDIN
   -o, --option          read options from FILE as well (for use with --file)
@@ -290,7 +293,13 @@ by Windows that are not the same on all 
 The <literal>-H</literal> shows the Windows profiles directory that can 
 be used as root of home.  The <literal>-A</literal> option forces use of 
 the "All Users" directories instead of the current user for the 
-<literal>-D</literal> and <literal>-P</literal> options. 
+<literal>-D</literal>, <literal>-O</literal> and <literal>-P</literal> 
+options.
+The <literal>-F</literal> outputs other special folders specified by
+their internal numeric code (decimal or 0xhex). For valid codes and
+symbolic names, see the CSIDL_* definitions in the include file
+/usr/include/w32api/shlobj.h from package w32api. The current valid
+range of codes for folders is 0 (Desktop) to 59 (CDBurn area).
 On Win9x systems with only a single user, <literal>-A</literal> has no
 effect; <literal>-D</literal> and <literal>-AD</literal> would have the
 same output.  By default the output is in UNIX (POSIX) format; 

--------------080507010802080408030106--
