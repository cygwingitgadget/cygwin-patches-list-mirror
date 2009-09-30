Return-Path: <cygwin-patches-return-6664-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18141 invoked by alias); 30 Sep 2009 15:35:09 -0000
Received: (qmail 18123 invoked by uid 22791); 30 Sep 2009 15:35:07 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 15:35:01 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 4C4FC13C002 	for <cygwin-patches@cygwin.com>; Wed, 30 Sep 2009 11:34:51 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 48DA72B352; Wed, 30 Sep 2009 11:34:51 -0400 (EDT)
Date: Wed, 30 Sep 2009 15:35:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: detect . in a/.//
Message-ID: <20090930153451.GA12182@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC34A01.4070509@byu.net>  <20090930152438.GA11977@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090930152438.GA11977@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00118.txt.bz2

On Wed, Sep 30, 2009 at 11:24:38AM -0400, Christopher Faylor wrote:
>On Wed, Sep 30, 2009 at 06:07:29AM -0600, Eric Blake wrote:
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>My testing on rename found another corner case: we rejected
>>rename("dir","a/./") but accepted rename("dir","a/.//").  OK to commit?
>>
>>For reference, the test I am writing for hammering rename() and renameat()
>>corner cases is currently visible here; it will be part of the next
>>coreutils release, among other places.  It currently stands at 400+ lines,
>>and exposes bugs in NetBSD, Solaris 10, mingw, and cygwin 1.5, but passes
>>on cygwin 1.7 (after this patch) and on Linux:
>>http://repo.or.cz/w/gnulib/ericb.git?a=blob;f=tests/test-rename.h
>>
>>2009-09-30  Eric Blake  <ebb9@byu.net>
>>
>>	* path.cc (has_dot_last_component): Detect "a/.//".
>
>No, I don't think so.  I don't think this function is right.  It
>shouldn't be doing a strrchr(dir, '//).  And the formatting is off
>slightly.
>
>Is this function supposed to detect just "." or "*/."?

Assuming the answer is yes, then how about the below?  I added a bunch of
comments but the function is still fairly small.

I've attached the function as-is since I basically rewrote it.

cgf

bool
has_dot_last_component (const char *dir, bool test_dot_dot)
{
  /* SUSv3: . and .. are not allowed as last components in various system
     calls.  Don't test for backslash path separator since that's a Win32
     path following Win32 rules. */
  const char *last_comp = strrchr (dir, '\0');

  if (last_comp == dir)
    return false;       /* Empty string.  Probably shouldn't happen here? */

  /* Detect run of trailing slashes */
  while (last_comp > dir && *--last_comp == '/')
    continue;

  /* Detect just a run of slashes or a path that does not end with a slash. */
  if (*last_comp != '.')
    return false;

  /* We know we have a trailing dot here.  Check that it really is a standalone "."
     path component by checking that it is at the beginning of the string or is
     preceded by a "/" */
  if (last_comp == dir || *--last_comp == '/')
    return true;

  /* If we're not checking for '..' we're done.  Ditto if we're now pointing to
     a non-dot. */
  if (!test_dot_dot || *last_comp != '.')
    return false;               /* either not testing for .. or this was not '..' */

  /* Repeat previous test for standalone or path component. */
  return last_comp == dir || last_comp[-1] == '/';
}
