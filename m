Return-Path: <cygwin-patches-return-1788-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4555 invoked by alias); 25 Jan 2002 11:06:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4489 invoked from network); 25 Jan 2002 11:05:58 -0000
Subject: Re: [PATCH]Package extention recognition (revision 2)
From: Robert Collins <robert.collins@itdomain.com.au>
To: Michael A Chase <mchase@ix.netcom.com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <000901c1a58f$58a46640$a100a8c0@mchasecompaq>
References:
	<003f01c1a542$742968e0$a100a8c0@mchasecompaq><20020125015129.GA16592@redhat.
	com><015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq><1011948812.18172.17.camel@
	lifelesswks>
	<021701c1a584$f9371f90$a100a8c0@mchasecompaq><1011953063.18172.21.camel@life
	lesswks><026301c1a589$84e33570$a100a8c0@mchasecompaq>
	<02b901c1a58d$11e86820$a100a8c0@mchasecompaq>
	<1011955697.18203.27.camel@lifelesswks> 
	<000901c1a58f$58a46640$a100a8c0@mchasecompaq>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Fri, 25 Jan 2002 03:06:00 -0000
Message-Id: <1011956753.18172.32.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 25 Jan 2002 11:05:57.0453 (UTC) FILETIME=[43CDF7D0:01C1A590]
X-SW-Source: 2002-q1/txt/msg00145.txt.bz2

On Fri, 2002-01-25 at 21:59, Michael A Chase wrote:
> And that test is still there, I moved it into the if () so something like
> ".tar.bz2" wouldn't trigger the return .... : 0;  If all the ifs fail,
> return 0; still occurs.
*blush*
