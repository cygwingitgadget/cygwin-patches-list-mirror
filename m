Return-Path: <cygwin-patches-return-2272-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4441 invoked by alias); 30 May 2002 11:41:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4409 invoked from network); 30 May 2002 11:41:43 -0000
Date: Thu, 30 May 2002 04:41:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Cleanup of ntdll.h
Message-ID: <20020530134141.E30892@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020530102327.Z30892@cygbert.vinschen.de> <00ef01c207c9$93cc35d0$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ef01c207c9$93cc35d0$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00255.txt.bz2

On Thu, May 30, 2002 at 09:03:06PM +1000, Robert Collins wrote:
> It was my understandinf that the NtXXX calls cannot be used from user
> mode. 

That's a misunderstanding.  They are intentionally identical in user mode.

> We should be using the Zw calls.

...because...???

Anyway, they *are* identical from the Cygwin DLL point of view.  The
calls are the same.  They don't point to different entry points in user
mode.  So it's just a point of taste how to call these functions.

The following is my taste:

IMHO, we should use the Nt calls.  When I first introduced usage of
native NT calls I called them NtXXX since that the name of the function
is sort of self explaining.  IMHO.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
