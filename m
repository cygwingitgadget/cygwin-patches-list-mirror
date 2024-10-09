Return-Path: <SRS0=HouW=RF=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id 1B0823858433
	for <cygwin-patches@cygwin.com>; Wed,  9 Oct 2024 16:36:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B0823858433
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B0823858433
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728491768; cv=none;
	b=HuLy7kiEnGC2XD7Kv55NE/h5q4F7yc6WONUdNEXmk6q4LQrZoQUpHd+oVi5ypUE063m4N+G+wHwB8MJQXLDxoXACAzHJIV0nvKKf7vmhYYL07jDt/yHtCIH64SnTQVESz5BlsQPodkN6J1YO0ULUBHrs0vhitW/iZH9kmtzUaOc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728491768; c=relaxed/simple;
	bh=RMjJNg4hX9zguVVg3u+m6QFWHdjH8n23SREAguqXeCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=jtk2jprWZs/S/1dcR/qpHLN3FgajQa3YVGeQOqysnwKOW58hb/kKbezmr0BWy/jPhxdqiVc0EZeUV+mM4qdKzOkiifbqzKcQbX8kU23A5fFtuSr7uAmrXbBA5/YDLSoIYzhUoGqvIGqPRAmSqsFw7xhEGH+enI86jGjmyqEvs1w=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 5ADBF141302
	for <cygwin-patches@cygwin.com>; Wed,  9 Oct 2024 16:36:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf01.hostedemail.com (Postfix) with ESMTPA id F19526000C
	for <cygwin-patches@cygwin.com>; Wed,  9 Oct 2024 16:36:04 +0000 (UTC)
Message-ID: <2c0ac3ef-3fa6-41c9-b41d-51248762899d@SystematicSW.ab.ca>
Date: Wed, 9 Oct 2024 10:36:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Minor updates to load average calculations
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20241009051950.3170-1-mark@maxrnd.com>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Autocrypt: addr=Brian.Inglis@Shaw.ca; keydata=
 xjMEXopx9BYJKwYBBAHaRw8BAQdAPq8FIaW+Bz7xnfyJ1gHQyf2EZo5sAwSPy/bRAcLeWl/N
 I0JyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFNoYXcuY2E+wpYEExYIAD4WIQTG63sbl+cr
 2nyOuZiKvQKcH1E27wUCXopx9AIbAwUJCWYBgAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
 CRCKvQKcH1E276DmAP91Bt8kfJhKHYb9b2sao2fxwJFsl1GlRi516WKI0OkphQEA+ULITsPs
 blfzSq+GgI7q4LPfRfTLy4Oo3gorlnhnfgnOOAReinH0EgorBgEEAZdVAQUBAQdAepgIsLwm
 GQicfoIBaB9xHp63MQJqVCPbgPzESTg7EEwDAQgHwn0EGBYIACYWIQTG63sbl+cr2nyOuZiK
 vQKcH1E27wUCXopx9AIbDAUJCWYBgAAKCRCKvQKcH1E27+zoAP4u2ivMQBAqaMeLOilqRWgy
 nV2ATImz1p2v1H5P4kBiDwD3caPK1cxU5lijzuSDCjgtIpgF/avHbjA32fxJdIRwAA==
Organization: Systematic Software
In-Reply-To: <20241009051950.3170-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F19526000C
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: iq6mrx6uc9y4tjgiqqytzmkbhtejqyj6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19mu7/z8fuoEK1Tez3wjFmEdBi5A4mwWMk=
X-HE-Tag: 1728491764-766689
X-HE-Meta: U2FsdGVkX1+E1VWMeIstwbxDL+D6F+xybKyxwdwCGPLwkThRd3Gukc86TqYy3aqAuxYrWAaZpatxYx8iicsGS+eKO2b1nhgaZJOvNf2gQVzKZHQmzWrPcUF5NX5EvvouiC525cYAOJ+GiaDa534F1FL1ZQgGuRSbA32EEaQM1qzipJqX4oNmwERdiGKFeOODG54v3XONYzvX2mkIQnFIxfxr/b2n1UeQ7IPTaPDDdwE5ARBK/CINM6M99l7bgZrwdGOL7LpQVJ0aM9hwrS+I6ZAmFMDnBEiYs+2kEd38vgdOB03NuETCaec11hdpsHAHF6N1xADd3U0zoes4a7L5hhoIBiby9e52
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Clarity suggestions and questions that could perhaps benefit from more comment:

On 2024-10-08 23:19, Mark Geisert wrote:

>   winsup/cygwin/loadavg.cc | 55 ++++++++++++++++++++++++++++------------
>   1 file changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
> index 127591a2e..8e82b3cbd 100644
> --- a/winsup/cygwin/loadavg.cc
> +++ b/winsup/cygwin/loadavg.cc
> @@ -16,16 +16,23 @@

>     The number of running processes is estimated as (NumberOfProcessors) * (%
> -  Processor Time).  The number of runnable processes is estimated as
> -  ProcessorQueueLength.
> +  Processor Time).  The number of runnable threads is estimated as

This looks weird with arbitrary split then indentation; maybe move at least "(%" 
to next line, maybe also "*", or the whole expression, and maybe add semantic 
newlines after the sentences:

 >   The number of running processes is estimated as NumberOfProcessors *
 >   % Processor Time.  The number of runnable threads is estimated as

 >   The number of running processes is estimated as
 > 	NumberOfProcessors * % Processor Time.
 >   The number of runnable threads is estimated as
 >	ProcessorQueueLength / NumberOfProcessors.
 >   The instantaneous load ...

> +  (ProcessorQueueLength) / (NumberOfProcessors).  The "instantaneous" load
> +  estimate is taken to be the sum of those two numbers.

Which two are the values summed: running processes + runnable threads?

> @@ -62,31 +69,46 @@ static bool load_init (void)
  +    Sleep (15); /* let other procs run; multiple yield()s aren't enough */

Why so long - why not clock_/nanosleep for just a 16ms tick or even 1ms, as when 
system has 1ms multimedia timer ticks enabled by e.g. javascript or ntpd, or 
possibly set <1ms by some games? Effects on other processes may vary by version.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
