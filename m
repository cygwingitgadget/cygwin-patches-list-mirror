Return-Path: <cygwin-patches-return-7667-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9329 invoked by alias); 5 Jun 2012 12:42:51 -0000
Received: (qmail 9224 invoked by uid 22791); 5 Jun 2012 12:42:28 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 05 Jun 2012 12:42:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EB9092C007D; Tue,  5 Jun 2012 14:42:09 +0200 (CEST)
Date: Tue, 05 Jun 2012 12:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
Message-ID: <20120605124209.GB23381@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4FCD945D.8070209@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4FCD945D.8070209@users.sourceforge.net>
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
X-SW-Source: 2012-q2/txt/msg00036.txt.bz2

Hi Yaakov,

thanks for the patch, but this won't fly.

On Jun  5 00:08, Yaakov (Cygwin/X) wrote:
> This patch set implements getmntent_r, a GNU extension:
> 
> http://man7.org/linux/man-pages/man3/getmntent.3.html
> 
> libvirt needs this[1], as I just (re)discovered.  Patches for
> winsup/cygwin and winsup/doc attached.

> +extern "C" struct mntent *
> +getmntent_r (FILE *, struct mntent *mntbuf, char *buf, int buflen)
> +{
> +  struct mntent *mnt = mount_table->getmntent (_my_tls.locals.iteration++);
> +  char *tmpbuf;
> +  int len = 0, maxlen;
> +
> +  if (!mnt)
> +    {
> +      mntbuf = NULL;

This doesn't make sense since mntbuf is a local varibale.  Changing
its value won't be propagated by the calling function anyway.

> +      return NULL;
> +    }
> +
> +  maxlen = strlen (mnt->mnt_fsname) + strlen (mnt->mnt_dir)
> +           + strlen (mnt->mnt_type) + strlen (mnt->mnt_opts) + 30;
> +  tmpbuf = (char *) alloca (maxlen);
> +  memset (tmpbuf, '\0', maxlen);
> +
> +  len += __small_sprintf (tmpbuf, "%s", mnt->mnt_fsname) + 1;
> +  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_dir) + 1;
> +  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_type) + 1;
> +  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_opts) + 1;

This you can have simpler.

> +  len += __small_sprintf (tmpbuf + len, "%d %d", mnt->mnt_freq, mnt->mnt_passno);

and this I don't grok at all.  Why don't you just copy over the
numbers from mnt to mntbuf?

> +
> +  memcpy (buf, tmpbuf, buflen);

So the function returns success even if the incoming buffer space
is insufficient?

> +  memcpy (mntbuf, mnt, sizeof (struct mntent));

This doesn't do what you want.  mntbuf is just a copy of mnt, so the
mntbuf members won't point to buf, but they will point to the internal
storage.  While you have made a copy of the internal strings, they won't
be used.  Also, assuming you first store the strings in tmpbuf and then
memcpy them over to buf, 

> +  return mnt;

And this returns the internal mntent entry anyway, so even mntbuf is
kind of moot.  What you want is more like this (untested):

  struct mntent *mnt = mount_table->getmntent (_my_tls.locals.iteration++);
  if (!mnt)
    return NULL;
   int maxlen = strlen (mnt->mnt_fsname) + strlen (mnt->mnt_dir)
		+ strlen (mnt->mnt_type) + strlen (mnt->mnt_opts) + 4;
   if (maxlen > buflen)
     return NULL;
   mntbuf->mnt_dir = stpcpy (mntbuf->mnt_fsname = buf, mnt->mnt_fsname);
   mntbuf->mnt_type = stpcpy (mntbuf->mnt_dir, mnt->mnt_dir);
   mntbuf->mnt_opts = stpcpy (mntbuf->mnt_type, mnt->mnt_type);
   mntbuf->mnt_freq = mnt->mnt_freq;
   mntbuf->mnt_passno = mnt->mnt_passno;
   memcpy (buf, tmpbuf, buflen);
   return mntbuf;


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
