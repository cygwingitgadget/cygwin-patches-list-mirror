Return-Path: <SRS0=puQu=DB=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.0])
	by sourceware.org (Postfix) with ESMTP id 7FD1C4BA2E14
	for <cygwin-patches@cygwin.com>; Mon,  4 May 2026 18:51:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7FD1C4BA2E14
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7FD1C4BA2E14
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.0
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1777920697; cv=none;
	b=J91lK2Tanbm0bWItg3PTF6ceYDG4fkBHH9IxwSHxp7/CXTq1NW0qiWp7Q0JEO7Q2PJ6gSqi0WGtp3wk9zAdCmWaLN4XGYehXE9BmESm/uDVgF8XJvSjJpzlHHOWGhsFVOuk6HuPU5RHRRsSk87bGlZOJjzG08yV5hjU3VGJLExw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1777920697; c=relaxed/simple;
	bh=1RrIyX6lF+5Qq2U85uEnuVyElD/qq8MBxNvKDw2dEJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=O7e9psTV5or4PS8pplOUjDlUxSZ4rLDHqH8KyI84+XOxwOpE5JeqrsbFTWiWVqNtn3c14k7KcLCQZwhF9cteb00kZJIKiNgd/uPlLC6rP5jiKt6CK4KkBY9W8kj5T8KdHyxRMvm2XVceZTLrGx2NLwTH7pp1F290qtzoMnqbQyc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7FD1C4BA2E14
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69E78BBA011125F2
X-Originating-IP: [90.249.142.63]
X-OWM-Source-IP: 90.249.142.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEDEiz62PHFOV3t5mmkMcyADCI/tTRSqlsiyKh8YBXtVIffBt0YmV/TK7HZDiHcR+/bQMcs27OfSWSEpUpDyQY6mDwzWSoMdSYyfLv8MD2hSKayvyKv7yjuxF1DnmOLElCYYNZGEmNMOHxrqur7XEiRafHNtdXAjbk3D8aI430urjXd8awqaR5CAB2ZTFdABYWLbT9GuSdSP7aviJDvZmfoDY4JCtHxAEOu67jm+VitJXGtNuFxyyyNtScLkE0Ytt/BsYK/jr+FPwnig2rMG1QfgdZ0UcJtzIclwJvkHdGunz4rR/zaRdc/C+oF1jBicGUSaAqhpHxv36lYPAk5MOBveNcDnqSu3ZasEB1e5ELNnv8Sg2nwlcM42HZhNdh5ek5GEeHDb8h+bl8icoXkgjnf1Ho87JAmn1Hat8TY/fx2uIKBASfzmUsygbq7v0cCvekMuJx1Kl3wqA2EWWzGlraLkvuI5c2iMKn/AgdczT8Mxz7JvA/MTH6XVyaZcLU3a1tJKHAkNDC+J0OYftSkiXGCqH/pEwsjL4FVWF2DrOF8GvTK6slLwFZpOYPzX4DuhaSJY8vCUfgR/tvup3bnBwEHKWTzrZxC2b8DYiPbXus2nraERmC4rlYKLMYXbQhkseEqPuHEKxgVNpcKpCn6CGp+sUZqQMgMUNHU54HVmb6mFQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (90.249.142.63) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E78BBA011125F2; Mon, 4 May 2026 19:51:35 +0100
Message-ID: <594e972d-96c1-4b9c-8e72-b567a48e5a4e@dronecode.org.uk>
Date: Mon, 4 May 2026 19:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] cygwin-htdocs: website fresh coat of paint
To: John Haugabook <johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
 <20260419052701.513-8-johnhaugabook@gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260419052701.513-8-johnhaugabook@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_ASCII_DIVIDERS,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 19/04/2026 06:26, John Haugabook wrote:
> Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
> ---
>   style.css | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/style.css b/style.css
> index 5e815292..abf6b8bb 100644
> --- a/style.css
> +++ b/style.css
> @@ -338,6 +338,40 @@ ul.compact li
>       color: goldenrod;
>   }
>   
> +/* code and code-block styles -------------------------------------------- */
> +
> +code
> +{
> +  background-color: #80a0a020; /* same color as menu with 20% opacity */
> +  border-radius: 2px;
> +  padding: 0px 3px;
> +}
> +
> +/* quickly identify code */
> +pre.example, pre.screen
> +{
> +  padding: 20px;
> +  line-height: 1.25;
> +}
> +
> +pre.example, pre.screen
> +{
> +  background-color: #80a0a020; /* same color as menu with 20% opacity */
> +}
> +

I there some reason why these apparently identical selectors can't be 
merged together?

> +/* link in code */
> +a > code
> +{
> +  font-weight: bold;
> +  font-size-adjust:.56;
> +}
> +
> +/* code elements in dark table background */
> +table tr:nth-of-type(odd) td p code
> +{
> +  background-color: white;
> +}
> +
>   /* pkglist related ------------------------------------------------------- */
>   
>   /*

