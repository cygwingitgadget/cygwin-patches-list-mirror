Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta001.cacentral1.a.cloudfilter.net
 (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
 by sourceware.org (Postfix) with ESMTPS id 015D83858403
 for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2022 04:38:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 015D83858403
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
 by cmsmtp with ESMTP
 id 8UrXnYepb5Rf18apTnJcR4; Sat, 15 Jan 2022 04:38:15 +0000
Received: from [192.168.1.105] ([68.147.0.90]) by cmsmtp with ESMTP
 id 8apTnG7itNat48apTnB1VG; Sat, 15 Jan 2022 04:38:15 +0000
X-Authority-Analysis: v=2.4 cv=e9cV9Il/ c=1 sm=1 tr=0 ts=61e24fb7
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=IkcTkHD0fZMA:10 a=94nOnFI1EgyDtX4ev68A:9 a=QEXdDO2ut3YA:10
Message-ID: <e79bbaae-e146-e4ad-b16b-0563c7768c33@SystematicSw.ab.ca>
Date: Fri, 14 Jan 2022 21:38:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/7] Use matching format for NTSTATUS
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
 <20220114221018.43941-3-lavr@ncbi.nlm.nih.gov>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
In-Reply-To: <20220114221018.43941-3-lavr@ncbi.nlm.nih.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOZ0gWOuxhM4xQzBwV3W0KqkUgXcF4tmDerfFNGYzZOnrxMFN83c7EHqLlR1ySNjVJfRva82oVLa/mLb/KfMLa+6b6vMwcFmsbg/in1QhRedMxyfSPZE
 SxjiayVd6TMJNYXJoute16FNVgC57uadGLNSUYGZs+Uy+Fmvk6QPqIJv9qIgYLu8SPfIujXwpNOP6RxNoSmZMAj7A2nEh2LOqDE=
X-Spam-Status: No, score=-1169.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 15 Jan 2022 04:38:17 -0000

See fprintf(3p) POSIX:
#   Specifies that the value is to be converted to an alternative form.
...
     For x or X  conversion  specifiers, a non-zero result shall have 0x 
(or 0X) prefixed to it.

On 2022-01-14 15:10, Anton Lavrentiev via Cygwin-patches wrote:
> ---
>   winsup/cygwin/libc/minires-os-if.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/libc/minires-os-if.c b/winsup/cygwin/libc/minires-os-if.c
> index 666a008de..6e17de0b8 100644
> --- a/winsup/cygwin/libc/minires-os-if.c
> +++ b/winsup/cygwin/libc/minires-os-if.c
> @@ -359,7 +359,7 @@ static void get_registry_dns(res_state statp)
>     status = RtlCheckRegistryKey (RTL_REGISTRY_SERVICES, keyName);
>     if (!NT_SUCCESS (status))
>       {
> -      DPRINTF (statp->options & RES_DEBUG, "RtlCheckRegistryKey: status %p\n",
> +      DPRINTF (statp->options & RES_DEBUG, "RtlCheckRegistryKey: status 0x%08X\n",
          DPRINTF (statp->options & RES_DEBUG, "RtlCheckRegistryKey: 
status %#08x\n",
>   	       status);
>         return;
>       }
> @@ -381,7 +381,7 @@ static void get_registry_dns(res_state statp)
>     if (!NT_SUCCESS (status))
>       {
>         DPRINTF (statp->options & RES_DEBUG,
> -	       "RtlQueryRegistryValues: status %p\n", status);
> +	       "RtlQueryRegistryValues: status 0x%08x\n", status);
    	       "RtlQueryRegistryValues: status %#08x\n", status);
>         return;
>       }

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
