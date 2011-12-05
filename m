Return-Path: <cygwin-patches-return-7553-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16635 invoked by alias); 5 Dec 2011 10:17:55 -0000
Received: (qmail 16559 invoked by uid 22791); 5 Dec 2011 10:17:31 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 05 Dec 2011 10:17:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A66242C01DE; Mon,  5 Dec 2011 11:17:15 +0100 (CET)
Date: Mon, 05 Dec 2011 10:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add support for creating native windows symlinks
Message-ID: <20111205101715.GA13067@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00043.txt.bz2

On Dec  3 23:07, Russell Davis wrote:
> This was discussed before here:
> http://cygwin.com/ml/cygwin/2008-03/msg00277.html

See also http://sourceware.org/ml/cygwin/2009-10/msg00756.html

> These were the reasons given for not using native symlinks to create
> cygwin symlinks, along with my responses:
> 
> - By default, only administrators have the right to create native
> Â  symlinks.Â  Admins running with restricted permissions under UAC don't
> Â  have this right.
> 
> This is true, however the feature can be made optional through the
> CYGWIN environment variable (just like winsymlinks). For users that
> can add the permission or disable UAC, the use of native symlinks is a
> huge step towards making cygwin more unified with the rest of Windows.
> 
> - When creating a native symlink, you have to define if this symlink
> Â  points to a file or a directory.Â  This makes no sense given that
> Â  symlinks often are created before the target they point to.
> 
> Also true. However, the type only matters for Windows' usage of the
> symlink -- cygwin already treats both the types the same. For example,
> if a native symlink of type `file` actually points to a directory, it
> will still work fine inside cygwin. It won't work for Win32 programs
> that try to access it, but that's still no worse than the status quo
> -- Win32 programs already can't use cygwin symlinks.
> 
> Since cygwin already supports reading of native symlinks, I was able
> to add support for this with a fairly small change. Some edge cases
> probably still need to be handled (disabling for older versions of
> windows and unsupported file systems), but I wanted to get this out
> there for review. The patch is attached.

I'm not at all convinced that it makes sense to add support to create
native symlinks to Cygwin.  Since Vista was in beta stage I'm
experimenting on and off with them, since every few months I had such a
great idea how to implement POSIX symlinks using them, but in the end it
was all futile since Windows is so uncooperative.  And I didn't restrict
my experiments to using the CreateSymbolicLink function.  I still have
my test binary which wrote the symlinks directly, using the
FSCTL_SET_REPARSE_POINT ioctl call.  The restrictions of these native
symlinks are rather disappointing and disqualify them for a POSIX
environment(*).

There's also a problem with your patch.  It uses the CreateSymbolicLinkA
function.  Given that the multibyte win32 path in path_conv is given in
the current Cygwin multibyte charset, you can't do that.  Rather you
would have to use the wide char path returned by get_wide_win32_path.
And then it doesn't make sense to call CreateSymbolicLinkW since we
already have the native path handy and could call NtFsControlFile with
the FSCTL_SET_REPARSE_POINT ioctl directly.

Last but not least, we can't include non-trivial patches from you,
unless you sign the copyright assignment form.  See
http://cygwin.com/contrib.html, the "Before you get started" section.
An awkward but necessary requirement.


Corinna


(*) As a side note, I'm really puzzled about that.  They could have
    been such a nice addition to create sylinks in SUA, but the way
    they have been implemented even disqualifies them for usage in SUA.
    That's probably the reason SUA still creates its own symlink style
    to date.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
