Return-Path: <cygwin-patches-return-2248-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7076 invoked by alias); 29 May 2002 02:13:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7062 invoked from network); 29 May 2002 02:13:40 -0000
Date: Tue, 28 May 2002 19:13:00 -0000
From: Matt <matt@use.net>
X-Sender:  <matt@cesium.clock.org>
To: Don Bowman <don@sandvine.com>
Cc: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: New stat stuff (was [PATCH] improve performance of stat() ope
 rations (e.g. ls -lR )) 
In-Reply-To: <FE045D4D9F7AED4CBFF1B3B813C853376762B1@mail.sandvine.com>
Message-ID: <Pine.NEB.4.30.0205281912350.2604-100000@cesium.clock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q2/txt/msg00231.txt.bz2

On Tue, 28 May 2002, Don Bowman wrote:

> So I've performed a mini-benchmark of Chris' changes.
>
> I did a ls -lR >/dev/null of the cygwin source tree on my
> notebook.

It might be a good test to do ls -lR >/test.txt between the different
configurations and diff the output to make sure nothing was adversely
affected as well. I can give this a try if you are short on time.


--
http://www.clock.org/~matt
