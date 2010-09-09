Return-Path: <cygwin-patches-return-7087-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22032 invoked by alias); 9 Sep 2010 23:06:54 -0000
Received: (qmail 22022 invoked by uid 22791); 9 Sep 2010 23:06:52 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0	tests=AWL,BAYES_00,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from ixqw-mail-out.ixiacom.com (HELO ixqw-mail-out.ixiacom.com) (66.77.12.12)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 09 Sep 2010 23:06:37 +0000
Received: from [10.64.33.35] (10.64.33.35) by IXCA-HC1.ixiacom.com (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Thu, 9 Sep 2010 16:06:35 -0700
Message-ID: <4C89687A.90107@ixiacom.com>
Date: Thu, 09 Sep 2010 23:06:00 -0000
From: Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
MIME-Version: 1.0
To: <cygwin-patches@cygwin.com>
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx> <4C893D9C.6040406@gmail.com> <0af101cb5064$386d4cf0$2a0010ac@wirelessworld.airvananet.com>
In-Reply-To: <0af101cb5064$386d4cf0$2a0010ac@wirelessworld.airvananet.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00047.txt.bz2

On 09/09/2010 2:16 PM, Pierre A. Humblet wrote:
> So, for example, if the user logs in interactively while a cron job (or another service)
> is running, /tmp may be mapped differently than if no cron job is running, because
> TMP may be defined differently in the service environment.
> That is not desirable.

I believe that information is kept in Cygwin shared memory regions on a per-user
basis. I imagine there would other other unwanted side-effects if this were not the
case.

Assuming this to be the case, services running as SYSTEM or another user
cannot influence the mount decision of /tmp for the current user.

So the only consideration is if there is a service running alongside the
currently logged in user.

1. /tmp specified in /etc/fstab
2. /tmp present on filesystem.

   No difference in behaviour with proposed patch in these cases.

3. /tmp not present in either /etc/fstab or filesystem, and no TMP or TEMP

   No /tmp is available. Programs will have manage without it.

4. /tmp not present in either /etc/fstab or filesystem, but either TMP or TEMP present

   Without the patch, this is the same as case (3).

   Settings for TMP or TEMP are injected into the Win32 process via the
   User Environment Variables:

	http://msdn.microsoft.com/en-us/library/bb776899%28VS.85%29.aspx

   Thus the service-running-as-user and the logged in user would inherit
   the same values.


I can see one way to subvert (4). It is possible for a service to run as
a plain Win32 process, modify TMP (or TEMP), then launch the first
Cygwin process which would then mount /tmp at the modified location.


A similar scenario could occur the other way around too.

I think these scenarios are not likely to occur often. Usually TMP and TEMP
are set as User Environment Variables and don't get changed.


If it's important to lock down the location of /tmp, then either create /tmp
in the filesystem or create an entry in /etc/fstab. This is what you're
required to do in the current implementation anyway because without it, no
/tmp is made available (and bash will complain, etc).


Earl
