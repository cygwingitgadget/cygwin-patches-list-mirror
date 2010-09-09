Return-Path: <cygwin-patches-return-7082-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8561 invoked by alias); 9 Sep 2010 16:37:56 -0000
Received: (qmail 8485 invoked by uid 22791); 9 Sep 2010 16:37:54 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from ixqw-mail-out.ixiacom.com (HELO ixqw-mail-out.ixiacom.com) (66.77.12.12)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 09 Sep 2010 16:37:50 +0000
Received: from [10.64.33.35] (10.64.33.35) by IXCA-HC1.ixiacom.com (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Thu, 9 Sep 2010 09:37:48 -0700
Message-ID: <4C890D5B.9050609@ixiacom.com>
Date: Thu, 09 Sep 2010 16:37:00 -0000
From: Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
MIME-Version: 1.0
To: <cygwin-patches@cygwin.com>
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx> <4C881565.7050705@ixiacom.com> <20100909075018.GW16534@calimero.vinschen.de>
In-Reply-To: <20100909075018.GW16534@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
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
X-SW-Source: 2010-q3/txt/msg00042.txt.bz2

On 09/09/2010 12:50 AM, Corinna Vinschen wrote:
> Apart from changing /etc/fstab or /etc/fstab.d/$USER by some installer
> script, why not just add a one-liner profile script along the lines of
> 
>  /etc/profile.d/tmp-mnt.sh:
> 
>    mount -f `cygpath -m "${TEMP}"` /tmp

That's a pretty good idea.

Some differences I can think of:

a. I suspect this will only be executed by an interactive shell (or one
   with the right triggering command line options).

b. Other shells (eg tcsh) might have other ideas.

c. It won't be successful if the first invoked program is not a shell.


I also believe that bash(1) complains if /tmp is not available. This
would occur prior to executing the mount. A minor issue.


We've used Cygwin for a long time and haven't had the need to
use an installer script in the past.

Admittedly issues with the mount table (way back from 19.1!) have
always caused some difficulty which we've muddled around, but
the recent behaviour with the automounting of /usr/bin and /usr/lib
with respect to the installation root is a great innovation which
has made all those problems simply go away.


Given that TMP and TEMP are standard Windows environment variables:

	http://technet.microsoft.com/en-us/library/ee156595.aspx

it seemed reasonable to have /tmp be equivalent as a default case.


This approach has a side-effect of personalizing the location
of temporary files because each user has a different setting for
TMP (and TEMP).


Earl
