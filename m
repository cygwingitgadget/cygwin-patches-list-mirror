Return-Path: <cygwin-patches-return-4257-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27487 invoked by alias); 27 Sep 2003 02:37:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27472 invoked from network); 27 Sep 2003 02:37:56 -0000
Message-Id: <3.0.5.32.20030926223605.00822510@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 27 Sep 2003 02:37:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Turning pinfo security on
In-Reply-To: <20030927022130.GA16851@redhat.com>
References: <3.0.5.32.20030926221700.008209b0@incoming.verizon.net>
 <3.0.5.32.20030926221700.008209b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00273.txt.bz2

At 10:21 PM 9/26/2003 -0400, Christopher Faylor wrote:
>On Fri, Sep 26, 2003 at 10:17:00PM -0400, Pierre A. Humblet wrote:
>>Following Chris' new signal handling approach and the previous
>>patch "Giving access to pinfo after seteuid and exec", we can
>>now turn pinfo security on.
>>
>>It's just a matter of removing the FILE_MAP_WRITE permission for
>>Everybody, and a couple of useless PID_MAP_WRITE in pinfo constructors.
>>I have left the PID_MAP_WRITE in the winpids constructors for now,
>>they will be removed later.
>
>You can check this in and just check in the winpids stuff when you get
>around to that step.

OK, I will also remove the "try first to open RW" in the winpids.

BTW, now that your sigpacket includes the sending pid, the commune stuff
could be simplified and avoid calling winpids. It knows whom to talk
to (but it must still double check for security).
Another benefit of your method!

Pierre
 
