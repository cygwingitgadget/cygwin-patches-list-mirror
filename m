Return-Path: <cygwin-patches-return-4180-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16293 invoked by alias); 8 Sep 2003 21:44:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16284 invoked from network); 8 Sep 2003 21:44:59 -0000
Date: Mon, 08 Sep 2003 21:44:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: rgreab@fx.ro
Subject: Re: fix getpwuid_r() and getpwnam_r()
Message-ID: <20030908214458.GA10128@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, rgreab@fx.ro
References: <20030909.003617.40718540.radu@primIT.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909.003617.40718540.radu@primIT.ro>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00196.txt.bz2

On Tue, Sep 09, 2003 at 12:36:17AM +0300, Radu Greab wrote:
>
>I have not rebuilt cygwin to test this patch, but I think that the
>problem and the fix are obvious: pw_comment is not returned or
>initialized by these reentrant functions. The problem was discovered
>when debugging a perl test failure on cygwin:

Actually, I think the fix is more obvious that yours since pw_comment isn't
used.  I think yours would result in a SEGV.

cgf

Index: passwd.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.71
diff -u -p -r1.71 passwd.cc
--- passwd.cc	16 Jun 2003 03:24:11 -0000	1.71
+++ passwd.cc	8 Sep 2003 21:43:42 -0000
@@ -183,6 +183,7 @@ getpwuid_r32 (__uid32_t uid, struct pass
   pwd->pw_dir = pwd->pw_name + strlen (temppw->pw_name) + 1;
   pwd->pw_shell = pwd->pw_dir + strlen (temppw->pw_dir) + 1;
   pwd->pw_gecos = pwd->pw_shell + strlen (temppw->pw_shell) + 1;
+  pwd->pw_comment = NULL;
   pwd->pw_passwd = pwd->pw_gecos + strlen (temppw->pw_gecos) + 1;
   strcpy (pwd->pw_name, temppw->pw_name);
   strcpy (pwd->pw_dir, temppw->pw_dir);
