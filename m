Return-Path: <cygwin-patches-return-2971-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5887 invoked by alias); 16 Sep 2002 03:29:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5871 invoked from network); 16 Sep 2002 03:29:17 -0000
Message-Id: <3.0.5.32.20020915232518.00816590@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 15 Sep 2002 20:29:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: initgroups
In-Reply-To: <3D81F339.6766E6CD@ieee.org>
References: <3D7F4284.46484222@ieee.org>
 <3.0.5.32.20020910213124.0080e5a0@mail.attbi.com>
 <20020911123808.Q1574@cygbert.vinschen.de>
 <3D7F4284.46484222@ieee.org>
 <3.0.5.32.20020911204241.00810100@mail.attbi.com>
 <20020913104233.C1574@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00419.txt.bz2


Corinna Vinschen wrote:
> > If we decide on 1) shouldn't we remove calls to {ug}id16to(ug}id32 from
> > passwd.cc, grp.cc and syscalls.cc, EXCEPT in the various cases of chown
> > (i.e. simply do as getgrgid (), which doesn't call gid16togid32)?
> > Also, we shouldn't rely on ILLEGAL_UID in dcrt0.
> > If we decide on 2), shouldn't we enforce it everywhere? One possibility is
> > not to read in passwd and group entries with "illegal" {ug}id values.
> 
> After looking into this I think 2) is the way to go.  We can't support
> that uid/gid for apparent reasons so we should take the approach to
> invalidate it everywhere, yes.
> 
> However, that would mean that we have to treat both values as
> illegal, ILLEGAL_[UG]ID and ILLEGAL_[UG]ID16.  This looks a little
> bit weird to me...
>
Corinna, after sleeping over it I now think that the interaction between 16
and 32 bit ids you point out makes solution 2 (as described in my previous e-mail)
counterproductive, potentially generating more confusion. Posix doesn't make -1
an illegal {UG}ID. If a user decides to create {ug}id to FFFF or FFFFFFFF (or has
such a RID that we get in emulated passwd/group files), we can handle them as best
we can, supporting them for everything except possibly chown. 
Thus I am now leaning to a solution 1...

Pierre 
