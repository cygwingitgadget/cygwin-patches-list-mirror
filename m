Return-Path: <cygwin-patches-return-5382-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12261 invoked by alias); 26 Mar 2005 16:41:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12221 invoked from network); 26 Mar 2005 16:41:07 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 26 Mar 2005 16:41:07 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id CEC8C13C1F8; Sat, 26 Mar 2005 11:41:06 -0500 (EST)
Date: Sat, 26 Mar 2005 16:41:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: exceeding PATH_MAX
Message-ID: <20050326164106.GB11382@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4245843E.10700@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4245843E.10700@byu.net>
User-Agent: Mutt/1.5.6i
X-SW-Source: 2005-q1/txt/msg00085.txt.bz2

On Sat, Mar 26, 2005 at 08:48:14AM -0700, Eric Blake wrote:
>On NT systems, and using the Unicode versions of Windows syscalls, Windows
>supports up to 32k for pathnames, with component names up to 255 bytes, by
>using the \\?\ prefix.  Cygwin could actually support the XSI-recommended
>minimum PATH_MAX of 1024, rather than the POSIX-required minimum of 256,
>and support it on the Posix name rather than the Windows name as is
>currently done.  That would also let cygwin support relative pathnames
>whose absolute name is greater than PATH_MAX, up to the 32k limit of the
>absolute path name, as is done on many other systems.  The XSI-recommended
>NAME_MAX of 255 is a bit problematic - on managed mounts, it is possible
>for an 85-char POSIX name to occupy 255 Windows characters, but at least
>that is still greater than the POSIX recommended minimum NAME_MAX of 14.

I don't suppose you googled for this before you investigated?  I guess
eventually we'll have to get rid of this limitation just to stop people
from discovering it and announcing their new findings every couple of
months.

>One other comment - limits.h defines PATH_MAX as 259 (#define PATH_MAX
>(260 - 1 /*NUL*/)) instead of the Windows API MAX_PATH of 260.  But POSIX
>states that PATH_MAX includes the trailing NUL, so there is no reason for
>cygwin to short-change the length by a byte.

I don't think it is as clear cut as that.  Windows considers MAX_PATH to
be 260 but it isn't entirely clear that that value includes the NUL byte.
If Windows just silently truncates strings at 260 then that would mean
that the right value for PATH_MAX is 261.

>This patch fixes the smaller issues:
>
>2005-03-26  Eric Blake  <ebb9@byu.net>
>
>	* errno.cc (FILENAME_EXCED_RANGE): Map to ENAMETOOLONG.
>	* include/limits.h (NAME_MAX): New define.
>	(PATH_MAX): POSIX allows PATH_MAX to include trailing NUL.

This is apparently fixing the symptom rather than the problem.  Cygwin
is supposed to be detecting if the name is too long before it gets to
the windows api.

cgf
