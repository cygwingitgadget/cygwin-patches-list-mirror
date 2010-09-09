Return-Path: <cygwin-patches-return-7084-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26440 invoked by alias); 9 Sep 2010 20:53:38 -0000
Received: (qmail 26424 invoked by uid 22791); 9 Sep 2010 20:53:36 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0	tests=AWL,BAYES_00,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from ixqw-mail-out.ixiacom.com (HELO ixqw-mail-out.ixiacom.com) (66.77.12.12)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 09 Sep 2010 20:53:31 +0000
Received: from [10.64.33.35] (10.64.33.35) by IXCA-HC1.ixiacom.com (10.200.2.55) with Microsoft SMTP Server (TLS) id 8.1.358.0; Thu, 9 Sep 2010 13:53:30 -0700
Message-ID: <4C894949.4050908@ixiacom.com>
Date: Thu, 09 Sep 2010 20:53:00 -0000
From: Earl Chew <echew@ixiacom.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.9) Gecko/20100825 Thunderbird/3.1.3
MIME-Version: 1.0
To: <cygwin-patches@cygwin.com>
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx> <4C893D9C.6040406@gmail.com>
In-Reply-To: <4C893D9C.6040406@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00044.txt.bz2

On 09/09/2010 1:03 PM, Dave Korn wrote:
>> but I think we
>> should keep the parsing of /etc/fstab as lean as possible; 
> 
>   I don't understand why.  How many times per second does /etc/fstab get parsed?

I interpreted cgf's comment as not wishing to add to the amount of coupling
with /etc/fstab.

/etc/fstab is already parsed for /usr/bin and /usr/lib, so in my mind
the additional query for /tmp doesn't seem to add significantly.

Earl
