Return-Path: <cygwin-patches-return-2013-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11656 invoked by alias); 27 Mar 2002 14:48:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11607 invoked from network); 27 Mar 2002 14:48:44 -0000
Content-Type: text/plain
Content-Disposition: inline
Mime-Version: 1.0
From: <tvoverbe@cistron.nl>
Date: Thu, 28 Mar 2002 21:05:00 -0000
To: <cygwin-apps@cygwin.com>,<cygwin-patches@cygwin.com>,robert.collins@itdomain.com.au
Subject: Re: Patch for Setup.exe problem and for mklink2.cc
Cc: <jonas_eriksson@home.se>
Message-Id: <E16qEjA-0007iC-00@smtp2.cistron.nl>
X-SW-Source: 2002-q1/txt/msg00370.txt.bz2

Robert wrote:
> I'll check the off-by-one fix in tomorrow, as I'm off to bed now. 
> 
> As for the &'s, I wonder if it's a w32api reference issue? The compiler
> complains if they are present for me.

For me it is the opposite. g++ complains when they are *not*
present.
The w32api include files used are the one in the src/winsup/
tree, not the cygwin package.
Does that make a difference ?
That part of the winsup tree was retrieved a few
days ago from cvs HEAD.
I am using gcc-2.95.3-5, not gcc3.

Ton van Overbeek
P.S. Good night, it is 01:45 in Sydney 
