Return-Path: <cygwin-patches-return-4620-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15480 invoked by alias); 23 Mar 2004 00:29:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15468 invoked from network); 23 Mar 2004 00:29:40 -0000
Message-Id: <3.0.5.32.20040322192817.007f69d0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 23 Mar 2004 00:29:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Win95
In-Reply-To: <20040322202004.GA522@redhat.com>
References: <405F4530.F3188C94@phumblet.no-ip.org>
 <405EF9F4.A97FF863@phumblet.no-ip.org>
 <20040322185405.GA3266@redhat.com>
 <405F4530.F3188C94@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q1/txt/msg00110.txt.bz2

At 03:20 PM 3/22/2004 -0500, Christopher Faylor wrote:
>On Mon, Mar 22, 2004 at 02:57:36PM -0500, Pierre A. Humblet wrote:
>>
>>It works on NT4.0. Will test on 95 and ME this evening.

Fine on ME. There has already been a more complete Win95 test
reported on the list, so I will pass.

>The for loop had something like this:
>
>int i;
>for (char **peb = ebp, i = 0;
>
>That defined a char **i rather than using the 'int i'.
                 
Thanks, I had missed that. But I think it really defines
a char i.

Pierre
