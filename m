Return-Path: <cygwin-patches-return-8894-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25039 invoked by alias); 2 Nov 2017 15:19:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25020 invoked by uid 89); 2 Nov 2017 15:19:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=mess
X-HELO: mail-io0-f195.google.com
Received: from mail-io0-f195.google.com (HELO mail-io0-f195.google.com) (209.85.223.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 15:19:37 +0000
Received: by mail-io0-f195.google.com with SMTP id b186so14769376iof.8        for <cygwin-patches@cygwin.com>; Thu, 02 Nov 2017 08:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=xNTelGOyGWWDp2ae7RV7gDR9jFsZt4qyNdLebTbSTOg=;        b=LdtobuNK3r2LbCoR+58ICwSXFnW4b5uEu4i4z93uvtHEotjCixC/2kPHzUzbl4cgl9         ceQdnyuHTFjJDiGlLTfpCOLrMHPdBwqgPrn1OhkF0kVlnJVtESvEMwweYjr+8nwLo6Sw         9Ctq4oecKb+OR18PbV9CeTwJWIerGDjBdT4FtYn9RgNqvCVmrtG8ebsTxKBntUYqkIa+         vv5iT0xMn6MkAmMbC66FCbvjTwExoMLQrs79tYq/ozqCcihHu4Yt6CC+md8H/mIVbByx         tpFbqIbQCHJuzF8+ZbI7ni5zN1FvIA5OLrE5FiVsvp7cqo+L6+uhMp2W7X3HxZuTfVai         avYA==
X-Gm-Message-State: AMCzsaX1o/2bVrOOduSnN2T7cW+AfthpHwJNu0fZ4FiaXBrVtsFnXULi	p6ntFXi9n7OSCgA6pjILR8H+OTT/SAyY1g3LAxaRcw==
X-Google-Smtp-Source: ABhQp+SKHFaOdo5YZjaTV2Uz3ieYd8ZPvO74d0t9s2EbphAa1RyjozD46P7xmDCcDqedpeAOMRG0RuY6eYFPfzLyVJI=
X-Received: by 10.107.33.18 with SMTP id h18mr4786680ioh.167.1509635974999; Thu, 02 Nov 2017 08:19:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.105.151 with HTTP; Thu, 2 Nov 2017 08:19:34 -0700 (PDT)
In-Reply-To: <20171102145845.GE8599@calimero.vinschen.de>
References: <20171102132622.5756-1-erik.m.bray@gmail.com> <20171102145845.GE8599@calimero.vinschen.de>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Thu, 02 Nov 2017 15:19:00 -0000
Message-ID: <CAOTD34Y1jS3UtTrhRh-sfADrWYFheOG+C9qYyPwJ8xtW3QKuTg@mail.gmail.com>
Subject: Re: [PATCH] posix_fadvise() *returns* error codes but does not set errno
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00024.txt.bz2

On Thu, Nov 2, 2017 at 3:58 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Hi Eric,
>
> On Nov  2 14:26, Erik M. Bray wrote:
>> Also updates the fhandler_*::fadvise implementations to adhere to the same
>> semantics.
>
> Good catch.  I have just some style nits.
>
>> ---
>>  winsup/cygwin/fhandler.cc           |  3 +--
>>  winsup/cygwin/fhandler_disk_file.cc | 16 ++++++----------
>>  winsup/cygwin/pipe.cc               |  3 +--
>>  winsup/cygwin/syscalls.cc           |  2 +-
>>  4 files changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
>> index d719b7c..858c1fd 100644
>> --- a/winsup/cygwin/fhandler.cc
>> +++ b/winsup/cygwin/fhandler.cc
>> @@ -1764,8 +1764,7 @@ fhandler_base::fsetxattr (const char *name, const void *value, size_t size,
>>  int
>>  fhandler_base::fadvise (off_t offset, off_t length, int advice)
>>  {
>> -  set_errno (EINVAL);
>> -  return -1;
>> +  return EINVAL;
>>  }
>>
>>  int
>> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
>> index 2144a4c..f46e355 100644
>> --- a/winsup/cygwin/fhandler_disk_file.cc
>> +++ b/winsup/cygwin/fhandler_disk_file.cc
>> @@ -1076,8 +1076,7 @@ fhandler_disk_file::fadvise (off_t offset, off_t length, int advice)
>>  {
>>    if (advice < POSIX_FADV_NORMAL || advice > POSIX_FADV_NOREUSE)
>>      {
>> -      set_errno (EINVAL);
>> -      return -1;
>> +      return EINVAL;
>>      }
>
> Please remove the braces for a one-line block.
>
>>
>>    /* Windows only supports advice flags for the whole file.  We're using
>> @@ -1097,21 +1096,18 @@ fhandler_disk_file::fadvise (off_t offset, off_t length, int advice)
>>    NTSTATUS status = NtQueryInformationFile (get_handle (), &io,
>>                                           &fmi, sizeof fmi,
>>                                           FileModeInformation);
>> -  if (!NT_SUCCESS (status))
>> -    __seterrno_from_nt_status (status);
>> -  else
>> +  if (NT_SUCCESS (status))
>>      {
>>        fmi.Mode &= ~FILE_SEQUENTIAL_ONLY;
>>        if (advice == POSIX_FADV_SEQUENTIAL)
>> -     fmi.Mode |= FILE_SEQUENTIAL_ONLY;
>> +        fmi.Mode |= FILE_SEQUENTIAL_ONLY;
>
> You changed indentation here for no apparent reason (TABs vs spaces).

Sorry, it's just that the indentation in this function is already an
unholy mess of tabs vs spaces from line to line.  This was just my
editor's (ill-advised) attempt to make it legible.  I can remove the
unrelated whitespace changes from the patch.

>>        status = NtSetInformationFile (get_handle (), &io, &fmi, sizeof fmi,
>> -                                  FileModeInformation);
>> +                                     FileModeInformation);
>>        if (NT_SUCCESS (status))
>> -     return 0;
>> -      __seterrno_from_nt_status (status);
>> +         return 0;
>>      }
>
> Ditto and ditto.
>
>> -  return -1;
>> +  return geterrno_from_nt_status (status);
>>  }
>>
>>  int
>> diff --git a/winsup/cygwin/pipe.cc b/winsup/cygwin/pipe.cc
>> index 79b7966..8738d34 100644
>> --- a/winsup/cygwin/pipe.cc
>> +++ b/winsup/cygwin/pipe.cc
>> @@ -165,8 +165,7 @@ fhandler_pipe::lseek (off_t offset, int whence)
>>  int
>>  fhandler_pipe::fadvise (off_t offset, off_t length, int advice)
>>  {
>> -  set_errno (ESPIPE);
>> -  return -1;
>> +  return ESPIPE;
>>  }
>>
>>  int
>> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
>> index caa3a77..d0d735b 100644
>> --- a/winsup/cygwin/syscalls.cc
>> +++ b/winsup/cygwin/syscalls.cc
>> @@ -2937,7 +2937,7 @@ posix_fadvise (int fd, off_t offset, off_t len, int advice)
>>    if (cfd >= 0)
>>      res = cfd->fadvise (offset, len, advice);
>>    else
>> -    set_errno (EBADF);
>> +    res = EBADF;
>>    syscall_printf ("%R = posix_fadvice(%d, %D, %D, %d)",
>>                 res, fd, offset, len, advice);
>>    return res;
>> --
>> 2.8.3
>
> Other than that, looks good.
>
>
> Thanks,
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Maintainer                 cygwin AT cygwin DOT com
> Red Hat
