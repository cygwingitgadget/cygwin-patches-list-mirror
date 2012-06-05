Return-Path: <cygwin-patches-return-7668-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13541 invoked by alias); 5 Jun 2012 12:52:52 -0000
Received: (qmail 13470 invoked by uid 22791); 5 Jun 2012 12:52:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 05 Jun 2012 12:52:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 260662C007D; Tue,  5 Jun 2012 14:52:07 +0200 (CEST)
Date: Tue, 05 Jun 2012 12:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
Message-ID: <20120605125207.GC23381@calimero.vinschen.de>
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
X-SW-Source: 2012-q2/txt/msg00037.txt.bz2

On Jun  5 14:42, Corinna Vinschen wrote:
> Hi Yaakov,
> 
> thanks for the patch, but this won't fly.
> 
> On Jun  5 00:08, Yaakov (Cygwin/X) wrote:
> > This patch set implements getmntent_r, a GNU extension:
> > 
> > http://man7.org/linux/man-pages/man3/getmntent.3.html
> > 
> > libvirt needs this[1], as I just (re)discovered.  Patches for
> > winsup/cygwin and winsup/doc attached.
> 
> > +extern "C" struct mntent *
> > +getmntent_r (FILE *, struct mntent *mntbuf, char *buf, int buflen)
> > +{
> > +  struct mntent *mnt = mount_table->getmntent (_my_tls.locals.iteration++);
> > +  char *tmpbuf;
> > +  int len = 0, maxlen;
> > +
> > +  if (!mnt)
> > +    {
> > +      mntbuf = NULL;
> 
> This doesn't make sense since mntbuf is a local varibale.  Changing
                                                     ^^
                                                  variable

> its value won't be propagated by the calling function anyway.
                                ^^
                                to

> [...]
> > +  memcpy (mntbuf, mnt, sizeof (struct mntent));
> 
> This doesn't do what you want.  mntbuf is just a copy of mnt, so the
> mntbuf members won't point to buf, but they will point to the internal
> storage.  While you have made a copy of the internal strings, they won't
> be used.  Also, assuming you first store the strings in tmpbuf and then
> memcpy them over to buf, 

... you have to make sure the mntbuf pointers point to buf, not to tmpbuf.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
