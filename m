Return-Path: <cygwin-patches-return-4761-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18021 invoked by alias); 15 May 2004 13:28:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18006 invoked from network); 15 May 2004 13:28:04 -0000
Date: Sat, 15 May 2004 13:28:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
In-Reply-To: <Pine.CYG.4.58.0405141924320.2836@fordpc.vss.fsi.com>
Message-ID: <Pine.CYG.4.58.0405150823450.3560@fordpc.vss.fsi.com>
References: <20040514180553.GB10458@coe.bosbc.com>
 <Pine.CYG.4.58.0405141743290.1448@fordpc.vss.fsi.com>
 <Pine.CYG.4.58.0405141924320.2836@fordpc.vss.fsi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q2/txt/msg00113.txt.bz2

Uh, scratch that.  Original patch stands.  With this change, close could
still get called multiple times.

Digs hole and hides... :-(

On Fri, 14 May 2004, Brian Ford wrote:

> Ugh!  Ok, this falls under the "too much list noise" category, so I'll
> just shut up now.
>
> On Fri, 14 May 2004, Brian Ford wrote:
>
> +  HANDLE ws;
> +
> +  if (InterlockedDecrement (&window_waiters) == 0
> +      && (ws = (HANDLE) InterlockedExchange ((long *) &window_started, 0)))
> +    CloseHandle (ws);
>
> This part now simplifies to just:
>
> if (InterlockedDecrement (&window_waiters) == 0)
>   CloseHandle (window_waiters);
>
> after the fatal error change.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
