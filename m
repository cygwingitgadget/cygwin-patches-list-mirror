Return-Path: <cygwin-patches-return-1786-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26462 invoked by alias); 25 Jan 2002 10:48:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26383 invoked from network); 25 Jan 2002 10:48:22 -0000
Subject: Re: [PATCH]Package extention recognition (revision 2)
From: Robert Collins <robert.collins@itdomain.com.au>
To: Michael A Chase <mchase@ix.netcom.com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <02b901c1a58d$11e86820$a100a8c0@mchasecompaq>
References:
	<003f01c1a542$742968e0$a100a8c0@mchasecompaq><20020125015129.GA16592@redhat.
	com>
	<015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq><1011948812.18172.17.camel@life
	lesswks> <021701c1a584$f9371f90$a100a8c0@mchasecompaq>
	<1011953063.18172.21.camel@lifelesswks>
	<026301c1a589$84e33570$a100a8c0@mchasecompaq> 
	<02b901c1a58d$11e86820$a100a8c0@mchasecompaq>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Fri, 25 Jan 2002 02:48:00 -0000
Message-Id: <1011955697.18203.27.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 25 Jan 2002 10:48:20.0990 (UTC) FILETIME=[CE1A81E0:01C1A58D]
X-SW-Source: 2002-q1/txt/msg00143.txt.bz2

On Fri, 2002-01-25 at 21:42, Michael A Chase wrote:
> I think this covers all your concerns.  If not, I'll fix it in the morning.

Close, I'll tidy the last bit up. 

The ? ext-path:0's are important because they ensure that the string
isn't part of a filename like:
foo.tar.bz2-patch or something similar :}

Rob

> --
> Mac :})
> ** I normally forward private questions to the appropriate mail list. **
> Give a hobbit a fish and he eats fish for a day.
> Give a hobbit a ring and he eats fish for an age.
> 
> ChangeLog:
> 
> 2002-01-25  Michael A Chase <mchase@ix.netcom.com>
> 
>     * filemanip.cc (find_tar_ext): Clean up tests for .tar.gz and .tar.
>     * fromcwd.cc (do_fromcwd): Expand FIXME comment in source file check.
>     * install.cc (install_one_source): Add space between words in log()
> call.
> 

