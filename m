Return-Path: <cygwin-patches-return-2327-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3553 invoked by alias); 6 Jun 2002 01:19:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3495 invoked from network); 6 Jun 2002 01:19:27 -0000
Message-ID: <021101c20cf8$6b033430$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <00ef01c20cf1$08974c20$6132bc3e@BABEL> <20020606003415.GC15072@redhat.com>
Subject: Re: Patch for sub-second resolution in stat(2)
Date: Wed, 05 Jun 2002 18:19:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00310.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> >I'm unclear whether this is the best naming / type scheme but it is one
> >recognised by both the make and fileutils packages available from the
> >cygwin setup (i.e. make this patch and re-compile those packages and they
> > detect the new fields).
>
> As long as there's precedent...  Is this how linux does it too?

This does seem to be the way that several vendors do it: it's labelled "the
usual case" in the make and fileutils configure files (as opposed to Solaris
2.6 and Unixware 2.1.2) and I found several man pages on the web that
matched this naming / typing scheme.

Strangely, Linux doesn't seem to support sub-second timing (at least, not as
of 2.5.13, which is all I have to hand right now).


> newlib patches should be sent to the newlib mailing list.

On its way.

> I see from your next message that you're probably sending a better
> ChangeLog.  :-)

Well, it's longer :-) and I hope it's better.


While I'm writing, just a note that there is a proviso in the second
(slightly more considered) version of the email about an issue of rounding
up of the times for FAT that I also missed out from the first.

> I'll let Corinna comment on the patch itself.  It looks good to me, but
> she's been modifying this code a lot lately so she has a better feel for
> it.

Thanks Chris.

// Conrad


