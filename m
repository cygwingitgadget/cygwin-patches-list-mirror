Return-Path: <cygwin-patches-return-5315-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5006 invoked by alias); 25 Jan 2005 20:54:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4890 invoked from network); 25 Jan 2005 20:54:27 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 25 Jan 2005 20:54:27 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id IAW4QH-0000KJ-MD
	for cygwin-patches@cygwin.com; Tue, 25 Jan 2005 15:54:18 -0500
Message-ID: <41F6B1F6.5207C318@phumblet.no-ip.org>
Date: Tue, 25 Jan 2005 20:54:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch]: setting errno to ENOTDIR rather than ENOENT
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q1/txt/msg00018.txt.bz2

This patch should take care of the error reported by 
Eric Blake on the list, at least for disk files.

It also removes code under the condition
(opt & PC_SYM_IGNORE) && pcheck_case == PCHECK_RELAXED
which is never true, AFAICS.

It also gets rid of an obsolete function.

While testing, the assert (!i); on line 259 of pinfo.cc
kicks in. That's a feature because when flag & PID_EXECED
the code just loops, keeping the same h0 and mapname!
Am I the only one to see that?

Pierre


2005-01-25  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (path_conv::check): Return ENOTDIR rather than ENOENT
	when a component is not a directory. Remove unreachable code.
	(digits): Delete.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.338
diff -u -p -r1.338 path.cc
--- path.cc     18 Jan 2005 13:00:18 -0000      1.338
+++ path.cc     25 Jan 2005 20:08:53 -0000
@@ -655,12 +655,6 @@ path_conv::check (const char *src, unsig
              full_path[3] = '\0';
            }
 
-         if ((opt & PC_SYM_IGNORE) && pcheck_case == PCHECK_RELAXED)
-           {
-             fileattr = GetFileAttributes (this->path);
-             goto out;
-           }
-
          symlen = sym.check (full_path, suff, opt | fs.has_ea ());
 
          if (sym.minor || sym.major)
@@ -680,7 +674,7 @@ path_conv::check (const char *src, unsig
              if (pcheck_case == PCHECK_STRICT)
                {
                  case_clash = true;
-                 error = ENOENT;
+                 error = component?ENOTDIR:ENOENT;
                  goto out;
                }
              /* If pcheck_case==PCHECK_ADJUST the case_clash is remembered
@@ -706,6 +700,11 @@ path_conv::check (const char *src, unsig
                  error = sym.error;
                  if (component == 0)
                    add_ext_from_sym (sym);
+                  else if (!(sym.fileattr & FILE_ATTRIBUTE_DIRECTORY))
+                    {
+                      error = ENOTDIR;
+                     goto out;
+                    }  
                  if (pcheck_case == PCHECK_RELAXED)
                    goto out;   // file found
                  /* Avoid further symlink evaluation. Only case checks are
@@ -939,15 +938,6 @@ path_conv::~path_conv ()
     }
 }
 
-static __inline int
-digits (const char *name)
-{
-  char *p;
-  int n = strtol (name, &p, 10);
-
-  return p > name && !*p ? n : -1;
-}
-
 /* Return true if src_path is a valid, internally supported device name.
    In that case, win32_path gets the corresponding NT device name and
    dev is appropriately filled with device information. */
