Return-Path: <cygwin-patches-return-2532-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 666 invoked by alias); 27 Jun 2002 17:18:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 645 invoked from network); 27 Jun 2002 17:18:54 -0000
Message-ID: <3D1B48A9.60909@netscape.net>
Date: Fri, 28 Jun 2002 02:51:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: A minor patch to Makefile.in
References: <3D19F55E.3070800@netscape.net> <3D19F812.70509@netscape.net> <20020627152129.GA6961@redhat.com> <3D1B3783.7030201@netscape.net> <20020627160909.GE7598@redhat.com> <3D1B4293.30707@netscape.net> <20020627165803.GC28018@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00515.txt.bz2

Christopher Faylor wrote:

>You're right.  You'll need a copyright assignment.
>
Ok, well I'll work on getting that situated.

>Nope.  As someone who really detests automake, you can probably guess
>why that would be so.
>
>And, since every directory underneath winsup has different configuration
>requirements, it really doesn't make much sense to merge them.  I really
>don't see a big deal here.  There's nothing broken that requires fixing
>as far as I can tell.
>
I see, well I suppose that is one way to look at it.  Anyhow, are the 
gettext m4 macros (part of the gettext package) installed on 
sources.redhat.com?  The reason being that there is no point in 
reinventing the wheel when a perfectly good set of macros are already 
defined.  I ask only because I assume you will regenerate configure and 
aclocal.m4 from my changes to configure.in.

Cheers,
Nicholas
