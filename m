From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: preliminary patch2 for i18n: change the code page to ANSI.
Date: Tue, 04 Jul 2000 07:04:00 -0000
Message-id: <s1s4s66ngar.fsf@jaist.ac.jp>
References: <s1saefyooqa.fsf@jaist.ac.jp> <20000703190459.A30846@cygnus.com> <s1s8zviodkm.fsf@jaist.ac.jp> <20000703222950.A5294@cygnus.com> <s1s7lb2oa1d.fsf@jaist.ac.jp> <3961C3A6.A56E102@cygnus.com>
X-SW-Source: 2000-q3/msg00007.html

>>> On Tue, 04 Jul 2000 12:59:50 +0200
>>> Corinna Vinschen <vinschen@cygnus.com> said:

> Only one thing: Did you notice the use of OemToChar() in
> security.cc::read_sd()?
> It was necessary to get GetFileSecurity() working with umlauts.
> 
> Shouldn't this be changed then, too?

Yes, it should be changed. I failed to include the change of
security.cc in my previous mail. Thank you for your notice.

ChangeLog:
2000-07-04  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	security.cc (read_sd): Eliminate OemToChar.

Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.11
diff -u -p -r1.11 security.cc
--- security.cc	2000/07/02 10:17:44	1.11
+++ security.cc	2000/07/04 13:54:13
@@ -487,9 +487,7 @@ read_sd(const char *file, PSECURITY_DESC
   debug_printf("file = %s", file);
 
   DWORD len = 0;
-  char fbuf[PATH_MAX];
-  OemToChar(file, fbuf);
-  if (! GetFileSecurity (fbuf,
+  if (! GetFileSecurity (file,
                          OWNER_SECURITY_INFORMATION
                          | GROUP_SECURITY_INFORMATION
                          | DACL_SECURITY_INFORMATION,

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
