Return-Path: <cygwin-patches-return-4328-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20701 invoked by alias); 30 Oct 2003 09:11:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20689 invoked from network); 30 Oct 2003 09:11:57 -0000
Date: Thu, 30 Oct 2003 09:11:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
Message-ID: <20031030091156.GA31416@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3F9F1C5B.2050501@netscape.net> <20031029093534.GB22720@cygbert.vinschen.de> <3F9FE3C5.9050505@netscape.net> <20031029173358.GL1653@cygbert.vinschen.de> <3FA05514.3000000@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA05514.3000000@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00047.txt.bz2

On Wed, Oct 29, 2003 at 07:02:28PM -0500, Nicholas Wourms wrote:
>   Still, perhaps Brian's 
> suggestion has some merit?

Yes.  The Solaris-like definition has its point.  Using sysconf or
getpagesize in the macro is fine.

> Which brings up another matter, asm/socket.h.  Can someone point me to 
> what source we should use when defining if ioctl macros in asm/socket.h. 

Aren't these BSD based?  However, when I introduced SIOCGIFADDR and
friends back in 1998, I didn't look anywhere besides the already existing
definitions for SIOCGIFCONF and SIOCGIFFLAGS in Cygwin's asm/socket.h.
I've just used the next values in the row and they were accepted that
way by Geoff.

>  Both bind and bsd seem to have very different definitions in terms of 
> the read/write capabilities of the ioctls...

Don't bother.  Is it a value which could be changed in Cygwin or Winsock?

What are you trying to implement?  I'm really curious.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
