Return-Path: <cygwin-patches-return-5351-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31807 invoked by alias); 11 Feb 2005 14:20:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31203 invoked from network); 11 Feb 2005 14:20:30 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.110.141)
  by sourceware.org with SMTP; 11 Feb 2005 14:20:30 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id A758857D77; Fri, 11 Feb 2005 15:20:28 +0100 (CET)
Date: Fri, 11 Feb 2005 14:20:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Message-ID: <20050211142028.GD2597@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050208091029.GM19096@cygbert.vinschen.de> <0IBM0096T43FSM@pmismtp01.mcilink.com> <20050209085228.GF2597@cygbert.vinschen.de> <loom.20050210T160326-68@post.gmane.org> <20050210155633.GB2597@cygbert.vinschen.de> <loom.20050211T000509-58@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050211T000509-58@post.gmane.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00054.txt.bz2

On Feb 10 23:43, Eric Blake wrote:
> Corinna Vinschen <vinschen <at> redhat.com> writes:
> > Anyway, can you please test on both drives how they behave if utime
> > uses FILE_WRITE_ATTRIBUTES vs. GENERIC_WRITE?
> 
> Well, that was my first time ever building cygwin1.dll, but it went smoothly.  
> As requested, I tested utimes() when opening with just FILE_WRITE_ATTRIBUTES 
> and with full-blown GENERIC_WRITE, on both the ClearCase and the NFS mounted 
> drives.  In all four cases, touch(1), which boils down to utimes(2), was able 
> to modify all three file times for a file, but returned success without budging 
> any of the times on a directory.

That could be a result of the Cygwin internals.  I assume that the
CreateFile call requesting any write access fails on both filesystems.
If you have a look into utimes, you see that Cygwin ignores this case:

  h = CreateFile()
  if ((h == INVALID_HANDLE_VALUE)
    if (win32.isdir ())
      {
        /* What we can do with directories more? */
	res = 0;
      }
    [...]

Can you add a __seterrno () before the `res = 0;' line and see what
Win32 error is produced by CreateFile (*iff* my assumption is correct)?

> > The expected result would be that the clearcase volume chokes with
> > FILE_WRITE_ATTRIBUTES while the Solaris FS should work with it.
> > Otherwise we're sort of doomed.
> 
> Then we're doomed (but was that ever a surprise from Windows? :)

I guess trying my approach isn't the worst one, though.  We should
use that as a start point for further experimenting, IMHO.  I'll check
that in.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
