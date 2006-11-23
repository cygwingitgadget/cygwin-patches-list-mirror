Return-Path: <cygwin-patches-return-6000-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15870 invoked by alias); 23 Nov 2006 10:09:07 -0000
Received: (qmail 15857 invoked by uid 22791); 23 Nov 2006 10:09:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 23 Nov 2006 10:09:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B5381544001; Thu, 23 Nov 2006 11:08:58 +0100 (CET)
Date: Thu, 23 Nov 2006 10:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] bug # 514 deja vu (cygwin console color handling)
Message-ID: <20061123100858.GI8333@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E1CeJAV-0007GT-00@mrelayng.kundenserver.de> <200611221720.kAMHKjP2020766@ns-srv-2.bln1.siemens.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611221720.kAMHKjP2020766@ns-srv-2.bln1.siemens.de>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00018.txt.bz2

On Nov 22 18:20, Thomas Wolff wrote:
> I noticed that the reverse color bug
>  http://sourceware.org/bugzilla/show_bug.cgi?id=514
> shows up again in recent cygwin1.dll updates. My previous patch 
> is still in the source but additional code apparently has the same 
> effect of rendering output unreadable; the effect is the following:
> * foreground is set bright
> * screen mode is set to reverse
> * cygwin wrongly assumes that the reverse foreground colour (which 
>   actually used to be the non-bright background color) should be 
>   set to bright, which is obviously a wrong idea and often results 
>   in a contrast that renders the output almost unreadable
> 
> The attached shell script test514 demonstrates the bug.
> The attached patch is an attempt to fix the bug again.
> [...]
> * fhandler_console.cc (set_color): Avoid (again) inappropriate intensity 
>      interchanging that used to render reverse output unreadable 
>      when (non-reversed) text is bright.
>      See http://sourceware.org/bugzilla/show_bug.cgi?id=514

Yup, that seems to do the trick.  Thanks, applied.


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
