Return-Path: <SRS0=POI0=YV=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 99A9A385AC36
	for <cygwin-patches@cygwin.com>; Fri,  6 Jun 2025 17:05:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 99A9A385AC36
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 99A9A385AC36
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749229544; cv=none;
	b=bUbotyrHS19J3ghai8TF2u/J2JSrVmVbSgqHSWZqGI0c6erkOni3fErZIuia5bb9KBcUVNHeyKWHrjBEx2lR6SjZKbymqPFESCGf/k1UsaHn0dmMCdB/JuMrymtTxZVMx61tE5jZmgqrlBBwkNrdcsZXsWO3QoTRmmTnhdeL+9A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749229544; c=relaxed/simple;
	bh=Bez36py4IGHZIEDYpKu2jYG94+LX9g6m+hy5/PCtIxU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=XnakdBDFhYvB7Ufd4QP78P30O2SbtgpFbP92md1cg3+04KDIVU7smAQ+aFngGiWuDln2K03CBK+HWKXFk/uHlfFemTQm14giZwstKtMITv+q9piNzQgJpHwVN1D8cAqQymUf4e35j6/RugVf86735Emvq8kdjW+v1aVgKL4vpa8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 99A9A385AC36
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=tzTViNHV
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2B1BBEBBF5
	for <cygwin-patches@cygwin.com>; Fri,  6 Jun 2025 17:05:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id B752F2002B
	for <cygwin-patches@cygwin.com>; Fri,  6 Jun 2025 17:05:41 +0000 (UTC)
Message-ID: <79bde4c8-658b-438d-9c40-202e03ef23ba@SystematicSW.ab.ca>
Date: Fri, 6 Jun 2025 11:05:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: Website Suggestions
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <CAKrZaUst28O+9Z6TBbQU0Ha3o9ZSRPzGYbpb7NiQ+1cmsUiT2Q@mail.gmail.com>
Organization: Systematic Software
In-Reply-To: <CAKrZaUst28O+9Z6TBbQU0Ha3o9ZSRPzGYbpb7NiQ+1cmsUiT2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B752F2002B
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: xk8jx5zqtyx8shwqb1b7tba9g41qxbzx
X-Rspamd-Server: rspamout06
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/84YyQu1SwFJDZYDHIOBlP9NoA6aHKs7g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=O2DIlwdm859W0BaGl8hrkc6nAmLm8MS0s1fSlI07okU=; b=tzTViNHVdymsjRNt+VIMP5s8rYwWCriAR/+qPelsbv3j7xU43Xl9agHxRKkCYNjgblut+MOm9HVAs/YKMZmQNZlUf7bjnsECjNymLTp2OgkCBIdEING5nxCps3X/euj4L/KG7Al5hSFDZN59sFSMpOcwkSIdNFEsp7MudO4VrEsUCLebulGphluJ0dgfSOSJAJMfoKwP+JhuNpievCTnY5X2G4eSFqaef+Z96vWhJN4cGem1BYNtCTJSckMWNa4g505ivO72kCsr94LezFcB+e60S5xFE1dvBhVTiQZo7sPcGR/Z/ZIDX3p134ueSC+GgvTr7Um8gX95QTUw94x1vg==
X-HE-Tag: 1749229541-456252
X-HE-Meta: U2FsdGVkX185GZ3rP04bWZohpA96/7Bu/pAtUCdXhCLk+IjvPp1clw3xtbuYSli6oRp3nZG06G5W87HKsiaMvkGFebubj9Gsel/JgRqyEdP1JygKpGdTzlPdxtLYjQ9/iq+tknaed+UQhrM6M8MkmEhacI+TZW8ucFs5vjLrxNmyW+Yuj9DEfnZJ+B73LG0aKZ30kVNUwe4pUQdRNEJkO8aBxOo1XqfTlxBa2nRAUJHMjBUKstA59S5KUA6nLwBq90mIAyEI4gOsHKPv+ILWBmHHunUMo70uceC4uB1ML7PyG58CpwhG5+7bAxSL2tn37G362o4xEqdD4B7D+blg0dQGrHMYHXoVfDywjEB0mOKaUUWwwAnCXFqxno0wlShh3pqRlzrZzxeP369KbPcPqw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-05 19:50, John Haugabook wrote:
> I made a few small edits to the website, and included the patch as an
> attachment. Below are the changes:
>   - Changed links to template elements to absolute, using "/" before the page.
>   - Included template elements in nested pages.
>   - Made an edit to "Install.html".
>   - In style.css edited elements for better UX, and edited comment
> markers for consistency, ending at col 78 for comments marking style
> section.
> 
> I wasn’t sure where website suggestions should be sent — this list
> seemed most appropriate, given its name. If there’s a better place or
> process to submit patches like this, please feel free to redirect me.
Rather than the *generated* HTML you sent many of your patches against, you will 
have to redo many of your changes against the applicable source repos below, 
build Cygwin and docs to check the appropriate contents are generated and 
appear, then format and send the patches from the commits against each of the 
source repos, either as separate individual patches, or a series of *related* 
patches against each repo.

Send git-format-patch output against current:

	https://cygwin.com/git/cygwin-htdocs.git

sources using git-send-email so they can be reviewed and applied with git-am.

Most other website and doc package contents are generated from DocBook XML:

	https://cygwin.com/git/?p=newlib-cygwin.git;f=winsup/doc;a=tree

sources in the above repo: note all the includes of other, sometimes generated, 
XML files, most of which are generated from embedded API comments in function 
sources:

	https://cygwin.com/git/?p=newlib-cygwin.git;f=winsup/cygwin;a=tree

	https://cygwin.com/git/?p=newlib-cygwin.git;f=newlib/libc;a=tree

	https://cygwin.com/git/?p=newlib-cygwin.git;f=newlib/libm;a=tree

in DocBook XML and other doc formats, and which should be sent using the same 
process; except all Newlib changes should be sent to the newlib sourceware 
mailing list rather than the cygwin patches mailing list.

> Totally understand if the changes are rejected or revised. Thank you
> for maintaining the project and reviewing contributions.
To generate the API info and man pages, you can change into the newlib directory 
and:
	$ make info man

	$ make install-info install-man

I have no idea what the process is to deploy the generated HTML files into the 
cygwin-htdocs tree, unless it may just be the presence of a parallel repo during 
the build, and/or scripts run from one or the other, or the infrastructure.

It would be useful if we could be pointed to docs on how to reproduce the web 
site locally.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
