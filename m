Return-Path: <cygwin-patches-return-7670-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17738 invoked by alias); 5 Jun 2012 14:54:42 -0000
Received: (qmail 17698 invoked by uid 22791); 5 Jun 2012 14:54:18 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 05 Jun 2012 14:54:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D89E82C007D; Tue,  5 Jun 2012 16:54:02 +0200 (CEST)
Date: Tue, 05 Jun 2012 14:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
Message-ID: <20120605145402.GI23381@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4FCD945D.8070209@users.sourceforge.net> <20120605124209.GB23381@calimero.vinschen.de> <20120605143943.GG23381@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20120605143943.GG23381@calimero.vinschen.de>
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
X-SW-Source: 2012-q2/txt/msg00039.txt.bz2

On Jun  5 16:39, Corinna Vinschen wrote:
> And I missed a line in my dirty code example:

And I missed to add a + 1 to the pointers returned from stpcpy.  Sigh.
Let's restart:

  struct mntent *mnt = mount_table->getmntent (_my_tls.locals.iteration++);
  if (!mnt)
    return NULL;
  int maxlen = strlen (mnt->mnt_fsname) + strlen (mnt->mnt_dir)
               + strlen (mnt->mnt_type) + strlen (mnt->mnt_opts) + 4;
  if (maxlen > buflen)
    return NULL;
  mntbuf->mnt_fsname = buf;
  mntbuf->mnt_dir = stpcpy (mntbuf->mnt_fsname, mnt->mnt_fsname) + 1;
  mntbuf->mnt_type = stpcpy (mntbuf->mnt_dir, mnt->mnt_dir) + 1;
  mntbuf->mnt_opts = stpcpy (mntbuf->mnt_type, mnt->mnt_type) + 1;
  stpcpy (mntbuf->mnt_opts, mnt->mnt_opts);
  mntbuf->mnt_freq = mnt->mnt_freq;
  mntbuf->mnt_passno = mnt->mnt_passno;
  memcpy (buf, tmpbuf, buflen);
  return mntbuf;

Sorry about that.  Hopefully you get the idea, regardless.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
