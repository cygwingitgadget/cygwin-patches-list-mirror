Return-Path: <cygwin-patches-return-1974-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20943 invoked by alias); 11 Mar 2002 18:16:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20862 invoked from network); 11 Mar 2002 18:16:34 -0000
Message-ID: <20020311181627.8971.qmail@web20001.mail.yahoo.com>
Date: Mon, 11 Mar 2002 10:31:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: (small) kill.cc patch
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-71534906-1015870587=:5027"
X-SW-Source: 2002-q1/txt/msg00331.txt.bz2

--0-71534906-1015870587=:5027
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 431

Here is a patch that moves the functions in kill.cc to the top.
That's all it does.

This is for consistency with the other utils.

2001-03-11 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
* kill.cc (usage) move to top of file
          (getsig) ditto
          (forcekill) ditto


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
--0-71534906-1015870587=:5027
Content-Type: text/plain; name="kill.cc-patch"
Content-Description: kill.cc-patch
Content-Disposition: inline; filename="kill.cc-patch"
Content-length: 1918

--- kill.cc-orig	Sun Feb 24 13:28:27 2002
+++ kill.cc	Mon Mar 11 12:07:40 2002
@@ -17,9 +17,42 @@ details. */
 #include <windows.h>
 #include <sys/cygwin.h>
 
-static void usage (void);
-static int __stdcall getsig (char *);
-static void __stdcall forcekill (int, int, int);
+static void
+usage (void)
+{
+  fprintf (stderr, "Usage: kill [-sigN] pid1 [pid2 ...]\n");
+  exit (1);
+}
+
+static int
+getsig (char *in_sig)
+{
+  char *sig;
+  char buf[80];
+
+  if (strncmp (in_sig, "SIG", 3) == 0)
+    sig = in_sig;
+  else
+    {
+      sprintf (buf, "SIG%s", in_sig);
+      sig = buf;
+    }
+  return (strtosigno (sig) ?: atoi (in_sig));
+}
+
+static void __stdcall
+forcekill (int pid, int sig, int wait)
+{
+  external_pinfo *p = (external_pinfo *) cygwin_internal (CW_GETPINFO_FULL, pid);
+  if (!p)
+    return;
+  HANDLE h = OpenProcess (PROCESS_TERMINATE, FALSE, (DWORD) p->dwProcessId);
+  if (!h)
+    return;
+  if (!wait || WaitForSingleObject (h, 200) != WAIT_OBJECT_0)
+    TerminateProcess (h, sig << 8);
+  CloseHandle (h);
+}
 
 int
 main (int argc, char **argv)
@@ -82,41 +115,4 @@ sig0:
       argv++;
     }
   return ret;
-}
-
-static void
-usage (void)
-{
-  fprintf (stderr, "Usage: kill [-sigN] pid1 [pid2 ...]\n");
-  exit (1);
-}
-
-static int
-getsig (char *in_sig)
-{
-  char *sig;
-  char buf[80];
-
-  if (strncmp (in_sig, "SIG", 3) == 0)
-    sig = in_sig;
-  else
-    {
-      sprintf (buf, "SIG%s", in_sig);
-      sig = buf;
-    }
-  return (strtosigno (sig) ?: atoi (in_sig));
-}
-
-static void __stdcall
-forcekill (int pid, int sig, int wait)
-{
-  external_pinfo *p = (external_pinfo *) cygwin_internal (CW_GETPINFO_FULL, pid);
-  if (!p)
-    return;
-  HANDLE h = OpenProcess (PROCESS_TERMINATE, FALSE, (DWORD) p->dwProcessId);
-  if (!h)
-    return;
-  if (!wait || WaitForSingleObject (h, 200) != WAIT_OBJECT_0)
-    TerminateProcess (h, sig << 8);
-  CloseHandle (h);
 }

--0-71534906-1015870587=:5027--
