Return-Path: <cygwin-patches-return-5302-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29787 invoked by alias); 11 Jan 2005 20:49:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29738 invoked from network); 11 Jan 2005 20:48:55 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 11 Jan 2005 20:48:55 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id IA675H-00006W-QU
	for cygwin-patches@cygwin.com; Tue, 11 Jan 2005 15:48:54 -0500
Message-ID: <41E43BB5.714062AA@phumblet.no-ip.org>
Date: Tue, 11 Jan 2005 20:49:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch] mkpasswd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q1/txt/msg00005.txt.bz2

This improves error reporting

Pierre


2005-01-11  Pierre Humblet <pierre.humblet@ieee.org>

	* mkpasswd.c (print_win_error): Transform into macro.
	(_print_win_error): Upgrade former print_win_error by
	 printing the line.
	(current_user): Call _print_win_error.
	(enum_users): Print name in case of lookup failure.
	(enum_local_groups): Ditto.


Index: mkpasswd.c
===================================================================
RCS file: /cvs/src/src/winsup/utils/mkpasswd.c,v
retrieving revision 1.33
diff -u -p -r1.33 mkpasswd.c
--- mkpasswd.c  14 Nov 2003 19:14:43 -0000      1.33
+++ mkpasswd.c  11 Jan 2005 20:44:29 -0000
@@ -23,6 +23,8 @@
 #include <lmerr.h>
 #include <lmcons.h>
 
+#define print_win_error(x) _print_win_error(x, __LINE__)
+
 static const char version[] = "$Revision: 1.20 $";
 
 SID_IDENTIFIER_AUTHORITY sid_world_auth = {SECURITY_WORLD_SID_AUTHORITY};
@@ -111,7 +113,7 @@ uni2ansi (LPWSTR wcs, char *mbs, int siz
 }
 
 void
-print_win_error(DWORD code)
+_print_win_error(DWORD code, int line)
 {
   char buf[4096];
 
@@ -121,9 +123,9 @@ print_win_error(DWORD code)
       code,
       MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
       (LPTSTR) buf, sizeof (buf), NULL))
-    fprintf (stderr, "mkpasswd: [%lu] %s", code, buf);
+    fprintf (stderr, "mkpasswd (%d): [%lu] %s", line, code, buf);
   else
-    fprintf (stderr, "mkpasswd: error %lu", code);
+    fprintf (stderr, "mkpasswd (%d): error %lu", line, code);
 }
 
 void
@@ -159,10 +161,7 @@ current_user (int print_sids, int print_
       || (!CloseHandle (ptok) && (errpos = __LINE__)))
     {
       if (errpos)
-       {
-         print_win_error (GetLastError ());
-         fprintf(stderr, " on line %d\n", errpos);
-       }
+       _print_win_error (GetLastError (), errpos);
       return;
     }
 
@@ -309,6 +308,7 @@ enum_users (LPWSTR servername, int print
                                      &acc_type))
                {
                  print_win_error(GetLastError ());
+                 fprintf(stderr, " (%s)\n", username);
                  continue;
                }
              else if (acc_type == SidTypeDomain)
@@ -327,6 +327,7 @@ enum_users (LPWSTR servername, int print
                                          &acc_type))
                    {
                      print_win_error(GetLastError ());
+                     fprintf(stderr, " (%s)\n", domname);
                      continue;
                    }
                }
@@ -401,6 +402,7 @@ enum_local_groups (int print_sids)
                                  &acc_type))
            {
              print_win_error(GetLastError ());
+             fprintf(stderr, " (%s)\n", localgroup_name);
              continue;
            }
          else if (acc_type == SidTypeDomain)
@@ -418,6 +420,7 @@ enum_local_groups (int print_sids)
                                      &acc_type))
                {
                  print_win_error(GetLastError ());
+                 fprintf(stderr, " (%s)\n", domname);
                  continue;
                }
            }
