Return-Path: <cygwin-patches-return-4414-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10272 invoked by alias); 17 Nov 2003 21:40:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10256 invoked from network); 17 Nov 2003 21:40:47 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Mon, 17 Nov 2003 21:40:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
cc: newlib@sources.redhat.com
Subject: Re: (fhandler_base::lseek): Include high order bits in return.
In-Reply-To: <Pine.GSO.4.56.0311171454590.922@eos>
Message-ID: <Pine.GSO.4.56.0311171538130.922@eos>
References: <Pine.GSO.4.56.0311171454590.922@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q4/txt/msg00133.txt.bz2

On Mon, 17 Nov 2003, Brian Ford wrote:

> This bug fix got our app past its first problem with > 2 Gig files, but
> then it tripped over ftello.  I'm still trying to figure that one out.
>
> It looks like it got a 32 bit sign extended value somewhere.  Any help would
> be appreciated.  Thanks.
>
Well, that somewhere is ftello64.c line 111.  fp->_offset has a 32 bit
sign extended value.  Anybody know how it got there?

I'm just starting to find my way around parts of Cygwin.  Newlib is
yet another beast for me to discover.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
