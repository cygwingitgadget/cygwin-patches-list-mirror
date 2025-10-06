Return-Path: <SRS0=hQTB=4P=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by sourceware.org (Postfix) with ESMTPS id E8C4B3858CD1
	for <cygwin-patches@cygwin.com>; Mon,  6 Oct 2025 21:27:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E8C4B3858CD1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E8C4B3858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1759786028; cv=none;
	b=Sj+RmHm9oboPR0JNg2+lCFWxPAz9vBZUtcGjUVScmtpMcKMm1S3llOjodEq+dA333XDUxLL4IHC98V8pu+TUtzQk7ys2GaJ1ovaWA2eL5dunSWRTC5sp6u94z/2nnqaYbxIqAtZdoqrFqLZUwC3O7PHzrHlGtK2qMgEPQr+4eV8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1759786028; c=relaxed/simple;
	bh=K4A+GMzB7mdYqmP/YVfSMXCfHnDz5o86d9vCV1oY3Jc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=c1MbSdchcwqKYL4XCqPWG+ARSgGkhIpaYVXRcYu4xr3ARnIrhTy5AKtYL9vxe7QnCjzAfNucytvcqylYsCFFSmsnxL8UYkbHw172WeTS6ZDance9W/zUYTVlS/7kJt+TbUcIqzXYat9o51abd2ZSo+od48X7KpWS/NbIOSK1cNU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E8C4B3858CD1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=JIVvuU0X
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 818811A06B8
	for <cygwin-patches@cygwin.com>; Mon,  6 Oct 2025 21:27:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id 06D3620024
	for <cygwin-patches@cygwin.com>; Mon,  6 Oct 2025 21:27:05 +0000 (UTC)
Message-ID: <760f8b52-6d4f-48dc-85e1-85c50fec1a96@SystematicSW.ab.ca>
Date: Mon, 6 Oct 2025 15:27:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PING][PATCH] Check if gawk is available in gentls_offsets script
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <CABd5JDD5zgqLG7yD6_gomaKKNABWEnh8pRjobPd43X4b=cz6bw@mail.gmail.com>
Organization: Systematic Software
In-Reply-To: <CABd5JDD5zgqLG7yD6_gomaKKNABWEnh8pRjobPd43X4b=cz6bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06D3620024
X-Stat-Signature: yra3jbun7hoatg9wiegryqgtn4kujf4j
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+TA+xAAR7jJ1WLbQ0EHRPJcmnCDQAc0QE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=QCu4/XpvlVM0bCnoajIZbe8ckpQuE8Ru8+vUQ00VU18=; b=JIVvuU0XDp1ptRRKpvAey3qy7fpbyIh+qvGtu/qgJvYDUlEPGjNECMNR3Uapkg+zhOX6Q29MGl3g9Tce4Nwp2SdGcz27PWxd6ioFUs93ba4QAg9oQJcTJanELF/KJyc2Yd3GRX8fQ0It54nfKFuRdIM4ji1rSZKnh+k0mJ4LmmCnqYdMk1nbmHNLnqGoVZ1RFLvhSHU0byX4tPz+nrrOZycxlu2Y3pgKuegeuR2OHzQfLdRiyXi8la2N5hmfZG8SSGolE87xv04j/7Ut/Ut7emYXoItYRnuGYqt0HKTsloXjyNVttAFqffhIm+TWgxsUS0q5cvAxA18mQhON3iYRSA==
X-HE-Tag: 1759786025-853498
X-HE-Meta: U2FsdGVkX1+9JS6Q1I7S5bgmE9NXxvWxYldywrioLmaZ5bVNYbbcEPAYp+1YXZV98f4ylgO00k4Byyec5eUB18iuRhRKzMbKSyjKNjC0rTBVmls6BJaQZeZ754srQBOI1PzMoNrBt7LeWaZtznYnpI/nNk79bqdAMUQ4WfB/FersPBqY66scJfthVoUt0v/XaHy+SZVhjjopAqgseBeI8OJG00tDMoQYidTX0RjKOkOQ1qIUD2hMu7xc55u9Ub+xXaLLJwwjT1WV1lBeX07is/ACyLPayFa3J7pRtL2+30Ca3wn9yMcDuCqh5EIhFguuK+/Klg2cId6ItS8IJBWEBgblCAQ9ckBUmbeCPR/0UU6H1YBh8WMTdv2u7bIY1Ujm266RUCCW8N28bAZs2ne0aPSHAXEcWiZWwpaMrcQvx7ZXhvGDG14rIQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-10-06 11:50, Evgeny Karpov wrote:
> A gentle reminder to review the patch.
> https://cygwin.com/pipermail/cygwin-patches/2025q3/014306.html
As gawk is a Cygwin Base category package, it should be one of the first 
packages installed on all Cygwin systems, so the test should not be necessary, 
unless /usr/bin is not in the PATH: a message to that effect might be more 
useful; for example:

if ! command -v gawk &> /dev/null; then
   echo "${0##*/}: gawk: command not found in PATH=$PATH." >&2
   exit 127	# command not found
fi

It might also be useful to:
- check for $CXXCOMPILE available;
- near the bottom, change `awk` to `gawk` for consistency as it has been checked;
- if context is not aligned, return the original value if context % 16 -ne 0;
- and maybe leave the output file around as evidence of an issue;
for example:

MOD=$(gawk '/_cygtls.context_p/{ print $3 % 16 ? $3 : 0; }' "${output_file}")
if [ $MOD -ne 0 ]
then
   echo "${0##*/}: $output_file: _cygtls.context: $MOD: not 16 byte aligned"
# /bin/rm -f "${output_file}"	# should we remove the evidence?
   exit 1
fi

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
