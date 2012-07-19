Return-Path: <cygwin-patches-return-7684-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15249 invoked by alias); 19 Jul 2012 08:50:40 -0000
Received: (qmail 15204 invoked by uid 22791); 19 Jul 2012 08:50:21 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 19 Jul 2012 08:50:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DCF5F2C0074; Thu, 19 Jul 2012 10:50:04 +0200 (CEST)
Date: Thu, 19 Jul 2012 08:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
Message-ID: <20120719085004.GZ31055@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4FCD945D.8070209@users.sourceforge.net> <20120605124209.GB23381@calimero.vinschen.de> <4FCEC079.2090802@users.sourceforge.net> <20120606073305.GA18246@calimero.vinschen.de> <50068E29.6060302@users.sourceforge.net> <20120718111729.GI31055@calimero.vinschen.de> <50071B5D.3070600@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50071B5D.3070600@users.sourceforge.net>
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
X-SW-Source: 2012-q3/txt/msg00005.txt.bz2

On Jul 18 15:23, Yaakov (Cygwin/X) wrote:
> On 2012-07-18 06:17, Corinna Vinschen wrote:
> >On Jul 18 05:21, Yaakov (Cygwin/X) wrote:
> >>On 2012-06-06 02:33, Corinna Vinschen wrote:
> >>>In case of Cygwin this is not needed since we don't read from the file
> >>>but from the internal datastructure.  There's no reason to create
> >>>garbage in buf just because this is by chance the layout the buffer gets
> >>>when operating under Linux.
> >>>
> >>>The *important* thing is that buf contains the strings the members of
> >>>mntbuf points to.
> >>
> >>OK, revised patch attached.
> >
> >Thanks.  Applied with a tweak:  It's really not necessary at all to
> >create strings for mnt_freq and mnt_passno in buf.  Just copy them
> >over from mnt to mntbuf and be done with it.
> 
> In that case, we don't need opts_len, and AFAICS it will introduce a
> warning with GCC 4.6 [-Wunused-but-set-variable].  OK to remove?

Sure!


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
