Return-Path: <cygwin-patches-return-4987-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3257 invoked by alias); 23 Sep 2004 10:47:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3221 invoked from network); 23 Sep 2004 10:47:23 -0000
Date: Thu, 23 Sep 2004 10:47:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: dannysmith@users.sourceforge.net, earnie@users.sourceforge.net
Cc: cygwin-patches@cygwin.com
Subject: Re: dinput.h and ddraw.h from Wine with trivial modifications (fwd)
Message-ID: <20040923104818.GB13736@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: dannysmith@users.sourceforge.net,
	earnie@users.sourceforge.net, cygwin-patches@cygwin.com
References: <90459864DAD67D43BDD3D517DEFC2F7D7154@axon.Axentia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90459864DAD67D43BDD3D517DEFC2F7D7154@axon.Axentia.local>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00139.txt.bz2

On Sep 22 15:58, Peter Ekberg wrote:
> Corinna wrote:
> > On Sep 17 13:39, Peter Ekberg wrote:
> >> Hello!
> >> 
> >> This is the ddraw.h and dinput.h files from Wine, with some trivial
> >> modification by me to make them work in the cygwin environment.
> >> 
> >> They are "Copyright (C) the Wine project" according to their headers
> >> and under the LGPL. I think it is polite to keep them under LGPL
> >> rather than converting to the GPL so that changes can flow freely
> >> between the two projects. [...]
> > 
> > Doesn't this collide with the public domain-ness of w32api?
> 
> Well, winsock.h, winsock2.h, ws2tcpip.h, gl.h, glext.h and glu.h
> are not public domain (according to README.w32api), so I figured
> that two more files was not a major collision. Not my decision
> though...

Probably Cygwin has no problems as long as these header files are never
included in Cygwin code itself.

Let's ask the MingW folks.  Danny, Earnie, any problem with a header
file being LGPL'ed?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
