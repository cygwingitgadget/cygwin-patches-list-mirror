Return-Path: <cygwin-patches-return-3828-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24300 invoked by alias); 20 Apr 2003 21:51:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24291 invoked from network); 20 Apr 2003 21:51:12 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: hostid patch
Date: Sun, 20 Apr 2003 21:51:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHMEPHDIAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20030416025654.GA21129@redhat.com>
Importance: Normal
X-SW-Source: 2003-q2/txt/msg00055.txt.bz2

> On Tue, Apr 15, 2003 at 08:55:08PM +0100, Chris January wrote:
> >*Not* tested on anything other than Windows XP.
> >
> >Adds gethostid function to Cygwin. Three patches: one for Cygwin, one for
> >newlib and one for w32api.
> >If I've done anything wrong let me know and I'll try to fix it.
>
> I tried this on Windows XP and, when run repeatedly, I get two
> different numbers:
>
> m:\test>gethostid
> 0xf9926a74
>
> m:\test>gethostid
> 0xdfd35415
>
> The highly sophisticated program that I'm using is below.
>
> I take it this doesn't happen to you, Chris?
Can you send me two strace outputs with different results please?
There are debug_printf's all the way through the hostid function that output
the result at each stage and these can be used to identify which value is
changing between calls.

Thanks
Chris
