Return-Path: <SRS0=4LBt=BD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id BE51B4BAD16A
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 09:47:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BE51B4BAD16A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BE51B4BAD16A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772531236; cv=none;
	b=dxXZ6tN3zPDKUZ0F4vr2qYjMVvol/NdlT/fkdgq5DH2x5gcmEJMwTD1+JP7T6jP9LuarZuDM4/E5luJKGN2WfI1Bk0d5s6DBfZ91TUAyhq5whxMu+zmhN5S3pwq2O9Ay0SUTQ2FeGDk2X4BTYSMH7qTWqioErJVrPsABxIxcAuQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772531236; c=relaxed/simple;
	bh=iS8sVtZXDJPS5Wjc9vpxJ04TwC4+xBBBul3rRKIiGIU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=bDaAlLA05WwlXAS2xdcYZXcfIhGAC+3ODsvDhjiwditeGPpeMasSHf7vrEqqJOSUelJ4w/ypa/nD1kUPGCB2ytILOYsHSuFxcbdP0iQ5l7gyskY1zXAOrRZgL1CMZ+O29fpxFyl4Q6QFNirqMZvlQDiTKViqvimnbmyUbq8SI3M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BE51B4BAD16A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=fwL3/N72
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 5BB331B73D1
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 09:47:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id D79D920024
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 09:47:14 +0000 (UTC)
Message-ID: <f1311732-9e95-40bd-8ea2-8fef88dab402@SystematicSW.ab.ca>
Date: Tue, 3 Mar 2026 02:47:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: Re: [PATCH v6 0/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 updates
Content-Language: en-CA
To: Cygwin core component patch submission and discussion
 <cygwin-patches@cygwin.com>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
Reply-To: Cygwin core component patch submission and discussion
 <cygwin-patches@cygwin.com>
Organization: Systematic Software
In-Reply-To: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: h898pohbxofkccngprhfq8nkqy64qhpb
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: D79D920024
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19F+DcIzmsI6sPmAHPOGC61AwyIxUO3poU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:subject:to:references:reply-to:in-reply-to:content-type:content-transfer-encoding; s=he; bh=DHqCBtPox5RiGa8HXTOJTeEOaBHig1j30dlkSeDNTgw=; b=fwL3/N72PYwS7+SDqP7+dPYWXAy7/HoccGxDfggW2GNW4ilJkScqElEVcjQn6MYU+65LY8wruW6eBzAIIeh35rOkYjXiyuCSRZUIda5Tw3MJucCGnKt9zJ9tOzYR3pIr8yRaTPoAcsvzO1svGJoFVekd+dc9rGIG3yFnMRTc/cYZUJX4yoVbHnsmyMbFUhJGU2p7YdvvAu2BT2MoHPUN0mXLiEYFe9IEJYh6FKA0BeiktEPAY2QxBvPAn+KIzRwH/8Yud+La/kdD4vSbG2xwwh3MIMpNT0e7Oos3ysYjbKAMAYCT/4yKoCnF2sykCIjbts0Syh8mdK2ccXn0LPKHcA==
X-HE-Tag: 1772531234-870668
X-HE-Meta: U2FsdGVkX1+KxHEQLWvGPYfvRD04tV6ZH1x78mx6/FyAywnKWrc363Z2k9q1IQC/wu3wer1Af4n3qFOMshL/431Ck08WggsXi3jnZxRZMDw29EZZL3stLm8gYljDPC5Jo0p6vIwVKeoApVGvQDzLNeAPabZtFE4LRrsMAozYsxaeNt8zOqhF6aHAS3e63qNl73eOOHsafr7SfqtntJzzH4cL1ITekm6cVND0MvHqxXjwoz1VJ1A3JsYn2GKiTZhTKQ2sERmCE/m4LmtlT5eIx+Lgv4XqbbZZ9hEfcxVhX7HWPa2kTIF2GY/UalhnD5C3wRvcgmgMrkqjQ2z9X7rcfiXXxjzwgffkcrDd91fMQmKSI4wisxyQ2zZLbGGqr73R65s25RJXxOn/65ZGjk8XznUNd55MEe4b
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-15 12:39, Brian Inglis wrote:
> Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 updates
> 
> Brian Inglis (8):
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 TOG Issue 8 ISO 9945 move new
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 new additions available
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 not implemented new additions
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 combine multiple notes
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 group variants with base
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 merge function variants on one line
>    Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 abbrev variants of base function
> 
>   winsup/doc/posix.xml | 1298 ++++++++++++++----------------------------
>   1 file changed, 427 insertions(+), 871 deletions(-)

ISO/IEC/IEEE 9945 Information technology — Portable Operating System Interface 
(POSIX®) Base Specifications, Issue 8

	https://www.iso.org/standard/91911.html

has been *APPROVED* and publication will occur within seven weeks! ;^>

	Publication date : 2026-03
	Stage : International Standard under publication [60.00]
	Edition : 2

Then we can remove the DIS suffix and replace with the offical edition.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
