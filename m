Return-Path: <cygwin-patches-return-1532-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 4010 invoked by alias); 27 Nov 2001 22:13:36 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 3979 invoked from network); 27 Nov 2001 22:13:34 -0000
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream
	as a  header
From: Robert Collins <robert.collins@itdomain.com.au>
To: cygwin-patches@cygwin.com
In-Reply-To: <20011127184223.GA24028@redhat.com>
References: <3C035977.BF151D0A@syntrex.com>
	<000601c17772$7c5ecfd0$2101a8c0@d8rc020b> 
	<20011127184223.GA24028@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: Sun, 21 Oct 2001 16:20:00 -0000
Message-Id: <1006899141.2048.2.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 27 Nov 2001 22:13:33.0995 (UTC) FILETIME=[C0FDF7B0:01C17790]
X-SW-Source: 2001-q4/txt/msg00064.txt.bz2

On Wed, 2001-11-28 at 05:42, Christopher Faylor wrote:

> >Ah, better yet.  Jeez you guys are clever ;-).  But how about we make it:
> >
> >	while (((l = s->gets ()) != 0) && (*l != '\0'))
> >
> >in the interest of making it a bit more self-documenting?
> 
> Actually, how about not using != 0.  Use NULL in this context.
> 
> I don't think that *l is hard to understand, fwiw.

I think *l is ok. As for 0 vs NULL, in C++ NULL is deprecated, 0 is the
correct test for an invalid pointer.

Rob
