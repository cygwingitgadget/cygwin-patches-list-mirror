Return-Path: <cygwin-patches-return-6270-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25937 invoked by alias); 9 Mar 2008 13:04:15 -0000
Received: (qmail 25927 invoked by uid 22791); 9 Mar 2008 13:04:14 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 09 Mar 2008 13:03:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 9109F6D430A; Sun,  9 Mar 2008 14:03:42 +0100 (CET)
Date: Sun, 09 Mar 2008 13:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
Message-ID: <20080309130342.GA18407@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D3B079.C8BA614C@dessent.net> <20080309095109.GX18407@calimero.vinschen.de> <47D3BCAC.98C49164@dessent.net> <20080309103618.GZ18407@calimero.vinschen.de> <47D3D1CC.87E7D183@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47D3D1CC.87E7D183@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00044.txt.bz2

On Mar  9 05:02, Brian Dessent wrote:
> Corinna Vinschen wrote:
> 
> > Now that you mention it... did you see the comment in path.cc, line 3112ff?
> > There's a good chance that Windows shortcuts are not capable of long path
> > names.  I didn't test it so far, but it would be certainly better for
> > readlink to use the POSIX path in the symlink either way.
> 
> Check this out.  I modified cygcheck to have a command line option to
> dump out whatever readlink() returns.
> 
> $ cd /tmp
> $ echo "fileone" >fileone
> $ ln -s fileone linkone
> $ ln -s filetwo linktwo        # filetwo doesn't exist yet
> $ echo "filetwo" >filetwo
> $ cat linkone
> fileone
> $ cat linktwo
> filetwo
> $ ./cygcheck -x linkone linktwo
> linkone -> fileone
> linktwo -> c:\tmp\filetwo
> $ ls -l linkone linktwo
> lrwxrwxrwx 1 brian None 7 Mar  9 04:56 linkone -> fileone
> lrwxrwxrwx 1 brian None 7 Mar  9 04:56 linktwo -> filetwo
> 
> So, the fact that the link was dangling at the time it was created
> caused readlink to read it as a Win32 path -- which also causes it to
> now be an absolute target instead of a relative target.  Apparently this
> is due to the fact that if the target doesn't exist at creation time the
> ParseDisplayName thing fails which results in a different structure for
> the .lnk file, which confuses readlink()'s puny little brain which only
> knows how to look at a fixed offset in the file, which results in it
> reading a different slot.  Sigh.

Yuk.  I guess it would help a lot to reproduce path.cc:check_shortcut(*)
in utils as close as possible.  Afaics it doesn't use any code which
would be restricted to Cygwin, except for the call to
mount_table->conv_to_posix_path in the posixify method.


Corinna

(*) and, FWIW, symlink_info::check_reparse_point and
    symlink_info::check_sysfile.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
