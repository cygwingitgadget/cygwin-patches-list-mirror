Return-Path: <cygwin-patches-return-6613-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4355 invoked by alias); 3 Sep 2009 19:19:14 -0000
Received: (qmail 4344 invoked by uid 22791); 3 Sep 2009 19:19:13 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-54-238.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.54.238)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 03 Sep 2009 19:19:05 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 338B613C0C4 	for <cygwin-patches@cygwin.com>; Thu,  3 Sep 2009 15:18:56 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 301BB2B352; Thu,  3 Sep 2009 15:18:56 -0400 (EDT)
Date: Thu, 03 Sep 2009 19:19:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
Message-ID: <20090903191856.GB3998@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20090903T175736-252@post.gmane.org>  <4AA01449.6060707@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AA01449.6060707@byu.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00067.txt.bz2

On Thu, Sep 03, 2009 at 01:08:57PM -0600, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>According to Eric Blake on 9/3/2009 9:58 AM:
>> faccessat has at least two, and probably three bugs.
>
>Here's a fix for 1 (typo) and 3 (check for EINVAL in more places), but not
>for 2 (euidaccess, and the followup request of lchmod).
>
>2009-09-03  Eric Blake  <ebb9@byu.net>
>
>	* syscalls.cc (faccessat): Fix typo, reject bad flags.
>	(fchmodat, fchownat, fstatat, utimensat, linkat, unlinkat): Reject
>	bad flags.
>
>diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>index 3798587..6dee7d3 100644
>--- a/winsup/cygwin/syscalls.cc
>+++ b/winsup/cygwin/syscalls.cc
>@@ -3825,7 +3825,8 @@ faccessat (int dirfd, const char *pathname, int mode, int flags)
>   char *path = tp.c_get ();
>   if (!gen_full_path_at (path, dirfd, pathname))
>     {
>-      if (flags & ~(F_OK|R_OK|W_OK|X_OK))
>+      if ((mode & ~(F_OK|R_OK|W_OK|X_OK))
>+	  || (flags & ~(AT_SYMLINK_NOFOLLOW|AT_EACCESS)))

It's hard to tell from the patch.  Is this properly aligned?  The || should be under the
(mode.

With that minor comment please check in.

Thanks.

cgf
