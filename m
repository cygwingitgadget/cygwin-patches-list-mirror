Return-Path: <cygwin-patches-return-4737-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31274 invoked by alias); 9 May 2004 15:11:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31228 invoked from network); 9 May 2004 15:11:51 -0000
Message-Id: <3.0.5.32.20040509110852.0080d100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 09 May 2004 15:11:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: env -i
In-Reply-To: <20040509003858.GA30449@coe.bosbc.com>
References: <3.0.5.32.20040508144526.0080bdb0@incoming.verizon.net>
 <3.0.5.32.20040508144526.0080bdb0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00089.txt.bz2

At 08:38 PM 5/8/2004 -0400, Christopher Faylor wrote:
>On Sat, May 08, 2004 at 02:45:26PM -0400, Pierre A. Humblet wrote:
>>2004-05-08  Pierre Humblet <pierre.humblet@ieee.org>
>>
>>	* environ.cc (build_env): Only try to construct required-but-missing
>>	variables while issetuid.
>
>Ok with me.  Wasn't this your addition to begin with?

OK, I will apply it. "to begin with", yes, but you wrote what's there
now.

Pierre
