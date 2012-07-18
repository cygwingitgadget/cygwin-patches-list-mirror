Return-Path: <cygwin-patches-return-7682-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10271 invoked by alias); 18 Jul 2012 11:18:10 -0000
Received: (qmail 9917 invoked by uid 22791); 18 Jul 2012 11:17:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 18 Jul 2012 11:17:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 43F422C0074; Wed, 18 Jul 2012 13:17:29 +0200 (CEST)
Date: Wed, 18 Jul 2012 11:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
Message-ID: <20120718111729.GI31055@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4FCD945D.8070209@users.sourceforge.net> <20120605124209.GB23381@calimero.vinschen.de> <4FCEC079.2090802@users.sourceforge.net> <20120606073305.GA18246@calimero.vinschen.de> <50068E29.6060302@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50068E29.6060302@users.sourceforge.net>
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
X-SW-Source: 2012-q3/txt/msg00003.txt.bz2

On Jul 18 05:21, Yaakov (Cygwin/X) wrote:
> Somehow this one fell through the cracks.  Picking up where we left off:
> 
> On 2012-06-06 02:33, Corinna Vinschen wrote:
> >On Jun  5 21:29, Yaakov (Cygwin/X) wrote:
> >>The string returned into buf is in the following format:
> >>
> >>mnt_fsname\0mnt_dir\0mnt_type\0mnt_opts\0mnt_freq" "mnt_passno\0
> >
> >Yes, but this is not something inherent to the functionality of
> >getmntent_r, it's just residue from the way getmntent_r works.  It reads
> >a line from /etc/fstab or /etc/mtab into the buffer via fgets:
> >
> >   mnt_fsname\tmnt_dir\tmnt_type\tmnt_opts\tmnt_freq\n
> >
> >and then creates the content of mntbuf from there, replacing the \t with
> >\0 as it goes along.  So it starts with mnt_opts and mnt_freq strings in
> >buf, but only to sscanf them into their respective mntbuf->mnt_opts and
> >mntbuf->mnt_freq members.
> 
> Since glibc is getting this information from the kernel, that makes sense.
> 
> >In case of Cygwin this is not needed since we don't read from the file
> >but from the internal datastructure.  There's no reason to create
> >garbage in buf just because this is by chance the layout the buffer gets
> >when operating under Linux.
> >
> >The *important* thing is that buf contains the strings the members of
> >mntbuf points to.
> 
> OK, revised patch attached.

Thanks.  Applied with a tweak:  It's really not necessary at all to
create strings for mnt_freq and mnt_passno in buf.  Just copy them
over from mnt to mntbuf and be done with it.

> >>glibc makes no attempt to verify buf or mntbuf; if either of them
> >>are not initialized or too small, you're in "undefined behaviour"
> >>territory (aka SEGV :-).
> >
> >You're basically right.  But it won't SEGV if buf is too small.
> 
> By "too small", I meant sizeof(buf) < buflen, or sizeof(mntbuf) <
> sizeof(struct mntent); then glibc definitely does SEGV.

That's right.  I meant the fact that buflen is just too small to keep
all strings.


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
