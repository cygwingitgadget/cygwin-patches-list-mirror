Return-Path: <cygwin-patches-return-4741-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14906 invoked by alias); 12 May 2004 01:53:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14897 invoked from network); 12 May 2004 01:53:41 -0000
Message-Id: <3.0.5.32.20040511215039.007d9210@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 12 May 2004 01:53:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: tty's on Terminal Services
In-Reply-To: <20040512005643.GA9634@coe.bosbc.com>
References: <3.0.5.32.20040511192134.007d4950@incoming.verizon.net>
 <3.0.5.32.20040511192134.007d4950@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00093.txt.bz2

At 08:56 PM 5/11/2004 -0400, Christopher Faylor wrote:
>On Tue, May 11, 2004 at 07:21:34PM -0400, Pierre A. Humblet wrote:
>>This patch allows the use of tty's from privileged
>>accounts on Terminal Services.
>
>What's your feeling for the dangerousness of this patch?  It looks very
>reasonable (in fact it looks like a "DUH").  Do you think it's safe
>to include given that 1.5.10 is imminent?
>
>If so, please check in.

Done. The danger is that ttys are broken now, but that would be
noticed quickly. I don't have access to a Windows 2003 server, so I
have not verified that the patch works as it should for privileged
users.

By the way, while checking the names with sysinternals I noticed 
there were a lot of mtinfo handles, all mapping the same name.
They accumulate with each process generation. 

Pierre
