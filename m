Return-Path: <cygwin-patches-return-4327-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12750 invoked by alias); 30 Oct 2003 00:02:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12728 invoked from network); 30 Oct 2003 00:02:31 -0000
Message-ID: <3FA05514.3000000@netscape.net>
Date: Thu, 30 Oct 2003 00:02:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@sources.redhat.com
Subject: Re: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
References: <3F9F1C5B.2050501@netscape.net> <20031029093534.GB22720@cygbert.vinschen.de> <3F9FE3C5.9050505@netscape.net> <20031029173358.GL1653@cygbert.vinschen.de>
In-Reply-To: <20031029173358.GL1653@cygbert.vinschen.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00046.txt.bz2

cygwin-patches@cygwin.com wrote:

[SNIP]
> 
> I was mulling over this definitions again and somehow I'm inclined to
> refuse these definitons entirely. 

I see, well I suppose that's ok.

> First of all, you shouldn't use them in applications.  Applications
> should call getpagesize() or sysconf(_SC_PAGESIZE) to get the page
> size. 
> Second, if you use them in a Cygwin patch, I would refuse *that* patch
> since in Cygwin you should also use getpagesize().  Or, even worse,
> in some circumstances you need the allocation granularity which you
> get by calling GetSystemInfo().

Well I  accept your criticism.  Some of this is new territory for me, so 
thanks for taking the time to explain why you think it is wrong.  I 
guess it is back to the drawing board for me.  Still, perhaps Brian's 
suggestion has some merit?

> So, the question is this:  If you should never use these values in an
> application and you should also not use them in Cygwin, why do we need
> them? 

I think I can work around depending on them using the ways you suggested 
and some other ways I've discoved while doing more research.  I'll 
rework the other stuff and resubmit a new patch.

Which brings up another matter, asm/socket.h.  Can someone point me to 
what source we should use when defining if ioctl macros in asm/socket.h. 
  Both bind and bsd seem to have very different definitions in terms of 
the read/write capabilities of the ioctls...

Cheers,
Nicholas
