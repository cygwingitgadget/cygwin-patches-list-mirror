Return-Path: <SRS0=GbtA=HS=disroot.org=omikorin@sourceware.org>
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	by sourceware.org (Postfix) with ESMTPS id 314DF4BA79BE
	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2026 18:00:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 314DF4BA79BE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=disroot.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 314DF4BA79BE
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790445613; cv=none;
	b=ATuvB7XA7qOXMclnFhgd9roX5AJpzPk68kNxvaIzXtWDLShjZmEvj9K2DwpvkQR/L02pEMJdNnkdTxIZznsSFtOeiLDiqWPhUFqX9pj3QqVc1YGBf6njjtXmsHvRGThUZOccGVqHw3c7B0nq2u9CckFXM7xycFYwAu2wZlLgHkg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790445613; c=relaxed/simple;
	bh=7GS3ncK8RmHS6HZFCsWsjeD0aPdjRSCqxC+Ue7SAAL4=;
	h=DKIM-Signature:MIME-Version:Date:From:To:Subject:Message-ID; b=bHsLg/zuBe++k7PGsgsFVnWsaUu2fWjXAfOV8s3ILG7apbigZ7JnHBBoA48rF5e8oPTo+52unBGu6seZekW/gKgVdev8hCLfNCULDhX+0ZE883kqYj2A16bddlQ0Y7Baqzl+/wH+5nadtc/KUf9KJ2stIXFkxuhQ1ncHrNfBbpY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=d2QvSXLY
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 314DF4BA79BE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=d2QvSXLY
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A2F1680701
	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2026 20:00:11 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysUNTgGw9MDR for <cygwin-patches@cygwin.com>;
 Sat, 26 Sep 2026 20:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790445610; bh=7GS3ncK8RmHS6HZFCsWsjeD0aPdjRSCqxC+Ue7SAAL4=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=d2QvSXLY64MU05LeZ08roeF/7y5ZyH+OIcedg2uQkAxOHg2XVM5i1uCNYWkagTCUk
	 7NqpDBZivJ+zUkvYTN5aOso3vsyRSbSMlA3kXqJtnj8Gxa0KwAVrl90eFkELIuAVke
	 /MEZgZq+0XZFozIPIGnNx7NMSDOtdexj1dZ+kyrTBCsJGuFyUDmKIzk3CzKlL8e0sa
	 SsFnep/vXp1PZa5SYuMbCp9/0lR+nAWb+G3FWr+FYelidijd6lRNtKrDN9B5tCiNCp
	 OsIq8TDsmAjqNovbQt9Eox1KSpsLfpy0T9IPAEJ/PWrAqhqDBmQOsta95VZXweQC4r
	 LY2d3fPr0KN1Q==
MIME-Version: 1.0
Date: Sat, 26 Sep 2026 20:00:09 +0200
From: omikorin@disroot.org
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygwin: define IPTOS_DSCP_VA in netinet/ip.h
In-Reply-To: <c251f9bf-1881-47bd-a4a4-3a14b6f542f0@maxrnd.com>
References: <20260920043247.4589-1-omikorin@disroot.org>
 <c251f9bf-1881-47bd-a4a4-3a14b6f542f0@maxrnd.com>
Message-ID: <79fbb95bf37e309b0f235b89bbf8a2ff@disroot.org>
X-Sender: omikorin@disroot.org
Content-Type: multipart/alternative;
 boundary="=_9a9606c959a757fc7cc90b45e254cb9f"
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--=_9a9606c959a757fc7cc90b45e254cb9f
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Hello Mark,

Thank you for accepting the patch.

As I was fixing my issue, I have compared Cygwin ip.h code to the 
FreeBSD one [1] and I think it is slightly outdated for a few years.

I do not know if these files should be kept synchronized as this is my 
first contribution into Cygwin.
There were some additional deprecations years ago. I can only guess if 
it will end with more incompatibilites like presented in the patch.

Does it matter here? I am curious.

Michał

[1] https://cgit.freebsd.org/src/tree/sys/netinet/ip.h

On 2026-09-25 02:29, Mark Geisert wrote:

> Hello Michał,
> 
> On 9/19/2026 9:32 PM, Michał Korczak via Cygwin-patches wrote:
> 
>> Define IPTOS_DSCP_VA (0xb0) according to RFC 5865 to complete the DSCP
>> code point definitions in <netinet/ip.h>. This fixes compilation for
>> utilities like openbsd-netcat.
>> 
>> I provide this patch to the Cygwin sources under the 2-clause BSD 
>> license.
>> 
>> Signed-off-by: Michał Korczak <omikorin@disroot.org>
>> ---
>> v2: Fix whitespace formatting to match surrounding code style.
>> 
>> winsup/cygwin/include/netinet/ip.h | 1 +
>> 1 file changed, 1 insertion(+)
>> winsup/cygwin/include/netinet/ip.h | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/winsup/cygwin/include/netinet/ip.h 
>> b/winsup/cygwin/include/netinet/ip.h
>> index 5db1bd9ce..8b67a5c6e 100644
>> --- a/winsup/cygwin/include/netinet/ip.h
>> +++ b/winsup/cygwin/include/netinet/ip.h
>> @@ -83,7 +83,7 @@ struct ip {
>> #define IP_MAXPACKET    65535    /* maximum packet size */
>> /*
>> - * Definitions for DiffServ Codepoints as per RFC2474
>> + * Definitions for DiffServ Codepoints as per RFC2474 and RFC5865.
>> */
>> #define IPTOS_DSCP_CS0        0x00
>> #define IPTOS_DSCP_CS1        0x20
>> @@ -103,6 +103,7 @@ struct ip {
>> #define IPTOS_DSCP_AF42        0x90
>> #define IPTOS_DSCP_AF43        0x98
>> #define IPTOS_DSCP_CS5        0xa0
>> +#define IPTOS_DSCP_VA        0xb0
>> #define IPTOS_DSCP_EF        0xb8
>> #define IPTOS_DSCP_CS6        0xc0
>> #define IPTOS_DSCP_CS7        0xe0
> 
> Thank you for the v2 patch.  It looks good to me and will shortly be 
> added to the queue for 3.7.0.
> 
> ..mark
--=_9a9606c959a757fc7cc90b45e254cb9f--
