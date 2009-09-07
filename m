Return-Path: <cygwin-patches-return-6615-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11533 invoked by alias); 7 Sep 2009 20:05:58 -0000
Received: (qmail 11519 invoked by uid 22791); 7 Sep 2009 20:05:57 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-54-238.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.54.238)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 07 Sep 2009 20:05:48 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 20F8713C0C4 	for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2009 16:05:39 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 14ED52B35F; Mon,  7 Sep 2009 16:05:39 -0400 (EDT)
Date: Mon, 07 Sep 2009 20:05:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
Message-ID: <20090907200539.GA4489@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20090903T175736-252@post.gmane.org>  <4AA01449.6060707@byu.net>  <20090903191856.GB3998@ednor.casa.cgf.cx>  <20090903210438.GA25677@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090903210438.GA25677@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00069.txt.bz2

On Thu, Sep 03, 2009 at 11:04:38PM +0200, Corinna Vinschen wrote:
>On Sep  3 15:18, Christopher Faylor wrote:
>> On Thu, Sep 03, 2009 at 01:08:57PM -0600, Eric Blake wrote:
>> >-----BEGIN PGP SIGNED MESSAGE-----
>> >Hash: SHA1
>> >
>> >According to Eric Blake on 9/3/2009 9:58 AM:
>> >> faccessat has at least two, and probably three bugs.
>> >
>> >Here's a fix for 1 (typo) and 3 (check for EINVAL in more places), but not
>> >for 2 (euidaccess, and the followup request of lchmod).
>> >
>> >2009-09-03  Eric Blake  <ebb9@byu.net>
>> >
>> >	* syscalls.cc (faccessat): Fix typo, reject bad flags.
>> >	(fchmodat, fchownat, fstatat, utimensat, linkat, unlinkat): Reject
>> >	bad flags.
>> >
>> >diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>> >index 3798587..6dee7d3 100644
>> >--- a/winsup/cygwin/syscalls.cc
>> >+++ b/winsup/cygwin/syscalls.cc
>> >@@ -3825,7 +3825,8 @@ faccessat (int dirfd, const char *pathname, int mode, int flags)
>> >   char *path = tp.c_get ();
>> >   if (!gen_full_path_at (path, dirfd, pathname))
>> >     {
>> >-      if (flags & ~(F_OK|R_OK|W_OK|X_OK))
>> >+      if ((mode & ~(F_OK|R_OK|W_OK|X_OK))
>> >+	  || (flags & ~(AT_SYMLINK_NOFOLLOW|AT_EACCESS)))
>> 
>> It's hard to tell from the patch.  Is this properly aligned?  The || should be under the
>> (mode.
>> 
>> With that minor comment please check in.
>
>Thanks for the patches Eric, but, here's a problem.  We still have no
>copyright assignment in place from you.  The fcntl patch is barely
>trivial, but the faccessat patch certainly isn't anymore.  Would it
>be a big problem for you to send the filled out copyright assignemnt form
>from http://cygwin.com/assign.txt to Red Hat ASAP?  With any luck it
>will have arrived and will be signed before I'm back from vacation.

I don't understand why this isn't considered trivial but a basically
equivalent change to fix other errnos is:

http://cygwin.com/ml/cygwin/2009-09/msg00178.html

The criteria that I have used is 1) how many lines is it and 2) would
there be multiple ways to do the same thing, i.e., how "creative" is
the patch.  If there are not too many lines and there is really only
one way to do it, then it seems like it should be considered trivial.

cgf
