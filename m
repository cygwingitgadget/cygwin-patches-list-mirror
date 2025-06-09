Return-Path: <SRS0=6Xew=YY=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id 2FD1F3858D38;
	Mon,  9 Jun 2025 23:02:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2FD1F3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2FD1F3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749510177; cv=none;
	b=h5faVoD4b3zXZguO+7dIibrB+WxOiJhEwUBZMzaNzaDa451x9nJ/ko6nUZhW+6qD5DjkZ+pUSXRQHkCuofT//cyyQXVFQTuNDo6tTM8sv9Le23rG822jDCey52u+NVHVP22rVHIdd2WaUB1KYxFOoFHQEa0zaeTJMPxJGO6tfJo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749510177; c=relaxed/simple;
	bh=r3CBEOiSonuHK3FR7adWexKnxLuAFPFczVJ/+JHS2Ik=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=tCKesRHHIJv6MN6ibzoBjjhDKj2HBwmqw8P648fhAlojCNdVaJ6iKwmyEYM6Ne/akKHZUd5P3SvXqGc15xEW5gj4WXHvFHqURv1aKcXDnNQsH+ca62+2jxCvmztPVy9c/ekyRaarTBeDqdGKPjzeSdCclwX/207VW9CPHx29MKk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2FD1F3858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=aLnx9mla
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id BD9421D36BF;
	Mon,  9 Jun 2025 23:02:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 2CF0F20025;
	Mon,  9 Jun 2025 23:02:55 +0000 (UTC)
Message-ID: <019679e9-4a92-4425-97e7-67a4941624dc@SystematicSW.ab.ca>
Date: Mon, 9 Jun 2025 17:02:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-apps@cygwin.com
Subject: Re: Updated: w32api-{headers,runtime}
 mingw64-{headers,runtime,winpthreads} gendef 13.0.0-1
Content-Language: en-CA
To: cygwin-apps@cygwin.com
Cc: cygwin-patches@cygwin.com
References: <971dee8b-9df9-4aed-83b5-0d04afcb031c@gmail.com>
 <4f39b6ee-c8de-47f9-a48b-1bd0524eb987@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <4f39b6ee-c8de-47f9-a48b-1bd0524eb987@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CF0F20025
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 5hza73bzim686kp6xei1qjdcxqomtk6d
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18Hc2OtlG+Npz8456lF/1nSHLbyuX2RMwY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:cc:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=OSbHmCNKNc+enksKFiLN7hfmG8TY45ZrroQDpukvom8=; b=aLnx9mlaEIlBw75Aj5ayfR2N2N7KMKw9QI6dZo/52jEDZrWOSVJh7xHJDjRKZC6J4tcDEdTM9ZTeI5jQ5VV0wAyezlh72xNM93tHnoGpoH1eoTlH87i3AFTJru7i/McCWgQcXe+TC6YkklG9HSaSAdO9NbzBUKSB4bsR5sVwrLF6g2DlbSXkFRlJQ7vauwgHYJiazwtckCZuDWZzeW1B12pKhPML9Qk8cRDg9iaB9BdlnHQfvRKzP2nqfyMGXBg3g8ahzCwdxEF/naHMxrnviGEZl/DEeaGsCODVEMcojC52mKqC8aLwvxwDkSkTmVi3rMVBAEHaKnl24NzQGoczkg==
X-HE-Tag: 1749510175-309702
X-HE-Meta: U2FsdGVkX18CEsMxIUgzUQDNfnNm5nc1APxDYOSsWOAZNKATiKclRFvS/uBWS2MC0DHDCk9isaQ0Iq7A3SOiWHy0ddK4gRUrte2Ry5tK5r3WlWz5jOou1Rg4MYCQik/3P0qPwqlrkjWEMTPogPwZovCQbpYZ9MK9gHibPA5WpomeiS5gIIuSY9U4cTHHLjNHFFgwR+f67C9+K3KNiryVlj+JceJJcH2GEf94JhCTeucQPAPlmH+AO1KQNSLtNHoSYlbzxs/cFM3/q/+mQ9N1mpXyk75N7kRMS3O/d7OkeGfLamcPIN4cG5E2PFTRdPP0q0kUQLQXrWf/qEcolnFQVuhEm15Xrvq6R1EXoE3FQVMCNyrYfu+mbeSMEuN4ZxA3N/ZzQyiOl5PfPH+xVuGdGHnN7HJeLvxKulA5lUIv+wV0SUWIU+70mKwGM9wa1s+dhXCFgojUvhM=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-09 15:45, Brian Inglis via Cygwin-apps wrote:
> On 2025-06-08 06:04, Jonathan Yong via Cygwin-announce wrote:
>> Now released for both 32bit and 64bit Cygwin:
>>
>> Notable changes:
>> * Added import libraries for msvcr40d.dll, msvcrtd.dll, msvcr70d.dll, 
>> msvcr71d.dll, msvcr80d.dll, msvcr100d.dll, msvcr110d.dll.
>> * Better CRT API consistency between UCRT and MSVCRT, making many APIs 
>> available to earlier versions of the MSVCR* runtime as well.
>> * CRTDLL stat API fixes.
>> * Updated Hyper-V headers.
>> * Synchronized with Wine headers (from Wine 10.9).
>> * Many other new win32 APIs.
>> * Fix _atexit call differing between DLLs and EXEs.
>> * Basic support for ARM64EC targets (arm64ec-w64-mingw32).
>> * Make it possible to build winpthreads with MSVC and clang-cl.
>> * Many small fixes for gendef, genidl and genpeimg.
> 
> We have reports of failing Cygwin builds after this update:
> 
>      https://cygwin.com/pipermail/cygwin-patches/2025q2/013754.html

Caused by changing the definition type to cmsghdr:

https://github.com/mingw-w64/mingw-w64/commit/c3b5e71d54aa596bba9fb8ec7c1f9f712e7c616a

+	#if (_WIN32_WINNT >= 0x0600)
*	#define _WSACMSGHDR cmsghdr
+	#endif
+
	  typedef struct _WSACMSGHDR {
	    SIZE_T cmsg_len;
	    INT cmsg_level;
	    INT cmsg_type;More actions
	  } WSACMSGHDR,*PWSACMSGHDR,*LPWSACMSGHDR;

$ grep -A8 '^struct\s\+cmsghdr' /usr/include/cygwin/socket.h
struct cmsghdr
{
   /* Amazing but true: The type of cmsg_len should be socklen_t but, just
      as on Linux, the definition of the kernel is incompatible with this,
      so the Windows socket headers define cmsg_len as SIZE_T. */
   size_t		cmsg_len;	/* Length of cmsghdr + data	*/
   int			cmsg_level;	/* Protocol			*/
   int			cmsg_type;	/* Protocol type		*/
};

$ grep -w 'typedef.*ULONG_PTR' /usr/include/w32api/basetsd.h | head -3
   __MINGW_EXTENSION typedef unsigned __int64 ULONG_PTR,*PULONG_PTR;
   typedef unsigned long ULONG_PTR,*PULONG_PTR;
   __MINGW_EXTENSION typedef ULONG_PTR SIZE_T,*PSIZE_T;

> https://github.com/cygwin/cygwin/actions/ 
> runs/15537033468%C2%A0workflow%C2%A0started
> 
> https://github.com/cygwin/cygwin/actions/runs/15537033468/job/43738461428
> 
> Was this upgrade tested with a current Cygwin build before deployment?
-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
