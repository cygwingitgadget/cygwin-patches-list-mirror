Return-Path: <cygwin-patches-return-3203-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27740 invoked by alias); 18 Nov 2002 22:56:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27730 invoked from network); 18 Nov 2002 22:56:47 -0000
Date: Mon, 18 Nov 2002 14:56:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: Implementation of functions in netdb.h
Message-ID: <20021118225717.GA17408@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DDA11BD.5862.1E11B85E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDA11BD.5862.1E11B85E@localhost>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00154.txt.bz2

On Tue, Nov 19, 2002 at 10:26:05AM +1300, Craig McGeachie wrote:
Content-Description: Mail message body
>This is an implementation of [set|get|end][serv|proto]ent functions as
>defined in netdb.h.  It was written primarily so I could port the DHCP
>software from ISC to Cygwin.
>
>Firstly, this is a larger than trivial submission, I suppose I will 
>have fill in a standard assignment form.  However, I thought I post 
>this first to see if I'm on the right track.
>
>This has been coded against the 1.3.14-1 sources.  That's what was 
>available when I started, and I can't read the CVS repository directly.

Why?

>I have implemented all the functions in a new file called netdb.cc.  I
>wasn't sure if I should add the new file, or add functions to net.cc.
>I went for the new file, in the expectation that I would add
>get|set|end functions for the hosts and networks files and some stage
>in the future.

A new file is fine.

The ChangeLog is, not quite right.  Not a big deal, but all you need to
do for netdb.cc is add "New file."

I didn't look at the sources too closely because I would not want to
be encumbered if you do not fill out an assignment but I will note that
putting a "Cygwin internal" comment in front of static functions isn't
adding any useful information.

Otherwise, from a cursory glance, it looks fine.  You will definitely
need to send in an assignment.

>2002-11-19 Craig McGeachie <slapdau@yahoo.com.au>
> * netdb.cc (open_system_file, get_entire_line, get_alias_list)
> (open_services_file, parse_services_line, free_servent)
> (cygwin_setservent, cygwin_getservent, cygwin_endservent)
> (open_protocol_file, parse_protocol_line, free_protoent)
> (cygwin_setprotoent, cygwin_getprotoent, cygwin_endprotoent):
> Create a new file implementing the service and protocol
> enumeration functions in netdb.h.
> * Makeile.in (DLL_OFILES): Add reference to the new netdb.cc
> file.
> * cygwin.din : Add new aliased exports for service and
> protocol enumerations in netdb.cc.

cgf
