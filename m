Return-Path: <SRS0=+GwH=37=m.gmane-mx.org=gocp-cygwin-patches@sourceware.org>
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	by sourceware.org (Postfix) with ESMTPS id 98A843858C51
	for <cygwin-patches@cygwin.com>; Sat, 20 Sep 2025 17:20:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 98A843858C51
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=m.gmane-mx.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 98A843858C51
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=116.202.254.214
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758388803; cv=none;
	b=KfRY8QUYhD6qqYosrp8ZRzWOXuAfsk4PC6GZu1voDYSghTADa5xw9dSRowQxMeWhiCWQwWMqL/SHOtx/Nd3xUXSMcUelwWmMG441544389xWBbybjKrSNrDFL0Pw3OHTE1akbWNyvSJe2wMmb5mHQ9osl8aYZz5AvELSZMSrlds=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758388803; c=relaxed/simple;
	bh=ysDlUq485eQYzuValAG0Gj5olNtpqsjYBDiNkDzlhMg=;
	h=To:From:Subject:Date:Message-ID:Mime-Version; b=lr7YzgYcLN9OrEXvq4Zev1wWwBX0doBhNQ38BJdMg1qWbomNapBlsH5ArYhDswiQWRpt7dlxycZh/EUkWCkxLiHkUiUSyJkPWNL8HjQAi8mU0cv2nn3iqAMoBbscocVJsRY6lFZfJ4aiMLScYOaiTDbiH6bkQKBGP5qPdzkdKLU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 98A843858C51
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gocp-cygwin-patches@m.gmane-mx.org>)
	id 1v01Fi-0002C2-9g
	for cygwin-patches@cygwin.com; Sat, 20 Sep 2025 19:20:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: cygwin-patches@cygwin.com
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3
 cpuinfo
Date: Fri, 12 May 2023 16:36:52 +0100
Message-ID: <0a50e9ad-59c8-65e9-95f5-f53843fbf918@dronecode.org.uk>
References: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-GB
In-Reply-To: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>
Message-ID: <20230512153652.giivpQTiixCl1SPbzV9CyX9dqjF2f0jHIH0g_gt-wFk@z>

On 08/05/2023 04:12, Brian Inglis wrote:
> cpuid    0x00000007:0 ecx:7 shstk Shadow Stack support & Windows [20]20H1/[20]2004+
> 		    => user_shstk User mode program Shadow Stack support
> AMD SVM  0x8000000a:0 edx:25 vnmi virtual Non-Maskable Interrrupts
> Sync AMD 0x80000008:0 ebx flags across two output locations

Thanks.  I applied this.

Does this need applying to the 3.4 branch as well?

> ---
>   winsup/cygwin/fhandler/proc.cc | 29 ++++++++++++++++++++++-------

>   
> +      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
> +      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
> +					 && wincap.build_number () >= 19041)
> +        {
> +	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
> +	  ftcprint (features1,  7, "user_shstk");	/* "user shadow stack" */
> +	}
> +

This seems a little odd and maybe worthy of a comment, as surely the CPU 
has the capability irrespective of the OS?


