Return-Path: <cygwin-patches-return-4918-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15315 invoked by alias); 28 Aug 2004 14:11:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15299 invoked from network); 28 Aug 2004 14:11:21 -0000
Message-Id: <3.0.5.32.20040828100709.0081d8c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 28 Aug 2004 14:11:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Truncate
In-Reply-To: <20040828093751.GW27978@cygbert.vinschen.de>
References: <3.0.5.32.20040827214238.00819640@incoming.verizon.net>
 <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net>
 <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
 <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
 <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net>
 <3.0.5.32.20040827214238.00819640@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00070.txt.bz2

At 11:37 AM 8/28/2004 +0200, Corinna Vinschen wrote:
>Hi Pierre,
>
>On Aug 27 21:42, Pierre A. Humblet wrote:
>> At 01:00 PM 8/23/2004 +0200, Corinna Vinschen wrote:
>> >Except for this comment, which isn't valid (see above), please check it
in.
>> 
>> Done. But here is another simple patch taking care of your concern that
>> we can fail while zero filling, leaving the file system filled to capacity.
>> 
>> 2004-08-28  Pierre Humblet <pierre.humblet@ieee.org>
>> 
>> 	* fhandler.cc (fhandler_base::write): In the lseek_bug case, set EOF
>> 	before zero filling. Combine similar error handling statements. 
>
>the first part of the patch is ok, but somehow the new `goto' looks
>somewhat weird to me.  What about this instead:

<snip>

Sure. Will you apply it?

Pierre
 
