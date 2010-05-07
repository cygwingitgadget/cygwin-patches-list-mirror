Return-Path: <cygwin-patches-return-7034-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30586 invoked by alias); 7 May 2010 13:21:00 -0000
Received: (qmail 30573 invoked by uid 22791); 7 May 2010 13:20:58 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-55-5.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.55.5)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 07 May 2010 13:20:52 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 5716913C061	for <cygwin-patches@cygwin.com>; Fri,  7 May 2010 09:20:50 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 522772B352; Fri,  7 May 2010 09:20:50 -0400 (EDT)
Date: Fri, 07 May 2010 13:21:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
Message-ID: <20100507132050.GA3590@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1273170255.10571.1373764557@webmail.messagingengine.com> <4BE316D7.3070806@gmail.com> <4BE39DA9.1080902@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BE39DA9.1080902@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00017.txt.bz2

On Fri, May 07, 2010 at 12:57:13AM -0400, Charles Wilson wrote:
>==Aside:
>After all my talk about keeping pseudo_reloc.c synchronized, I'm
>considering adapting Dave's implementation for MSYS, because I'm pretty
>sure that whatever cgf comes up with for "inside cygwin-1.7.6" isn't
>going to work very well "inside msys which is kinda sorta cygwin-1.3.4"
>-- although I could be lucky I suppose.  Oh well.  There are only a few
>msys applications/dlls which are built with pseudo-relocs turned on
>anyway -- just guile and autogen AFAICT -- so "rebuild all of them to
>obtain new fixes" is not very onerous.

Please don't discuss msys here.  This is completely uninteresting to
cygwin-patches.

cgf
