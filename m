Return-Path: <cygwin-patches-return-4330-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24018 invoked by alias); 31 Oct 2003 08:30:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24006 invoked from network); 31 Oct 2003 08:30:42 -0000
Date: Fri, 31 Oct 2003 08:30:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
Message-ID: <20031031083041.GU1653@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3F9F1C5B.2050501@netscape.net> <20031029093534.GB22720@cygbert.vinschen.de> <3F9FE3C5.9050505@netscape.net> <20031029173358.GL1653@cygbert.vinschen.de> <3FA05514.3000000@netscape.net> <20031030091156.GA31416@cygbert.vinschen.de> <3FA17F7B.1010701@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA17F7B.1010701@netscape.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00049.txt.bz2

On Thu, Oct 30, 2003 at 04:15:39PM -0500, Nicholas Wourms wrote:
> I just want to make sure that I do the right thing.  The numbering seems 
> arbitrary, however I could be wrong.  I just wonder why none of our 
> ioctls are _IOWR, when they are defined that way for bsd/linux?  Perhaps 
> this is a limitation of the winsock?  It could be that I'm just making a 
> big deal over nothing, but I wanted to check first.

It's just not defined in asm/socket.h.  I've always interpreted the _IOW as
a read/write, not just as write.  Now, looking into it again, I see that
using _IOW for the SIOCGIF* control codes was just wrong from the beginning.
They should have been _IOR.  Too bad.  But we can't change that now, since
that would break existing applications.

I'm wondering if we should redefine them, though, and mark the old
values as deprecated, using them in Cygwin only for backward compatibility. 
The new values could easily start from 4.  I'll guess we'll never get
the problem to be out of values...

> >Don't bother.  Is it a value which could be changed in Cygwin or Winsock?
> 
> I don't know, I guess I'll just make it 108 and see what happens.  The 
> group code seems to be arbitrary as well, so I'll just stick with the 
> flow and use `i'.

i?  What i?

> >What are you trying to implement?  I'm really curious.
> 
> [SIOCGIFDSTADDR]

Cool.

> (Gee, a 
> copy of unix network programming 2nd edition would come in handy right 
> about now)

I can recommend it.  It's really good, IMHO just missing info about
using the resolver routines.

>   Not to rant, but 
> our network sockets seems lacking in a few areas, so I hope to 
> contribute there.

Sure they do.  You're welcome to contribute in that area.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
