Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9A1743858C98; Tue, 17 Dec 2024 16:46:17 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6315EA8098D; Tue, 17 Dec 2024 17:46:15 +0100 (CET)
Date: Tue, 17 Dec 2024 17:46:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: /proc/<PID>/stat: set field (18) according to
 scheduling policy
Message-ID: <Z2Gq1_6WcBkikWlR@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e121cfcb-8e37-7100-76fd-75ee4ca50776@t-online.de>
 <a7d173a9-00d9-9355-a784-6061ad282aa0@t-online.de>
 <Z2AYLcLTL6gz_iw_@calimero.vinschen.de>
 <9b7a3f77-7780-5530-cfbf-233b0e0ba5d3@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b7a3f77-7780-5530-cfbf-233b0e0ba5d3@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec 16 18:43, Christian Franke wrote:
> From 46fa0f243d24c6df682ea6722509e890be6adf59 Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Mon, 16 Dec 2024 17:32:55 +0100
> Subject: [PATCH] Cygwin: /proc/<PID>/stat: set field (18) according to
>  scheduling policy
> 
> If a realtime policy is selected, set the '(18) priority' field to the
> negated sched_priority minus one.  If SCHED_IDLE is selected, set it to
> the lowest priority 39.  Also set '(19) nice' to the originally requested
> nice value.  Ensure consistence with the current Windows priority in all
> cases.  Move the sched_priority from/to Windows priority mapping from
> sched_get/setparam() to new functions in miscfuncs.cc.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/fhandler/process.cc        | 26 +++++++++--
>  winsup/cygwin/local_includes/miscfuncs.h |  2 +
>  winsup/cygwin/miscfuncs.cc               | 56 ++++++++++++++++++++++--
>  winsup/cygwin/release/3.6.0              |  5 +++
>  winsup/cygwin/sched.cc                   | 40 +++--------------
>  5 files changed, 88 insertions(+), 41 deletions(-)

Pushed.


Thanks,
Corinna
