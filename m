Return-Path: <cygwin-patches-return-2059-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7778 invoked by alias); 15 Apr 2002 15:01:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7739 invoked from network); 15 Apr 2002 15:01:22 -0000
Date: Mon, 15 Apr 2002 08:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
Message-ID: <20020415150129.GA6372@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com> <20020415141743.N29277@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020415141743.N29277@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00043.txt.bz2

On Mon, Apr 15, 2002 at 02:17:43PM +0200, Corinna Vinschen wrote:
>Your patch looks good.  What I didn't quite get is, how the above
>code now looks like (ideally) when using the new FD_SETCF functionality.
>Could you write a short example?  If inetd (what about sshd?) could
>benefit, I'd like to see how to do it.  Btw., the sources are in the
>inetutils-1.3.2-17-src.tar.bz2 file, obviously, which you can get
>by using setup.exe.

It looks like the patch will do the job but I would like to be convinced
that there is no other way around this problem.  If I'm reading this
correctly, this change requires modifying any code which uses cygwin.
That's something we should try to avoid at all costs.

cgf
