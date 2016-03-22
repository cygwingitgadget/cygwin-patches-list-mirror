Return-Path: <cygwin-patches-return-8482-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124529 invoked by alias); 22 Mar 2016 01:49:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124354 invoked by uid 89); 22 Mar 2016 01:49:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*M:cygwin, HTo:U*cygwin-patches, person, H*Ad:U*yselkowitz
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 22 Mar 2016 01:49:31 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (Postfix) with ESMTPS id 4956A461EA	for <cygwin-patches@cygwin.com>; Tue, 22 Mar 2016 01:49:30 +0000 (UTC)
Received: from [10.10.116.34] (ovpn-116-34.rdu2.redhat.com [10.10.116.34])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u2M1nTOB026071	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 21:49:29 -0400
Subject: Re: [PATCH 4/5] Don't build utils/lsaauth when cross compiling.
To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-4-git-send-email-pefoley2@pefoley.com> <20160321193052.GG14892@calimero.vinschen.de> <CAOFdcFM-9XOAEPhSWbED_eiECu-UeWW2FBkg-u8jo40+0FwAjA@mail.gmail.com> <20160321195845.GL14892@calimero.vinschen.de> <CAOFdcFMJon17kNFhOVBccrrUJH0PmD6Vsf75FO9QTAv+qf_d0A@mail.gmail.com>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <56F0A4A9.7050305@cygwin.com>
Date: Tue, 22 Mar 2016 01:49:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CAOFdcFMJon17kNFhOVBccrrUJH0PmD6Vsf75FO9QTAv+qf_d0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00188.txt.bz2

On 2016-03-21 15:00, Peter Foley wrote:
> On Mon, Mar 21, 2016 at 3:58 PM, Corinna Vinschen wrote:
>> Again, I'm cross compiling all the time since I build Cygwin on Linux
>> for development and package building, and I'm certianly not the only
>> person doing that.  This is the default case.  Not building utils and
>> lsaauth is the exception.  Therefore this scenario should be handled
>> explicitely by a configure flag, not the other way around.
>
> Alright, I'll rework this patch to that effect.

I really don't see the point of this.  I maintain the pseudo-official 
cross toolchains for Cygwin, and I just remove what is not needed for 
cross-compiling from the DESTDIR after install.  This is also a fairly 
common step when building library packages for cross-compiler toolchains.

-- 
Yaakov
