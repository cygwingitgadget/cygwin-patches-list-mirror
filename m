Return-Path: <cygwin-patches-return-3204-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20034 invoked by alias); 19 Nov 2002 01:16:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19932 invoked from network); 19 Nov 2002 01:16:05 -0000
From: "Craig McGeachie" <slapdau@yahoo.com.au>
To: cygwin-patches@cygwin.com
Date: Mon, 18 Nov 2002 17:16:00 -0000
MIME-Version: 1.0
Subject: Re: PATCH: Implementation of functions in netdb.h
Reply-to: cygwin-patches@cygwin.com
Message-ID: <3DDA4796.3417.1EE40D05@localhost>
Priority: normal
In-reply-to: <20021118225717.GA17408@redhat.com>
References: <3DDA11BD.5862.1E11B85E@localhost>
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-SW-Source: 2002-q4/txt/msg00155.txt.bz2

On 18 Nov 2002 at 17:57, Christopher Faylor wrote:
> Why?

I am looking for house and job, and staying with a friend, who runs a 
small LAN, shares the dialup connection, and is sufficiently paranoid 
to run a firewall setup with mail and HTTP relaying (amongst others) - 
no exceptions.

> but I will note that putting a "Cygwin internal" comment in front of
> static functions isn't adding any useful information. 

I need more comments anyway.  Just testing the water before I go all 
out adding them.  I put "Cygwin internal" in because that is what I saw 
in net.cc, and I thought it might be some sort of standard.

> Otherwise, from a cursory glance, it looks fine.  You will definitely
> need to send in an assignment.

Will do.  It'll take maybe a week to arrive from New Zealand.  In the 
meantime I have to tidy up the submission a bit.

I've tried to compile the source for Cygwin 1.3.15-2 prior to putting 
netdb.cc in, but I am having problems with fhandler_serial.cc.  With 
the rewrite of fhandler_serial::ioctl, and the inclusion of 
ddk/ntddser.h, I can no longer compile.  I have copy of the W2K DDK, 
and tried pointing the compiler at the include directory there, but 
unsurprisingly this doesn't work.  Is there a Cygwin version of the DDK 
headers that I should use, in the same way that w32api provides a 
Cygwin version of the Win32 SDK headers?

----------------+-------------------------------------------------
Craig McGeachie | #include <cheesy_tag.h>
+64(21)037-6917 | while (!inebriated) c2h5oh=(++bottle)->contents;
----------------+-------------------------------------------------

