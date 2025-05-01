Return-Path: <SRS0=TXtc=XR=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id 69DEB3858406
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 11:55:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 69DEB3858406
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 69DEB3858406
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746100544; cv=none;
	b=eUlZP6j7aG3xcOItcVCJKJCetgUAYzH+jU785gJ8VBh1FhtFQluB6eHeWZqdwnGqe2ljrUwI0Rza8pJpKJdiiT+/N2OwzzyrguuM/G0QTAh1Z/ZZL+q7Z/WO48mSMDUsnc7FyRaX3Pplrq0teSR6PUx6YMP1UdBt+6Cs/0JpWGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746100544; c=relaxed/simple;
	bh=m3HBWLET+8dIn7gp180s/W21QVoT4coE+Xfkf565cL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=j/5QpX7xCyuCn6epsXEbkA7Yf6IGf4IgPwTWoshGSVCCwmoVP0JAJAArng/kFTXeJFh51IOan+3OZTGwC/hNyUy8wmeQsShCyfHgDbGVjfC0Eq1G4N8GtVz4tfAUfjZ+UBt/8hB9bk4UNdHeYVQh4dliZ916gaXtYh91JJyJHZg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 69DEB3858406
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 67D89D9E0533C2C1
X-Originating-IP: [86.140.194.111]
X-OWM-Source-IP: 86.140.194.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieelhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefggefhvddvieejtedtgfelteffteeftdeugfefveehtdehgfffleeftefhvdelffenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudegtddrudelgedrudduudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkeeirddugedtrdduleegrdduuddupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleegqdduuddurdhrrghnghgvkeeiqddugedtrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdekpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghs
	segthihgfihinhdrtghomhdprhgtphhtthhopegthihgfihinhesjhgurhgrkhgvrdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.194.111) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89D9E0533C2C1; Thu, 1 May 2025 12:55:42 +0100
Message-ID: <69d84bb5-fdfd-47a2-aea7-dccdf5ac2414@dronecode.org.uk>
Date: Thu, 1 May 2025 12:55:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: cygwin_conv_path: don't write to `to` before size
 is validated.
To: Jeremy Drake <cygwin@jdrake.com>
References: <bd0e9cdd-ba1f-423b-089c-7f84e5e8bb3f@jdrake.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <bd0e9cdd-ba1f-423b-089c-7f84e5e8bb3f@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 29/04/2025 18:42, Jeremy Drake via Cygwin-patches wrote:
> In the CCP_POSIX_TO_WIN_W path, when `from` is a device,
> cygwin_conv_path would attempt to write to the `to` buffer before the
> validation of the `size`.  This resulted in an EFAULT error in the
> common use-case of passing `to` as NULL and `size` as 0 to get the
> required size of `to` for the conversion (as used in

This is clearly not what's wanted! Thanks for fixing this!

> cygwin_create_path).  Instead, set a boolean and write to `to`
> after validation.
> 
> Fixes: 43f65cdd7dae ("* Makefile.in (DLL_OFILES): Add fhandler_procsys.o.")
> Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258068.html
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>   winsup/cygwin/path.cc       | 5 ++++-
>   winsup/cygwin/release/3.6.2 | 3 +++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 7a08e978ad..d26f99ee7f 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -3911,6 +3911,7 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
>     int how = what & CCP_CONVFLAGS_MASK;
>     what &= CCP_CONVTYPE_MASK;
>     int ret = -1;
> +  bool prependglobalroot = false;
> 
>     __try
>       {
> @@ -4019,7 +4020,7 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
>   	    {
>   	      /* Device name points to somewhere else in the NT namespace.
>   		 Use GLOBALROOT prefix to convert to Win32 path. */
> -	      to = (void *) wcpcpy ((wchar_t *) to, ro_u_globalroot.Buffer);
> +	      prependglobalroot = true;

It seems like this could all be done in-place in .Buffer here, but I'm 
going to defer to Corinna on if that's at all clearer...

>   	      lsiz += ro_u_globalroot.Length / sizeof (WCHAR);
>   	    }
>   	  /* TODO: Same ".\\" band-aid as in CCP_POSIX_TO_WIN_A case. */
> @@ -4075,6 +4076,8 @@ cygwin_conv_path (cygwin_conv_path_t what, const void *from, void *to,
>   	  stpcpy ((char *) to, buf);
>   	  break;
>   	case CCP_POSIX_TO_WIN_W:
> +	  if (prependglobalroot)
> +	    to = (void *) wcpcpy ((PWCHAR) to, ro_u_globalroot.Buffer);
>   	  wcpcpy ((PWCHAR) to, path);
>   	  break;
>   	}
> diff --git a/winsup/cygwin/release/3.6.2 b/winsup/cygwin/release/3.6.2
> index bceabcab34..de6eae13fc 100644
> --- a/winsup/cygwin/release/3.6.2
> +++ b/winsup/cygwin/release/3.6.2
> @@ -13,3 +13,6 @@ Fixes:
> 
>   - Fix setting DOS attributes on devices.
>     Addresse: https://cygwin.com/pipermail/cygwin/2025-April/257940.html
> +
> +- Fix cygwin_conv_path writing to 'to' pointer before size is checked.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2025-April/258068.html


Seems like this should also touch:

https://cygwin.com/cygwin-api/func-cygwin-conv-path.html

(source in winsup/doc/path.xml)


I'm not sure what the conventional language to use for this common 
behaviour:

"If size is 0, (to is ignored|to can be NULL) and cygwin_conv_path just 
returns the required buffer size in bytes" ?

