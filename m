Return-Path: <cygwin-patches-return-4883-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24814 invoked by alias); 27 Jul 2004 01:36:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24801 invoked from network); 27 Jul 2004 01:36:58 -0000
Message-Id: <3.0.5.32.20040726213310.0080be30@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 27 Jul 2004 01:36:00 -0000
To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>,
 cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: RE: Fix dup for /dev/dsp
In-Reply-To: <3.0.5.32.20040724120400.00808b80@incoming.verizon.net>
References: <01C47174.AD674DB0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00035.txt.bz2

At 12:04 PM 7/24/2004 -0400, Pierre A. Humblet wrote:
<snip>

>But the current code seems to assume a shared memory. Otherwise setting
>the "owner" to the current PID is completely useless (except perhaps
>if a fork occurs while the device is playing. Doing that would be 
>an interesting test!) My 2 cents are that I would try to remove owner.
>While doing so we would see if (and why) it's helpful after all. 

Gerd, (sorry for previous misspells)

Following up on one of my earlier questions, I have looked at the possible
"states" of the /dev/dsp driver and what would happen following a fork.

There are basically 3 states:
1) /dev/dsp just opened
     - R/W flag set
2) After 1st write/read
     - Audio_X_ exists
     - Windows audio driver opened
     - handle audio::dev_ != NULL
     - audio::owner == PID
3) After reset/stop
     - Audio_X_ exists
     - Windows audio driver closed
     - handle audio_X::dev_ keeps its old value
     - audio_X::owner == 0
     from here go back to 2 or close.

If a fork occurs in state 2), the "owner" will be set to the 
PPID in the child. The child will remain locked out.

Suggestions:
  - get rid of owner and related tests. 
  - reset dev_ to 0 when closing Windows driver
  - use dev_ to determine what calls can be made to
    the Windows driver
  - reset dev_ to 0 in fixup-after-fork

Pierre
