Return-Path: <cygwin-patches-return-7088-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27273 invoked by alias); 10 Sep 2010 00:54:40 -0000
Received: (qmail 27216 invoked by uid 22791); 10 Sep 2010 00:54:29 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-46-163.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.46.163)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 10 Sep 2010 00:54:24 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 75A0813C061	for <cygwin-patches@cygwin.com>; Thu,  9 Sep 2010 20:54:22 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 6902E2B352; Thu,  9 Sep 2010 20:54:22 -0400 (EDT)
Date: Fri, 10 Sep 2010 00:54:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
Message-ID: <20100910005422.GA19699@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx> <4C893D9C.6040406@gmail.com> <0af101cb5064$386d4cf0$2a0010ac@wirelessworld.airvananet.com> <4C89687A.90107@ixiacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C89687A.90107@ixiacom.com>
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
X-SW-Source: 2010-q3/txt/msg00048.txt.bz2

On Thu, Sep 09, 2010 at 04:06:34PM -0700, Earl Chew wrote:
>On 09/09/2010 2:16 PM, Pierre A. Humblet wrote:
>>So, for example, if the user logs in interactively while a cron job (or
>>another service) is running, /tmp may be mapped differently than if no
>>cron job is running, because TMP may be defined differently in the
>>service environment.  That is not desirable.
>
>I believe that information is kept in Cygwin shared memory regions on a
>per-user basis.  I imagine there would other other unwanted
>side-effects if this were not the case.

Everyone:

If this discussion is going to continue then please move to the Cygwin
mailing list.  We are not going to be applying the patch so further
discussion is not going to be patch related.

cgf
