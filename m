Return-Path: <cygwin-patches-return-4976-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12419 invoked by alias); 22 Sep 2004 14:21:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12352 invoked from network); 22 Sep 2004 14:21:01 -0000
Date: Wed, 22 Sep 2004 14:21:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still path.cc
In-Reply-To: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net>
Message-ID: <Pine.CYG.4.58.0409220918030.2736@fordpc.vss.fsi.com>
References: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q3/txt/msg00128.txt.bz2

On Tue, 21 Sep 2004, Pierre A. Humblet wrote:

> 	Avoid infinite loop with names starting in double dots.

This may not be appropriate for this list, but...

Thank you, thank you, thank you!  I often mistype ../somewhere as
..somewhere and lock up my shell.

Thanks again for the fix that I didn't have time to make.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
