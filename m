Return-Path: <cygwin-patches-return-4258-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3994 invoked by alias); 27 Sep 2003 03:03:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3985 invoked from network); 27 Sep 2003 03:03:13 -0000
Date: Sat, 27 Sep 2003 03:03:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Turning pinfo security on
Message-ID: <20030927030308.GA17960@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030926221700.008209b0@incoming.verizon.net> <3.0.5.32.20030926221700.008209b0@incoming.verizon.net> <3.0.5.32.20030926223605.00822510@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030926223605.00822510@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00274.txt.bz2

On Fri, Sep 26, 2003 at 10:36:05PM -0400, Pierre A. Humblet wrote:
>BTW, now that your sigpacket includes the sending pid, the commune stuff
>could be simplified and avoid calling winpids. It knows whom to talk
>to (but it must still double check for security).

Yeah.  That's one of the reasons I added it.

>Another benefit of your method!

It makes me wonder why I waited three or four years to do it this way.
I guess, with my infallible intuition, I always thought it would slow
things down.

cgf
