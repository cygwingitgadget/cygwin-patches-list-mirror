Return-Path: <cygwin-patches-return-7674-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23792 invoked by alias); 6 Jun 2012 07:33:49 -0000
Received: (qmail 23746 invoked by uid 22791); 6 Jun 2012 07:33:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 06 Jun 2012 07:33:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B34C42C007D; Wed,  6 Jun 2012 09:33:05 +0200 (CEST)
Date: Wed, 06 Jun 2012 07:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add getmntent_r
Message-ID: <20120606073305.GA18246@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4FCD945D.8070209@users.sourceforge.net> <20120605124209.GB23381@calimero.vinschen.de> <4FCEC079.2090802@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4FCEC079.2090802@users.sourceforge.net>
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
X-SW-Source: 2012-q2/txt/msg00043.txt.bz2

On Jun  5 21:29, Yaakov (Cygwin/X) wrote:
> On 2012-06-05 07:42, Corinna Vinschen wrote:
> >>+extern "C" struct mntent *
> >>+getmntent_r (FILE *, struct mntent *mntbuf, char *buf, int buflen)
> >>+{
> >>+  struct mntent *mnt = mount_table->getmntent (_my_tls.locals.iteration++);
> >>+  char *tmpbuf;
> >>+  int len = 0, maxlen;
> >>+
> >>+  if (!mnt)
> >>+    {
> >>+      mntbuf = NULL;
> >
> >This doesn't make sense since mntbuf is a local varibale.  Changing
> >its value won't be propagated by the calling function anyway.
> 
> Further testing of glibc shows that buf and mntbuf are indeed left
> untouched when returning NULL.

Erm... I'm not talking about glibc vs. your code.  Mntbuf is a simple
call-by-value variable.  Changes to this variable in the called function
are *never* propagated back to the parent function.

> >>+  maxlen = strlen (mnt->mnt_fsname) + strlen (mnt->mnt_dir)
> >>+           + strlen (mnt->mnt_type) + strlen (mnt->mnt_opts) + 30;
> >>+  tmpbuf = (char *) alloca (maxlen);
> >>+  memset (tmpbuf, '\0', maxlen);
> >>+
> >>+  len += __small_sprintf (tmpbuf, "%s", mnt->mnt_fsname) + 1;
> >>+  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_dir) + 1;
> >>+  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_type) + 1;
> >>+  len += __small_sprintf (tmpbuf + len, "%s", mnt->mnt_opts) + 1;
> >
> >This you can have simpler.
> >
> >>+  len += __small_sprintf (tmpbuf + len, "%d %d", mnt->mnt_freq, mnt->mnt_passno);
> >
> >and this I don't grok at all.  Why don't you just copy over the
> >numbers from mnt to mntbuf?
> 
> The string returned into buf is in the following format:
> 
> mnt_fsname\0mnt_dir\0mnt_type\0mnt_opts\0mnt_freq" "mnt_passno\0

Yes, but this is not something inherent to the functionality of
getmntent_r, it's just residue from the way getmntent_r works.  It reads
a line from /etc/fstab or /etc/mtab into the buffer via fgets:

  mnt_fsname\tmnt_dir\tmnt_type\tmnt_opts\tmnt_freq\n

and then creates the content of mntbuf from there, replacing the \t with
\0 as it goes along.  So it starts with mnt_opts and mnt_freq strings in
buf, but only to sscanf them into their respective mntbuf->mnt_opts and
mntbuf->mnt_freq members.

In case of Cygwin this is not needed since we don't read from the file
but from the internal datastructure.  There's no reason to create
garbage in buf just because this is by chance the layout the buffer gets
when operating under Linux.

The *important* thing is that buf contains the strings the members of
mntbuf points to.  And that's where your code fails, including the
revised version.

Here you copy the strings over from tmpbuf to buf:

  memcpy (buf, tmpbuf, buflen);

And here you copy over mnt to mntbuf:

  memcpy (mntbuf, mnt, sizeof (struct mntent));

So where do the pointers in mntbuf point to now?  Do they point into
buf as they should, or do they point into Cygwin's internal mntent
entry?  Change your testcase code like this:

  /* check that these are identical with the above */
  [...]
  /* check they really point into buf */
  if (mntent.mnt_fsname < buf || mntent.mnt_fsname >= buf + buflen)
    fprintf (stderr, "mntent.mnt_fsname does not point into buf!\n");
  [...analog for mnt_dir, mnt_type, mnt_opts...]

> glibc makes no attempt to verify buf or mntbuf; if either of them
> are not initialized or too small, you're in "undefined behaviour"
> territory (aka SEGV :-).

You're basically right.  But it won't SEGV if buf is too small.  Glibc
handles a small buffer gracefully.  It will set all members in mntbuf
which are not backed by space in buf to an empty string, and it sets
mnt_opts and/or mnt_freq to 0 if their string representation didn't fit
into buf when reading from the file.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
