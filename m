Return-Path: <cygwin-patches-return-9202-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63204 invoked by alias); 19 Feb 2019 17:27:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63183 invoked by uid 89); 19 Feb 2019 17:27:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=principal
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 19 Feb 2019 17:27:39 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id DD907C610E	for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 17:27:37 +0000 (UTC)
Received: from [10.3.116.222] (ovpn-116-222.phx2.redhat.com [10.3.116.222])	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1C3E18669	for <cygwin-patches@cygwin.com>; Tue, 19 Feb 2019 17:27:37 +0000 (UTC)
Subject: Re: [PATCH] Cygwin: add secure_getenv
To: cygwin-patches@cygwin.com
References: <20190219050950.19116-1-yselkowi@redhat.com> <20190219114330.GK4256@calimero.vinschen.de> <20190219115910.GM4256@calimero.vinschen.de> <a31c3d43c9866900e7938015e2fed2c93712348e.camel@redhat.com> <b434e09b-94a5-c7af-db2f-3a9d2dfe991f@redhat.com> <20190219172128.GO4256@calimero.vinschen.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <20cd56a5-ed2f-27a6-5101-958e44353430@redhat.com>
Date: Tue, 19 Feb 2019 17:27:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190219172128.GO4256@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00012.txt.bz2

On 2/19/19 11:21 AM, Corinna Vinschen wrote:

>> That said, while it is ideal to avoid squashing to NULL in situations
>> that are not security boundaries (as with your STC displaying HOME even
>> after seteuid() on Linux), I'm also okay if we filter too aggressively
>> (the way gnulib's fallback implementation does when neither
>> __secure_getenv() nor issetugid() available).
> 
> In fact, gnulib's implementation would chose the
> 
>    if (issetugid ())
>      return NULL;
>    return getenv (name);
> 
> branch on Cygwin right now, just as on BSDs.  If that's the right thing
> to do for BSD, it's not... *really* wrong for Cygwin either, regardless
> what Linux is doing.
> 
> That in turn means Yaakov's patch is perfeclty fine since it's equivalent
> to the above gnulib code.
> 
> Agreed?

Yes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
