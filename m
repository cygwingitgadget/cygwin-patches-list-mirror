Return-Path: <cygwin-patches-return-7080-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23256 invoked by alias); 8 Sep 2010 22:59:57 -0000
Received: (qmail 23243 invoked by uid 22791); 8 Sep 2010 22:59:56 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0	tests=AWL,BAYES_00,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from ixqw-mail-out.ixiacom.com (HELO ixqw-mail-out.ixiacom.com) (66.77.12.12)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 08 Sep 2010 22:59:52 +0000
Received: from [10.64.33.35] (10.64.33.35) by IXCA-HC1.ixiacom.com (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Wed, 8 Sep 2010 15:59:51 -0700
Message-ID: <4C881565.7050705@ixiacom.com>
Date: Wed, 08 Sep 2010 22:59:00 -0000
From: Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
MIME-Version: 1.0
To: <cygwin-patches@cygwin.com>
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx>
In-Reply-To: <20100908224108.GB13153@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q3/txt/msg00040.txt.bz2

On 08/09/2010 3:41 PM, Christopher Faylor wrote:
> Thanks for the patch but I don't think this is generally useful.  If you
> need to mount /tmp somewhere else then it should be fairly trivial to
> automatically update /etc/fstab.  Corinna may disagree, but I think we
> should keep the parsing of /etc/fstab as lean as possible; particularly
> when there are alternatives to modifying Cygwin to achieve the desired
> result.

Yes, I understand what you're saying.

In our situation, we prefer an out-of-the-box deployment. (We're
essentially trying to get to a "untar this and use it" state).

That said, I don't think it's possible for /etc/fstab to inspect
environment variables, so manipulation of /etc/fstab would
require the assistance of some other script to edit /etc/fstab on
the fly --- and even then it would be difficult to track changes
to the environment variables.

Thanks for the quick feedback.

Earl
