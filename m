Return-Path: <cygwin-patches-return-4179-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12023 invoked by alias); 8 Sep 2003 21:36:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12013 invoked from network); 8 Sep 2003 21:36:23 -0000
Date: Mon, 08 Sep 2003 21:36:00 -0000
Message-Id: <20030909.003617.40718540.radu@primIT.ro>
To: cygwin-patches@cygwin.com
Subject: fix getpwuid_r() and getpwnam_r()
From: Radu Greab <rgreab@fx.ro>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.4(snapshot 20030410) (teddy.ms.fx.ro)
X-SW-Source: 2003-q3/txt/msg00195.txt.bz2


I have not rebuilt cygwin to test this patch, but I think that the
problem and the fix are obvious: pw_comment is not returned or
initialized by these reentrant functions. The problem was discovered
when debugging a perl test failure on cygwin:

http://www.xray.mpe.mpg.de/mailing-lists/perl5-porters/2003-09/msg00500.html

Thanks,
Radu Greab


--- cygwin-1.5.3-1/winsup/cygwin/passwd.cc.orig	Sat Jun 21 03:12:35 2003
+++ cygwin-1.5.3-1/winsup/cygwin/passwd.cc	Tue Sep  9 00:22:50 2003
@@ -171,7 +171,8 @@
   /* check needed buffer size. */
   size_t needsize = strlen (temppw->pw_name) + strlen (temppw->pw_dir) +
 		    strlen (temppw->pw_shell) + strlen (temppw->pw_gecos) +
-		    strlen (temppw->pw_passwd) + 5;
+		    strlen (temppw->pw_passwd) +
+		    strlen (temppw->pw_comment) + 6;
   if (needsize > bufsize)
     return ERANGE;
 
@@ -184,11 +185,13 @@
   pwd->pw_shell = pwd->pw_dir + strlen (temppw->pw_dir) + 1;
   pwd->pw_gecos = pwd->pw_shell + strlen (temppw->pw_shell) + 1;
   pwd->pw_passwd = pwd->pw_gecos + strlen (temppw->pw_gecos) + 1;
+  pwd->pw_comment = pwd->pw_passwd + strlen (temppw->pw_passwd) + 1;
   strcpy (pwd->pw_name, temppw->pw_name);
   strcpy (pwd->pw_dir, temppw->pw_dir);
   strcpy (pwd->pw_shell, temppw->pw_shell);
   strcpy (pwd->pw_gecos, temppw->pw_gecos);
   strcpy (pwd->pw_passwd, temppw->pw_passwd);
+  strcpy (pwd->pw_comment, temppw->pw_comment);
   return 0;
 }
 
@@ -228,7 +231,8 @@
   /* check needed buffer size. */
   size_t needsize = strlen (temppw->pw_name) + strlen (temppw->pw_dir) +
 		    strlen (temppw->pw_shell) + strlen (temppw->pw_gecos) +
-		    strlen (temppw->pw_passwd) + 5;
+		    strlen (temppw->pw_passwd) +
+		    strlen (temppw->pw_comment) + 6;
   if (needsize > bufsize)
     return ERANGE;
 
@@ -241,11 +245,13 @@
   pwd->pw_shell = pwd->pw_dir + strlen (temppw->pw_dir) + 1;
   pwd->pw_gecos = pwd->pw_shell + strlen (temppw->pw_shell) + 1;
   pwd->pw_passwd = pwd->pw_gecos + strlen (temppw->pw_gecos) + 1;
+  pwd->pw_comment = pwd->pw_passwd + strlen (temppw->pw_passwd) + 1;
   strcpy (pwd->pw_name, temppw->pw_name);
   strcpy (pwd->pw_dir, temppw->pw_dir);
   strcpy (pwd->pw_shell, temppw->pw_shell);
   strcpy (pwd->pw_gecos, temppw->pw_gecos);
   strcpy (pwd->pw_passwd, temppw->pw_passwd);
+  strcpy (pwd->pw_comment, temppw->pw_comment);
   return 0;
 }
 
