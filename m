Return-Path: <cygwin-patches-return-5170-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2597 invoked by alias); 26 Nov 2004 22:02:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2532 invoked from network); 26 Nov 2004 22:01:56 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 26 Nov 2004 22:01:56 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id DDA891B422; Fri, 26 Nov 2004 17:01:57 -0500 (EST)
Date: Fri, 26 Nov 2004 22:02:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] bugs # 512 and 514 / cygwin console handling
Message-ID: <20041126220157.GA24705@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E1CXmec-00015U-00@mrelayng.kundenserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CXmec-00015U-00@mrelayng.kundenserver.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00171.txt.bz2

On Fri, Nov 26, 2004 at 05:04:01AM +0100, Thomas Wolff wrote:
>attached is a patch to fhandler_console.cc that fixes two bugs:
>512 wrong mouse click position reports in cygwin terminal
>514 cygwin terminal: wrong color handling in reverse display mode

I probably should have mentioned this:

http://cygwin.com/contrib.html

when I directed you to mailing lists.

Patches should come with changelogs and non-trivial patches require the
completion of an assignment with Red Hat.

I think if you break your patch into two submissions you probably can
get by without sending an assignment to Red Hat but if you plan on
making any future changes to the DLL, you should consider sending in an
assignment.

cgf
