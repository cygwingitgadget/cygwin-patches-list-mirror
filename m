Return-Path: <cygwin-patches-return-7969-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 728 invoked by alias); 9 Feb 2014 20:33:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 692 invoked by uid 89); 9 Feb 2014 20:33:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Sun, 09 Feb 2014 20:33:13 +0000
Received: from pool-71-126-240-215.bstnma.fios.verizon.net ([71.126.240.215] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1WCb3u-000KDX-Lh	for cygwin-patches@cygwin.com; Sun, 09 Feb 2014 20:33:11 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id BD8C060112	for <cygwin-patches@cygwin.com>; Sun,  9 Feb 2014 15:33:08 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Sun, 09 Feb 2014 15:33:08 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX196y0k1D3HpNuzKzUH53OUU
Date: Sun, 09 Feb 2014 20:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Expand $CYGWIN error_start processing
Message-ID: <20140209203308.GA5453@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1391905541-986-1-git-send-email-mingw.android@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1391905541-986-1-git-send-email-mingw.android@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00042.txt.bz2

On Sun, Feb 09, 2014 at 12:25:40AM +0000, Ray Donnelly wrote:
>I want to use QtCreator as my debugger but the hardcoded
>nature of error_start makes that impossible.
>
>This change allows a formatted commandline to be used where
>'|' is used to represent spaces and <program-name> and
><process-id> are special tokens.
>
>In my case, I set my CYGWIN env. var to
>error_start:C:/Qt/bin/qtcreator.exe|-debug|<process-id>
>
>.. note, QtCreator doesn't work if passed the program name
>and must be invoked with the -debug option.
>
>Ray Donnelly (1):
>  * winsup/cygwin/exceptions.cc: Expand $CYGWIN error_start          
>    processing so that custom commandlines can be passed to          
>    the debugger program using '|' as an argument delimiter          
>    and <program-name> and <process-id> as special tokens.
>
> winsup/cygwin/exceptions.cc | 50 +++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 46 insertions(+), 4 deletions(-)

Thanks for the patch but adding a new argument delimiter or way to quote
is not something that I'm too keen on.

I have just added, in CVS, the ability to do this:

set CYGWIN=error_start="blah whatever \"more stuff'" and more"

(The above is CMD quoting style of course)

cgf
