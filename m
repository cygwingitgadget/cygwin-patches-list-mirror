Return-Path: <cygwin-patches-return-4326-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14170 invoked by alias); 29 Oct 2003 18:39:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14160 invoked from network); 29 Oct 2003 18:39:09 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Wed, 29 Oct 2003 18:39:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@sources.redhat.com
Subject: Re: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
In-Reply-To: <20031029173358.GL1653@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.56.0310291237340.19644@eos>
References: <3F9F1C5B.2050501@netscape.net> <20031029093534.GB22720@cygbert.vinschen.de>
 <3F9FE3C5.9050505@netscape.net> <20031029173358.GL1653@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q4/txt/msg00045.txt.bz2

On Wed, 29 Oct 2003, Corinna Vinschen wrote:

> First of all, you shouldn't use them in applications.  Applications
> should call getpagesize() or sysconf(_SC_PAGESIZE) to get the page
> size.
>
FYI, Solaris defines these as:

#define PAGESIZE        (_sysconf(_SC_PAGESIZE))
#define PAGEOFFSET      (PAGESIZE - 1)
#define PAGEMASK        (~PAGEOFFSET)

It might be good to have them just for compatability.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
