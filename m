Return-Path: <cygwin-patches-return-6137-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13213 invoked by alias); 31 Aug 2007 00:16:49 -0000
Received: (qmail 13179 invoked by uid 22791); 31 Aug 2007 00:16:48 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-71-216.bstnma.fios.verizon.net (HELO cgf.cx) (96.233.71.216)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 31 Aug 2007 00:16:42 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 2194A13C4CA; Thu, 30 Aug 2007 20:16:41 -0400 (EDT)
Date: Fri, 31 Aug 2007 00:16:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: Cygwin patches <cygwin-patches@cygwin.com>
Subject: Re: FW: mkgroup (366): [2123] The API return buffer is too small.
Message-ID: <20070831001641.GA21272@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin patches <cygwin-patches@cygwin.com>
References: <007b01c7eb25$0e8716c0$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007b01c7eb25$0e8716c0$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00012.txt.bz2

On Thu, Aug 30, 2007 at 05:44:39PM +0100, Dave Korn wrote:
>On 30 August 2007 01:35, Brian Egge wrote:
>
>> When running mkgroup after installing cygwin I receive the following
>> error:
>> 
>> $ mkgroup  -l -d > /etc/group
>> mkgroup (366): [2123] The API return buffer is too small.
>> 
>> I suspect this is due to the large number of groups our organization
>> has.
>
>  Very strange.  All the other netenum* calls use MAX_PREFERRED_LENGTH.  Can't
>see why this one would be omitted, but the fix is basically obvious.
>
>  Tested by turning down the size to 128 so I could reproduce the error on my
>system here, then using MAX_PREFERRED_LENGTH and watching it no longer fail.
>
>
>winsup/utils/ChangeLog:
>
>	* mkgroup.c (enum_groups):  Use MAX_PREFERRED_LENGTH in netgroupenum
>	call so that it will automatically size returned buffer sufficiently.

Looks good to me.  Please check it in, Dave.

Thanks for the patch.

cgf
