Return-Path: <SRS0=iHfN=5I=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 4CEB43858D39
	for <cygwin-patches@cygwin.com>; Fri, 31 Oct 2025 03:49:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4CEB43858D39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4CEB43858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1761882558; cv=none;
	b=h2vPFcstR03Qyd54td7c0nlJygTZMOd7AB4jNkeikoS5E5uNN3BzHRH4/Kqg3CHUkLNzLcO41cIxv9j4HKmRA+dSripWk3cReBvVYGgUqe+0BJt9URMHPTPpPHMPSKH8OPid9g7qqcuUmoFdsbULxLAQPoLneHiRBXe/ct4ZH5c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761882558; c=relaxed/simple;
	bh=wsklRy7kAj8CdLwl7Ma/IHvY6PttkI4LvWWFmK+R3tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Wya6LudlmSkb/wmGBj8MKZH5d6WHJu989nqC/foDPMhpxU0ikkOt86K1JetQEaoNhWJFF/6CKk5FsM038XPec9p4lZfnqWDYr21OlObGH3BjXJHuiYPEznL4IxS1Z7bn1E1E7IZ2KZ4p/crZWpa3gwdjtlMiRu9jjqjNSkHee4Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4CEB43858D39
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 59V3xvZB096014
	for <cygwin-patches@cygwin.com>; Thu, 30 Oct 2025 20:59:57 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdWZj2L6; Thu Oct 30 19:59:53 2025
Message-ID: <39e50846-f6d2-4dec-9d9e-ce4c4e963ace@maxrnd.com>
Date: Thu, 30 Oct 2025 20:49:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Testsuite: fixes for compatibility with GCC 15
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

On 10/27/2025 1:23 AM, Thirumalai Nagalingam wrote:
> Hi Everyone,
> 
> Please find the below attached patch for review.
> 
>    *   This patch fixes function declarations in shmtest.c by converting definitions to
> 
> standard ANSI C prototypes to ensure compatibility with GCC 15.
> 
> Thanks & regards
> Thirumalai Nagalingam
> 
> ============
> In-lined patch:
> 
> diff --git a/winsup/testsuite/winsup.api/shmtest.c b/winsup/testsuite/winsup.api/shmtest.c
> index e0b7acf7d..2c6c74e7a 100644
> --- a/winsup/testsuite/winsup.api/shmtest.c
> +++ b/winsup/testsuite/winsup.api/shmtest.c
> @@ -74,10 +74,7 @@ key_t    shmkey;
> 
>   size_t pgsize;
> 
> -int
> -main(argc, argv)
> -   int argc;
> -   char *argv[];
> +int main(int argc, char **argv)
>   {
>      struct sigaction sa;
>      struct shmid_ds s_ds;
> @@ -177,18 +174,14 @@ main(argc, argv)
>      exit (1);
>   }

Thanks for looking into this issue.  Our Cygwin coding conventions 
specify that function names should be at the left margin.  So...

int
main(int argc, char **argv)
{
     ...
}

I've not patched the testsuite before so I'm unsure if the same 
submission format applies here as applies to Cygwin DLL patches.

Namely, make the change in your git repo and commit it, use 'git 
format-patch -1' to create a patch file, and then 'git send-email 
<filename>' to mail it to cygwin-patches@cygwin.com.  Between the last 
two steps, use an editor to add a patch description between the email 
headers and your patch.

I am doubly unsure if all the tracking info added to DLL patches needs 
to be added to testsuite patches.  Here I mean Reported-by:, Addresses:, 
Signed-off-by:, and Fixes:.  Maybe someone else can chime in on this?
Thanks,

..mark
