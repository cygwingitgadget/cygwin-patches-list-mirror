Return-Path: <cygwin-patches-return-7766-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24184 invoked by alias); 26 Oct 2012 20:13:21 -0000
Received: (qmail 24165 invoked by uid 22791); 26 Oct 2012 20:13:15 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0	tests=AWL,BAYES_00,DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,KHOP_RCVD_TRUST,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_CL,TW_CP
X-Spam-Check-By: sourceware.org
Received: from mail-ee0-f43.google.com (HELO mail-ee0-f43.google.com) (74.125.83.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 26 Oct 2012 20:13:08 +0000
Received: by mail-ee0-f43.google.com with SMTP id c13so1306564eek.2        for <cygwin-patches@cygwin.com>; Fri, 26 Oct 2012 13:13:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.14.220.71 with SMTP id n47mr35823089eep.26.1351282387236; Fri, 26 Oct 2012 13:13:07 -0700 (PDT)
Received: by 10.14.213.134 with HTTP; Fri, 26 Oct 2012 13:13:07 -0700 (PDT)
Date: Fri, 26 Oct 2012 20:13:00 -0000
Message-ID: <CAEwic4Yw5AQVMk_wCyru5oZw7z-ghowc1Yu_mj_Z9Z5rmuHPqg@mail.gmail.com>
Subject: [patch cygwin]: Rename strechr to strchrnul
From: Kai Tietz <ktietz70@googlemail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00043.txt.bz2

Hello,

this patch replaces strechr by strchrnul symbol-name.  The strchrnul
name is that one also present in new-libc for this function behavior.
ChangeLog

2012-10-26  Kai Tietz

	* dcrt0.cc (quoted): Renamed strechr to strchrnul.
	* environ.cc (environ_init): Likewise.
	* sec_acl.cc (aclfromtext32): Likewise.
	* sec_auth.cc (extract_nt_dom_user): Likewise.
	* uinfo.cc (pwdgrp::next_str): Likewise.
	* string.h (strechr): Likewise.

Ok for apply?

Regards,
Kai

Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.434
diff -p -u -r1.434 dcrt0.cc
--- dcrt0.cc	9 Aug 2012 19:58:52 -0000	1.434
+++ dcrt0.cc	26 Oct 2012 20:06:23 -0000
@@ -162,7 +162,7 @@ quoted (char *cmd, int winshell)
     {
       char *p;
       strcpy (cmd, cmd + 1);
-      if (*(p = strechr (cmd, quote)))
+      if (*(p = strchrnul (cmd, quote)))
 	strcpy (p, p + 1);
       return p;
     }
Index: environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.200
diff -p -u -r1.200 environ.cc
--- environ.cc	28 Apr 2012 19:49:57 -0000	1.200
+++ environ.cc	26 Oct 2012 20:06:23 -0000
@@ -829,7 +829,7 @@ environ_init (char **envp, int envc)
       envp[i] = newp;
       if (*newp == '=')
 	*newp = '!';
-      char *eq = strechr (newp, '=');
+      char *eq = strchrnul (newp, '=');
       ucenv (newp, eq);	/* uppercase env vars which need it */
       if (*newp == 'T' && strncmp (newp, "TERM=", 5) == 0)
 	sawTERM = 1;
Index: sec_acl.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_acl.cc,v
retrieving revision 1.72
diff -p -u -r1.72 sec_acl.cc
--- sec_acl.cc	29 Mar 2012 15:01:18 -0000	1.72
+++ sec_acl.cc	26 Oct 2012 20:06:23 -0000
@@ -861,7 +861,7 @@ aclfromtext32 (char *acltextp, int *)
 		      return NULL;
 		    }
 		  lacl[pos].a_id = pw->pw_uid;
-		  c = strechr (c, ':');
+		  c = strchrnul (c, ':');
 		}
 	      else if (isdigit (*c))
 		lacl[pos].a_id = strtol (c, &c, 10);
@@ -889,7 +889,7 @@ aclfromtext32 (char *acltextp, int *)
 		      return NULL;
 		    }
 		  lacl[pos].a_id = gr->gr_gid;
-		  c = strechr (c, ':');
+		  c = strchrnul (c, ':');
 		}
 	      else if (isdigit (*c))
 		lacl[pos].a_id = strtol (c, &c, 10);
Index: sec_auth.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_auth.cc,v
retrieving revision 1.44
diff -p -u -r1.44 sec_auth.cc
--- sec_auth.cc	22 Dec 2011 11:02:34 -0000	1.44
+++ sec_auth.cc	26 Oct 2012 20:06:23 -0000
@@ -120,8 +120,8 @@ extract_nt_dom_user (const struct passwd
   if ((d = strstr (pw->pw_gecos, "U-")) != NULL &&
       (d == pw->pw_gecos || d[-1] == ','))
     {
-      c = strechr (d + 2, ',');
-      if ((u = strechr (d + 2, '\\')) >= c)
+      c = strchrnul (d + 2, ',');
+      if ((u = strchrnul (d + 2, '\\')) >= c)
        u = d + 1;
       else if (u - d <= MAX_DOMAIN_NAME_LEN + 2)
        sys_mbstowcs (domain, MAX_DOMAIN_NAME_LEN + 1, d + 2, u - d - 1);
Index: string.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/string.h,v
retrieving revision 1.15
diff -p -u -r1.15 string.h
--- string.h	26 Oct 2012 20:00:12 -0000	1.15
+++ string.h	26 Oct 2012 20:06:23 -0000
@@ -17,10 +17,10 @@ details. */
 extern "C" {
 #endif

-#undef strechr
-#define strechr cygwin_strechr
+#undef strchrnul
+#define strchrnul cygwin_strchrnul
 static inline __stdcall char *
-strechr (const char *s, int c)
+strchrnul (const char *s, int c)
 {
   while (*s != (char) c && *s != 0)
     ++s;
Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.188
diff -p -u -r1.188 uinfo.cc
--- uinfo.cc	14 Feb 2012 11:27:43 -0000	1.188
+++ uinfo.cc	26 Oct 2012 20:06:23 -0000
@@ -489,7 +489,7 @@ char *
 pwdgrp::next_str (char c)
 {
   char *res = lptr;
-  lptr = strechr (lptr, c);
+  lptr = strchrnul (lptr, c);
   if (*lptr)
     *lptr++ = '\0';
   return res;
