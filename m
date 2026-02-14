Return-Path: <SRS0=pkNT=AS=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id 26C554B9DB7A;
	Sat, 14 Feb 2026 15:01:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 26C554B9DB7A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 26C554B9DB7A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771081295; cv=none;
	b=C2V1qpUpKftDuL0oS3DID9R3lF8Us0o8mpnQo8PTbmMYSdVFs20zXd/0NZ+ZnE488BMFmbPrYbIuFqRlnXaqK7C7Myr1s1kezE8U9HXrzMKaiZgrrVNmYD+rmz+fzLRfkwjk7J3Fo7chA7XhubhShH/znaraSHEWvcimzFe7pBg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771081295; c=relaxed/simple;
	bh=OmR9sl6yN+MMFjAFqwJ6YlIEaaiKVVtyF3xTmv82HyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=avovR8L6Yuz1K9VFuvLzhFT8jHieqhyi2t3NK8CHm6gHEFCnA5vi+fdOaM9Nre2yNvzEOKmmQ1tWa9ztNWCRGWVn1BSy4tr1EDcNEGnUTEEIAuJh2zSghhgfDIQhEzWkzrUsM3pztxXyjcN/CiXvIwG9AKPZfssSmxCc87uRJuY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 26C554B9DB7A
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69515A8A0477779C
X-Originating-IP: [86.143.43.90]
X-OWM-Source-IP: 86.143.43.90
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTE+fMaTB+7kc3/r6yNVMPQFKUdW0FQcTvI4CLPofP0oNOH3T5TpiDzMXMVI6NNIEE/9q8eTQt5oQOjT4HS5ZerZk6HVMLHPv9ltoMKsfit53Ee6Jhe8MFZn9u5tzOGdN2FLAUAGvj6Pd2MaJvYjcXOY6D4TAWD5a2iIqPDq2HsIxbAlFWp9Vfs6O7w1Mk2EVXvI+1UF+qIy1n1hKRsO5A5jTO5hxrtcCTRYomR2CzPkks7icewXpDhoBWVkP2DwtktdtphCcBbTVe0SFLoiofBzPX0ObuNtyrUua/j/Mexvdgo3/fWZcU44p55M4CJLdIjV+JxDOqMONOp3OJXNWWzCfGbhlubxXPbxavBm9NVruBXjlNNPdtfuUO6g5tSnUE0U4i0RTiaJx6BpyG+2rhD2takx81D/W/xsnIYgPzzWFZEYA+QfOZmAj03VYWrJH0ru9SQiyVksb7dZon7Bco+BeXTvIQDrqYhMy3fOsGgirHrjg+Q2lnKFAnBfF0fcf4rkEwiSBkJ1szSesTtytbNyJpegvfdLfSletpDS6rsdqNm9XUIPgRTTdtEJl69o7dfplMaS5vqMVDM/20s2q4q4n9POGvH/OsgHBgQeMCOUZ6Oo44o4Etng5btXYwYESgBhJtTgr7Cw2kBat5QWt1IebvZeWtlYpeRbz1So+Hk3xQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.143.43.90) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69515A8A0477779C; Sat, 14 Feb 2026 15:01:31 +0000
Message-ID: <7354dd51-7ee2-45ef-85d2-9a100e24a551@dronecode.org.uk>
Date: Sat, 14 Feb 2026 15:01:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: PEHeaderFromHModule: allow only images matching
 build architecture
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
References: <aY9Ky2rJmDLyRqt7@calimero.vinschen.de>
 <20260213193535.2983506-1-corinna-cygwin@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260213193535.2983506-1-corinna-cygwin@cygwin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/02/2026 19:35, Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> This makes sure that we only ever handle images which can be executed
> on the current architecture.
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>   winsup/cygwin/hookapi.cc | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/hookapi.cc b/winsup/cygwin/hookapi.cc
> index b0126ac04e3e..5b25443c8365 100644
> --- a/winsup/cygwin/hookapi.cc
> +++ b/winsup/cygwin/hookapi.cc
> @@ -43,10 +43,13 @@ PEHeaderFromHModule (HMODULE hModule)
>     /* Return valid PIMAGE_NT_HEADERS only for supported architectures. */
>     switch (pNTHeader->FileHeader.Machine)
>       {
> +#if defined(__x86_64__)
>       case IMAGE_FILE_MACHINE_AMD64:
>         break;
> +#elif defined (__aarch64__)
>       case IMAGE_FILE_MACHINE_ARM64:
>         break;

This needs to be followed by

#else
#error "u wot?"

> +#endif
>       default:
>         return NULL;

 From Igor's analysis, ever returning NULL here seems like a bad idea, 
as it causes apparently unrelated things to stop working.

Maybe we should just abort there instead?


I've forgotten all the details of exactly what hookapi is doing, so I'm 
not sure if that kind of mixing can ever happen (It seems like not - 
does the OS even let us load DLLs of a different machine type to that of 
the process?)

