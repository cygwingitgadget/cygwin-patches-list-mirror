Return-Path: <cygwin-patches-return-2026-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7271 invoked by alias); 4 Apr 2002 05:51:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7233 invoked from network); 4 Apr 2002 05:51:21 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Setup Chooser integration
Date: Wed, 03 Apr 2002 21:51:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKCELCCMAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20020403143152.GF4053@redhat.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00010.txt.bz2

> >>Likewise, if you click ash off, up pops a window listing everything
> >>that depends on ash, with an addiotnal message of "Warning: removing
> >>ash will cause these packages to be removed as well.
> >>
> >
> >This does make quite a bit of sense to me.  But wouldn't MessageBox()
> >or something akin to it be a better fit to the task?  The only possible
> >user input here would be "Yes, remove ash and everything dependent on
> >it" and "Cancel", and the only output a list of package names.
>
> Actually, I think that automatically removing dependencies is not a good
> idea.  If I select binutils specifically, then select gcc, then uninstall
> gcc, I would probably be annoyed to see binutils disappear.
>
> cgf

I took it to mean the opposite - if you uninstalled *binutils*, it would
uninstall gcc because gcc depends on them.  But on further reflection I'm no
longer sure even that is desirable.  If I uninstall ash, should say make get
deleted even though I have bash as sh?

--
Gary R. Van Sickle
Brewer.  Patriot.
