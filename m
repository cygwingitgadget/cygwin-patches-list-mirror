Return-Path: <cygwin-patches-return-6477-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19987 invoked by alias); 4 Apr 2009 09:45:14 -0000
Received: (qmail 19976 invoked by uid 22791); 4 Apr 2009 09:45:13 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 09:45:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 181486D554E; Sat,  4 Apr 2009 11:44:51 +0200 (CEST)
Date: Sat, 04 Apr 2009 09:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add uchar.h
Message-ID: <20090404094450.GA7844@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D60CC2.8090205@gmail.com> <20090403143528.GA468@calimero.vinschen.de> <49D69271.7040805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D69271.7040805@gmail.com>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00019.txt.bz2

On Apr  3 23:49, Dave Korn wrote:
> Corinna Vinschen wrote:
> > On Apr  3 14:18, Dave Korn wrote:
> >> Dave Korn wrote:
> >>>  I've got a bit of a load on right now what with gcc back in stage1.
> >>   However, as part of dealing with that I did try throwing together one of
> >> these.  I wrote this from scratch based solely on reading n1040; it's
> >> skeletal, but at least provides the two new unicode typedefs.  Want it?
> > 
> > Care to explain?
> > 
> > - What's n1040?
> 
>   An extension to the language standard specified by the ISO/IEC
> JTC1/SC22/WG14 working group for the C language and targeted for the
> forthcoming C1X update.
> 
> http://www.open-std.org/jtc1/sc22/WG14/
> 
> and specifically
> 
> http://www.open-std.org/jtc1/sc22/WG14/www/projects#19769
> 
> TR 19769: New character types in C
> 
> WG14 is working on a TR on new character types, including support for UTF-16.
> The title is: TR 19769 - Extensions for the programming language C to support
> new character data types. The latest draft, approved for publication, is in
> document N1040.

Thank you, I read it now.  Apart from thinking that it's a tad bit early
to introduce this header, I also think this would better fit into
newlib.  Btw, the functionality is quite easy to hack.  If this actually
becomes a standard, we can very quickly introduce the header *and* the
implementation.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
