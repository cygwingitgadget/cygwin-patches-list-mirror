Return-Path: <cygwin-patches-return-3007-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22669 invoked by alias); 20 Sep 2002 12:43:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22536 invoked from network); 20 Sep 2002 12:43:38 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 20 Sep 2002 05:43:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] new mutex implementation 2. posting
In-Reply-To: <1032524533.10933.52.camel@lifelesswks>
Message-ID: <Pine.WNT.4.44.0209201428100.279-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00455.txt.bz2



On Fri, 20 Sep 2002, Robert Collins wrote:

> On Tue, 2002-09-17 at 19:34, Thomas Pfaff wrote:
>
> Thomas, the patch is incomplete.
>
> pthread_cond::TimedWait needs updating as well...

Yup, but it seems that this was broken on NT before i made my changes,
because it was never updated to use Critical Sections when they are
available.

>
> also, please diff against current HEAD, the previous patch failed on the
> mutex section (I'm not sure why, may be white space changes or
> something).

Must wait until tomorrow.
I will also recreate my pending patches 3 and 4 against current since your
your patch has broken some parts of them.

Thomas
