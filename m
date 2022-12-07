Return-Path: <SRS0=2vOY=4F=systematicsw.ab.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id E1903382CE0D
	for <cygwin-patches@cygwin.com>; Wed,  7 Dec 2022 01:39:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E1903382CE0D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTP
	id 2aGkpcUetMsxD2jPUp6nUT; Wed, 07 Dec 2022 01:39:44 +0000
Received: from [10.0.0.5] ([184.64.124.72])
	by cmsmtp with ESMTP
	id 2jPTpyuOOomIw2jPTpwz3y; Wed, 07 Dec 2022 01:39:44 +0000
X-Authority-Analysis: v=2.4 cv=LM91/ba9 c=1 sm=1 tr=0 ts=638feee0
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=wWxrkrgXVDeLx27K:21 a=IkcTkHD0fZMA:10 a=24AZYWMyAAAA:8 a=pZDQcMS7AAAA:8
 a=wECf3xPYAAAA:8 a=RDPWCpjeqOG6PyUTIioA:9 a=QEXdDO2ut3YA:10
 a=XVph6ibSE44aNfnlHGDp:22 a=bG88sKzkDEFeXWNnvthB:22 a=ASFzenCU2jlfK5-GQJ3J:22
 a=ccNonjl4-tybilS9-zgM:22
Message-ID: <b318c461-8f14-96ba-8594-9e945ca18a2e@SystematicSw.ab.ca>
Date: Tue, 6 Dec 2022 18:39:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] add a reference to the official SPDX License List
Content-Language: en-CA
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNvA/v7Pl9X3lJDkSYwtNtEIDAqEa3OrB4aeKX+4djw9Z6CuMaHY6wMmewpEm/hs4yqojUMfbvtiScVOONqR3z4Xr0a3lm21b/hOJYl5+ybrwIT4c+ST
 6HGcC1A60ftwr7kdXwfZNbxh85w2BVVG3dkLCjZhVbSl7mjmXQgnPoIpSlTBoWMueXnSpb+vR6lpLj6GlGAj1TxM8c6xWqBBJic=
X-Spam-Status: No, score=-1169.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,KAM_SHORT,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Spec link is already 404, so brittle, not necessarily current, and that licence 
list appendix is only informative and not current, so link to the actual current 
license list instead:

	https://spdx.org/licenses/

and provide a link to the generic current spec page which offers different formats:

	https://spdx.dev/specifications/#current-version

with something like (hacked from previous email):

diff --git a/packaging-hint-files.html b/packaging-hint-files.html
--- a/packaging-hint-files.html
+++ b/packaging-hint-files.html
@@ -406,7 +406,7 @@ version: <i>version</i>
      <p>
-      <code>license</code> is
-      a <a href="https://spdx.github.io/spdx-spec/SPDX-license-expressions/">SPDX
-      license expression</a> for the <a href="https://spdx.org/licenses/">open 
source license(s)</a> of the package
+      <a href="https://spdx.org/licenses/"><code>license</code></a> is an SPDX
+      <a href="https://spdx.dev/specifications/#current-version">license 
expression</a>
+      for the open source license(s)</a> of the package
        source code.
      </p>
    </li>

-- 
Take care. Thanks, Brian Inglis			Calgary, Alberta, Canada

La perfection est atteinte			Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter	not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer	but when there is no more to cut
			-- Antoine de Saint-Exupéry
