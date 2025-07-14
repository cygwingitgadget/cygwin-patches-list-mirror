Return-Path: <SRS0=c0Hf=Z3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id B84FE3858C42
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 06:34:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B84FE3858C42
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B84FE3858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752474866; cv=none;
	b=dM8fUiK1LONTqI1gogYC5MP0eS+jOCG4jggswVgODTXE+LI1NKsHqbBV/yUAZZT8GJV0haReCGOIsBr4rYEn7rm+iOb2tntUo5XExl131zLrhUQDZHRatKki4zH8GdHP8HPpruz/4M7PnnbXrafAl7OIl01h/DB2eshWlJhN9VI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752474866; c=relaxed/simple;
	bh=GqYOjALlJaB817zX7vQ0ctMl/4qx/37h0BkFNGnRqTI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=tugBWffpqVJv3cW5s3cu9hiGeyTeJyOdqwb3pGRUZkuO7+uw9fQfDtTwRrJOEPVGUB7WUd3CtOt0PTdM9HQn6uK+DHIUorxeV6EkLYulqfKTHVNjjIffuhea5/EgYND3lMWfxOE9flk/Y/IR9r/i3qBzpTdvSFPCIZFS7MAn3Zk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B84FE3858C42
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=hBgwaqjl
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5DDD31604EB
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 06:34:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf14.hostedemail.com (Postfix) with ESMTPA id DFA7A30
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 06:34:23 +0000 (UTC)
Message-ID: <c2f6f66e-beb8-4a98-8365-ba19480d6a2a@SystematicSW.ab.ca>
Date: Mon, 14 Jul 2025 00:34:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] cygwin: faq-programming-6.21 ready-made download
 commands
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20250625013908.628-1-johnhaugabook@gmail.com>
 <20250625013908.628-3-johnhaugabook@gmail.com>
 <c8836ea2-2a1f-4225-8b79-bbe43bcc186b@dronecode.org.uk>
 <CAKrZaUssLPAzDPBmFQ_iC2WN=o1uEnoGsfKitC045S4H6unDZA@mail.gmail.com>
Organization: Systematic Software
In-Reply-To: <CAKrZaUssLPAzDPBmFQ_iC2WN=o1uEnoGsfKitC045S4H6unDZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: axxye13t455ef7a4qrkox8omz688egg7
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: DFA7A30
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19AcAJY8ZFM1Gyp9drSUScpZnE1srxxcOQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=SNeR9EcuYxmLaJURnCpcis8NsPDg+nBul3IMeEDPP1E=; b=hBgwaqjlZ3F4cI+W1p2EjLs0jj+6jiQGKMsRr4Q0bYc/0ntNhsRPpt205occM30NM8+wCFL7SRgIhC68/KlAIQJAd2wJhB4jvAktQEggpUpgT2uGtcfa2jIrcSTDJwjDgJPDYx0Y1/a77CXrmUQHLq8bO9sB2l5RdR4lDCVgsBwLQmr4YgCQuF6vnGbFr/drOlR0t10BYO0MC1f90T9/ZrfncuWO2ubc2H4HmCf0bWnVeBgRyHaIb0MjWqlSfHyYSg4X9etlmizTFna126Z0SGWIkK8KlOVyrV54WLs/riVtPdgigo1t0nNG3gsS85HYrIAOEwABYF6IaKekRRWZmA==
X-HE-Tag: 1752474863-482442
X-HE-Meta: U2FsdGVkX19bbV0KeuVk8hghIOKU2c03lnFfynNcUwIGh0rh+EVHpSOTTfzwfGRZfQ3R2mtfQ4dPHFxU+QaITJ1Am/yJZcJrZoxcuGHP9bVrJ0Tp3qXz9lBRenwE7rUCcR55fX9dMuwVU77Pa7ryBHhI+COVXIeesHzunsdKyNP+ZDPntRCXTDJ40ycJLNVG/kCDgoW5YxaSi59FiMRN8aXyKFad3VF5Tnv8D+WkKl1FvHLORpL2zqzXnNhqgOEKLaUMs1AjT5A9pi7hlnrFGIdPxIHv9jsASWIOPIx5LTwiACksTkV+7sGt+wBACcQuyL/cdHpsxMbZPnF0B7B0mscgQY+dFzQv60bIwqrogOcYZtojwC+zG5Vksbf+9XUD2YZ7T/rK6ntN3MnGTlUh7tB2XsgnxbmtVLfJV0MEiIS9Cl2uuyKlEw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-07-13 18:04, John Haugabook wrote:
> Yeah, but this seems like something I might be able to do. Like I'd
> have to study setup for a day or two before even knowing where to
> start, but as of now my guess is: if setup -q --some-option cygwin,
> then cygwin installs packages.
> 
> So something like --build-tools, --dumper-utilities,
> --cygwin-utilities, --documentation?
> For example:
> setup --build-tools cygwin
> then setup would rerun, and make a call using:
> `setup -q -P autoconf,automake,cocom,gcc-g++,git,libtool,make,patch,perl`
> If so, then can I get a clue as to where to begin?

Source package summary build-depends, for example:

$ lynx -dump -nolist https://cygwin.com/packages/summary/cygwin-src.html | \
	awk '/build-depends:/,/\):$/'
    build-depends:

    autoconf, automake, cocom, cygport, dblatex, dejagnu, docbook-xml45,
    docbook-xsl, docbook2X, gcc-g++, gettext-devel, libiconv,
    libiconv-devel, libzstd-devel, make, mingw64-x86_64-gcc-g++,
    mingw64-x86_64-zlib, patch, perl, python39-lxml, python39-ply,
    texlive-collection-fontsrecommended,
    texlive-collection-latexrecommended, texlive-collection-pictures,
    xmlto, zlib-devel

    install package(s):

or setup.ini cygwin build-depends, for example:

$ apt-cyg show cygwin | grep '^build-depends:\s' | sort -u
build-depends: autoconf, automake, cocom, cygport, dblatex, dejagnu, 
docbook-xml45, docbook-xsl, docbook2X, gcc-g++, gettext-devel, libiconv, 
libiconv-devel, libzstd-devel, make, mingw64-x86_64-gcc-g++, 
mingw64-x86_64-zlib, patch, perl, python39-lxml, python39-ply, 
texlive-collection-fontsrecommended, texlive-collection-latexrecommended, 
texlive-collection-pictures, xmlto, zlib-devel

or awk setup.ini equivalent.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
