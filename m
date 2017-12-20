Return-Path: <cygwin-patches-return-8981-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35718 invoked by alias); 20 Dec 2017 23:10:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35482 invoked by uid 89); 20 Dec 2017 23:10:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=PDF, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 20 Dec 2017 23:10:23 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 620FC550B0	for <cygwin-patches@cygwin.com>; Wed, 20 Dec 2017 23:10:22 +0000 (UTC)
Received: from [10.10.120.109] (ovpn-120-109.rdu2.redhat.com [10.10.120.109])	by smtp.corp.redhat.com (Postfix) with ESMTP id 206D05C2E5	for <cygwin-patches@cygwin.com>; Wed, 20 Dec 2017 23:10:21 +0000 (UTC)
Subject: Re: [PATCH] winsup/doc/etc.postinstall.cygwin-doc.sh fix shell variable typo
To: cygwin-patches@cygwin.com
References: <20171220230153.8512-1-Brian.Inglis@SystematicSW.ab.ca>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a3543fb-d85a-90c5-65f0-dedbaee5ad28@redhat.com>
Date: Wed, 20 Dec 2017 23:10:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171220230153.8512-1-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00111.txt.bz2

On 12/20/2017 05:01 PM, Brian Inglis wrote:
> ---
>   winsup/doc/etc.postinstall.cygwin-doc.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
> index 2873d9395..935bd94e1 100755
> --- a/winsup/doc/etc.postinstall.cygwin-doc.sh
> +++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
> @@ -52,7 +52,7 @@ fi
>   # create User Guide and API PDF and HTML shortcuts
>   while read target name desc
>   do
> -	[ -r $t ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -- $target
> +	[ -r $target ] && $mks $CYGWINFORALL -P -n "Cygwin/$name" -d "$desc" -- $target

Wrong.  Needs to be [ -r "$target" ] to be properly quoted.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
