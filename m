Return-Path: <cygwin-patches-return-4675-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25364 invoked by alias); 12 Apr 2004 23:49:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25253 invoked from network); 12 Apr 2004 23:48:49 -0000
X-Authentication-Warning: thing1-200.fsi.com: ford owned process doing -bs
Date: Mon, 12 Apr 2004 23:49:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@thing1-200
Reply-To: cygwin-patches@cygwin.com
To: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
cc: cygwin-patches@cygwin.com
Subject: Re: [Patch]: path.cc
In-Reply-To: <3.0.5.32.20040412190645.00809e10@incoming.verizon.net>
Message-ID: <Pine.GSO.4.58.0404121842420.29901@thing1-200>
References: <20040410110343.GM26558@cygbert.vinschen.de>
 <3.0.5.32.20040404234622.00800100@incoming.verizon.net>
 <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net>
 <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
 <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
 <3.0.5.32.20040404095756.00804cc0@incoming.verizon.net>
 <3.0.5.32.20040404234622.00800100@incoming.verizon.net>
 <3.0.5.32.20040409231957.00857bb0@incoming.verizon.net>
 <20040410110343.GM26558@cygbert.vinschen.de> <3.0.5.32.20040412190645.00809e10@incoming.verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q2/txt/msg00027.txt.bz2

On Mon, 12 Apr 2004, Pierre A. Humblet wrote:

> I have also observed abnormal behavior on NT4.0
> 1) ls uses ntsec even on remote drives without smbntsec
>
> /> echo $CYGWIN
> bash: CYGWIN: unbound variable

Ok, I'm confused.  Either I don't understand what you're saying, or
the following from the Cygwin User's Guide is too dificult to interpret
correctly?

http://cygwin.com/cygwin-ug-net/using-cygwinenv.html:

(no)smbntsec - if set, use ntsec on remote drives as well (this is the
default).

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
