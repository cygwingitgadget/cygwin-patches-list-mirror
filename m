Return-Path: <cygwin-patches-return-4325-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11877 invoked by alias); 29 Oct 2003 17:34:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11868 invoked from network); 29 Oct 2003 17:34:03 -0000
Date: Wed, 29 Oct 2003 17:34:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
Message-ID: <20031029173358.GL1653@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>,
	cygwin-patches@sources.redhat.com
References: <3F9F1C5B.2050501@netscape.net> <20031029093534.GB22720@cygbert.vinschen.de> <3F9FE3C5.9050505@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9FE3C5.9050505@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00044.txt.bz2

On Wed, Oct 29, 2003 at 10:59:01AM -0500, Nicholas Wourms wrote:
> cygwin-patches@cygwin.com wrote:
> >- The definition of PAGE_MASK is... a problem.  Your definition is the
> >  BSD definition (PAGE_SIZE-1), while Linux defines it as the negation
> >  thereof, (~(PAGE_SIZE-1)).  I don't know what way to follow here.
> >  I guess it's all one, considering that we don't use it in Cygwin so
> >  far.  While we once decided that, if SUSv3 fails to lend us a hand,
> >  we would try to map the Linux behaviour, the sys/param.h file is
> >  a header for mostly BSD definitions.
> 
> I know, but I couldn't find this defined like that in any other OS.  I 
> felt guilty enough by casting the bitvector, I was worried about be 
> "accused" of stealing GPL'ed code.  Thus I thought it better to stick 
> with the BSD definition.  Interestingly enough, Wine's 
> `memory/virtual.c' has `PAGE_SHIFT' defined to `12' and PAGE_MASK 
> defined to 0xfff or 4095 (4096-1).  log2(4096) gives a float answer of 
> 12.  Also Doug Lea's malloc defines PAGE_MASK as (PAGE_SIZE-1) and then 
> negates it where necessary.  OTOH, I found that dlltool from 
> binutils-2.7 used to define it as a negation.  Since you are more of an 
> expert on mmap then I, I'll leave it others to decide.  If you want to 
> leave it out for now, that would be ok, too.  Primarily, I was after 
> PAGE_SHIFT & PAGE_SIZE but decided to add PAGE_MASK since it was 
> clustered with the others in all the headers I looked at.

I was mulling over this definitions again and somehow I'm inclined to
refuse these definitons entirely. 

First of all, you shouldn't use them in applications.  Applications
should call getpagesize() or sysconf(_SC_PAGESIZE) to get the page
size. 

Second, if you use them in a Cygwin patch, I would refuse *that* patch
since in Cygwin you should also use getpagesize().  Or, even worse,
in some circumstances you need the allocation granularity which you
get by calling GetSystemInfo().

So, the question is this:  If you should never use these values in an
application and you should also not use them in Cygwin, why do we need
them? 

If you can come up with a good description...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
