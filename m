Return-Path: <cygwin-patches-return-4652-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27911 invoked by alias); 4 Apr 2004 04:50:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27897 invoked from network); 4 Apr 2004 04:50:47 -0000
Message-Id: <3.0.5.32.20040403234828.00816190@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 04 Apr 2004 04:50:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: path.cc
In-Reply-To: <20040404040127.GB19875@coc.bosbc.com>
References: <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
 <3.0.5.32.20040403214940.007f2650@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00004.txt.bz2

At 11:01 PM 4/3/2004 -0500, you wrote:
>On Sat, Apr 03, 2004 at 09:49:40PM -0500, Pierre A. Humblet wrote:
>>This patch removes old cruft from and streamlines the mainline of 
>>path_conv::check (avoiding a bunch of strlen, strcpy and the like).
>>It also removes trailing / in win32 paths.
>
>Pierre, this patch didn't compile.  I had to declare normalize_win32_path
>to match your usage.

Sorry about that.
The basic problem is that I am working in a sandbox that has other changes
and I tried to build a patch against CVS, without testing it there.
I will get a clean sandbox and do it again.

Your example is very interesting!

>Except that old symlinks that use EA would be slightly slower, right?
Right.


Pierre
