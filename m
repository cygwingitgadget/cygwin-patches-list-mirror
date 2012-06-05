Return-Path: <cygwin-patches-return-7669-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18305 invoked by alias); 5 Jun 2012 14:40:40 -0000
Received: (qmail 16185 invoked by uid 22791); 5 Jun 2012 14:40:00 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 05 Jun 2012 14:39:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E2AFA2C007D; Tue,  5 Jun 2012 16:39:43 +0200 (CEST)
Date: Tue, 05 Jun 2012 14:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
Message-ID: <20120605143943.GG23381@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4FCD945D.8070209@users.sourceforge.net> <20120605124209.GB23381@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20120605124209.GB23381@calimero.vinschen.de>
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
X-SW-Source: 2012-q2/txt/msg00038.txt.bz2

And I missed a line in my dirty code example:

On Jun  5 14:42, Corinna Vinschen wrote:
>   What you want is more like this (untested):
> 
>   struct mntent *mnt = mount_table->getmntent (_my_tls.locals.iteration++);
>   if (!mnt)
>     return NULL;
>    int maxlen = strlen (mnt->mnt_fsname) + strlen (mnt->mnt_dir)
> 		+ strlen (mnt->mnt_type) + strlen (mnt->mnt_opts) + 4;
>    if (maxlen > buflen)
>      return NULL;
>    mntbuf->mnt_dir = stpcpy (mntbuf->mnt_fsname = buf, mnt->mnt_fsname);
>    mntbuf->mnt_type = stpcpy (mntbuf->mnt_dir, mnt->mnt_dir);
>    mntbuf->mnt_opts = stpcpy (mntbuf->mnt_type, mnt->mnt_type);

     stpcpy (mntbuf->mnt_opts, mnt->mnt_opts);

>    mntbuf->mnt_freq = mnt->mnt_freq;
>    mntbuf->mnt_passno = mnt->mnt_passno;
>    memcpy (buf, tmpbuf, buflen);
>    return mntbuf;


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
