Return-Path: <cygwin-patches-return-5267-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18212 invoked by alias); 21 Dec 2004 16:57:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18185 invoked from network); 21 Dec 2004 16:57:45 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.186.67)
  by sourceware.org with SMTP; 21 Dec 2004 16:57:45 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I930MU-002BYH-7I
	for cygwin-patches@cygwin.com; Tue, 21 Dec 2004 12:01:42 -0500
Message-Id: <3.0.5.32.20041221115233.007ecce0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 21 Dec 2004 16:57:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041204054348.GA14532@trixie.casa.cgf.cx>
References: <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
 <20041120062339.GA31757@trixie.casa.cgf.cx>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <20041114051158.GG7554@trixie.casa.cgf.cx>
 <20041116054156.GA17214@trixie.casa.cgf.cx>
 <419A1F7B.8D59A9C9@phumblet.no-ip.org>
 <20041116155640.GA22397@trixie.casa.cgf.cx>
 <20041120062339.GA31757@trixie.casa.cgf.cx>
 <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00268.txt.bz2

At 12:43 AM 12/4/2004 -0500, you wrote:
>On Thu, Dec 02, 2004 at 09:13:11PM -0500, Pierre A. Humblet wrote:
>>- Non cygwin processes started by cygwin are not shown by ps
>>  anymore and cannot be killed.
>>
>>- spawn(P_DETACH) does not work correctly when spawning non-cygwin 
>>  processes.

> The above are both unintentional and fixable.

Sorry for the slow response, but I still see the second problem.

The following program does not behave the same in 1.5.12 and 
CYGWIN_ME-4.90 hpn5170 1.5.13s(0.117/4/2) 20041218 11:42:51

#include <process.h>
#include <stdio.h>

main()
{
    spawnl(_P_DETACH, "/c/WINDOWS/notepad", "notepad", 0);
}
