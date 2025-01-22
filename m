Return-Path: <SRS0=2YaE=UO=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 2FDA53858C5F
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 17:08:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2FDA53858C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2FDA53858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737565714; cv=none;
	b=CkgXEaAtqGer4vqQZWdK7EveMJuhcrQr6NzUvkQ8firFynU2fTsH2Y2niGd6faDQiWiW7b6jSxWoEb0vOnY/B/v1+vhw4RPH0obzwrr09V0WdPGUT0Z1D/tpONidhLM3w65j6S8kDBUz7dZkW2//3rXDcMjtK5guk0xP+J4vY8w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737565714; c=relaxed/simple;
	bh=b2buZ+WNpF+Ce0gSKXag8yDZ34XmzY76ENPSe2A3cfY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=niITrCB1gNaGyjnjHX95cATYmmqlzEQn7J9pqR43IJ9eRwb2FTJS40ZiHOJ3FCHkiVUtfG6EMwJW+AUWMZRvGuCoX/PM5kFEQVBGdk7RZTD8I6gK4xw6WuYj6steyy+AO0YRjQAdLg5bQL7qEyJ5c/j7turO+lj4iwOXOOrwnNY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2FDA53858C5F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=doEDvyQa
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C8DA5160500
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 17:08:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf05.hostedemail.com (Postfix) with ESMTPA id 4F03E20010
	for <cygwin-patches@cygwin.com>; Wed, 22 Jan 2025 17:08:32 +0000 (UTC)
Message-ID: <bfd9bdc1-c13b-4e14-886f-c0edfbf35b11@SystematicSW.ab.ca>
Date: Wed, 22 Jan 2025 10:08:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 1/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 TOG Issue 8 ISO 9945 move new
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <1eef0cf55412ebc56cddcd2b671a39873e3c8906.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z5DNuwuPclt-Q4d8@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z5DNuwuPclt-Q4d8@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F03E20010
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: jfstzegxq5qk9f1jtq54nixb3jyimwku
X-Rspamd-Server: rspamout03
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/tM7Rg/yAUv+H4e4He33shWynD5Wqvy/M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=DcCwBaqSHT9rVMEjKEC4brl1GHaeBV0cZsbmK1lp/y8=; b=doEDvyQarIWwvVsMUX08Zi3KVcGpCTFDPZ2yqBI7MPSHI/1PoBRVOow62vzx/X0dMSlFIFH2/W32fb8C2kxa8IbhjoUW8GNfWuIgZq05wPBGBXjphtemsfW6z49xUDIVPtrlNm7sKKSFrTVqFCR3yLxjkFQNBB3pAFAWZHoqI3H5bRnsrkT3vc/UKSAVkthfDLZKl2PRP7AltHu5Ehu6dN1FAD5umjIPexa9hIO9nG/4YxlHkrONxhkaipHdC9BMARk08dWIBVcWRBcV4PsTE0jrYr2k3HFn2S5eXa4cdBgK2dalrkFQcbugR7/vooXrK79DIeJ+tK2+XAimQXczjg==
X-HE-Tag: 1737565712-892932
X-HE-Meta: U2FsdGVkX19nN5UI/kx6J6iT/TBJu0X6BURW1ROwz8ZVzBr5Pm0TQIGITvSNdsgvzYCAtsvdLresBkD9H2dyO/kijm9SWpHjaWC2ynRGiX3OrLo3ckzkbtaurn/Xqg8camikke8lbhPURV+lp1FgCNgxiVsTGqQM/E4mP2gnNBDDPSWicMcBrzNEOwcFxBoO1TqkEbjG83XID3lqdoMzh6fMiQ2SdzT+1xUgPqMpcOiyaZ8ZsqgF8YqU0C8IMUfwuVxhzzDRGs7nK9HwPYOl5hLa6le8tZqxX5dhUe7IJEyJfgqnUNwYKavMluEHzp8SGG6YaYM2FSA7M4xLo7TpgpacHcuB2sd/dGS48Oa5KIJ5Ce3C3vq0Zvj31d/ky/XDakfE7EuGqYAGI9CSnrEP36VrbMjg+7+xhUIH5X5yOQwbNb7lAsTXgPzI5Zk0xJSTc8dvlgQNJ7uqTm+d1i/bPWR9s0GgadTyyI3a/ryI6eb/28PLNW7/HgOVnbgJBEn7VjpqmvAP1aCAdlgPbRq7k6oTRQbi8QO2nCXYNAp7bF1d+tQB9Pr3UjufxwXp1NB6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

No - never occurred to me other changes would be made here - I have enough 
problems tracking rebasing from *MY OWN* upstream!

On 2025-01-22 03:51, Corinna Vinschen wrote:
> Hi Brian,
> 
> your patch doesn't apply.  Apparently you didn't rebase the patch to the
> latest state in the main branch, because your patch contains the changes
> from commit 0813644661e3, which I wrote I'll fix separately in
> https://sourceware.org/pipermail/cygwin-patches/2025q1/013265.html
> 
> 
> Thanks,
> Corinna
> 
> 
> On Jan 17 10:01, Brian Inglis wrote:
>> Update anchor id and description to current version, year, issue, etc.
>> Move new POSIX entries in other sections to the SUS/POSIX section.
>>
>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> ---
>>   winsup/doc/posix.xml | 145 ++++++++++++++++++++++---------------------
>>   1 file changed, 75 insertions(+), 70 deletions(-)
>>
>> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
>> index 2782beb86547..9a8890936875 100644
>> --- a/winsup/doc/posix.xml
>> +++ b/winsup/doc/posix.xml
>> @@ -5,10 +5,15 @@
>>   <chapter id="compatibility" xmlns:xi="http://www.w3.org/2001/XInclude">
>>   <title>Compatibility</title>
>>   
>> -<sect1 id="std-susv4"><title>System interfaces compatible with the Single Unix Specification, Version 7:</title>
>> +<sect1 id="std-susv5"><title>System interfaces compatible with the Single UNIX® Specification Version 5:</title>
>>   
>> -<para>Note that the core of the Single Unix Specification, Version 7 is
>> -also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>> +<para>Note that the core of the Single UNIX® Specification Version 5 is
>> +POSIX®.1-2024 also simultaneously IEEE Std 1003.1™-2024 Edition,
>> +The Open Group Base Specifications Issue 8
>> +(see https://pubs.opengroup.org/onlinepubs/9799919799/), and
>> +ISO/IEC DIS 9945 Information technology
>> +- Portable Operating System Interface (POSIX®) base specifications
>> +- Issue 8.</para>
>>   
>>   <screen>
>>       FD_CLR
>> @@ -25,6 +30,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       abort
>>       abs
>>       accept
>> +    accept4
>>       access
>>       acos
>>       acosf
>> @@ -40,6 +46,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       aio_suspend
>>       aio_write
>>       alarm
>> +    aligned_alloc
>>       alphasort
>>       asctime
>>       asctime_r
>> @@ -49,6 +56,9 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       asinhf
>>       asinhl
>>       asinl
>> +    asprintf
>> +    assert
>> +    at_quick_exit
>>       atan
>>       atan2
>>       atan2f
>> @@ -68,6 +78,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       bind
>>       bsearch
>>       btowc
>> +    c16rtomb
>> +    c32rtomb
>>       cabs
>>       cabsf
>>       cabsl
>> @@ -77,6 +89,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       cacoshf
>>       cacoshl
>>       cacosl
>> +    call_once
>>       calloc
>>       carg
>>       cargf
>> @@ -134,6 +147,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       close
>>       closedir
>>       closelog
>> +    cnd_broadcast
>> +    cnd_destroy
>> +    cnd_init
>> +    cnd_signal
>> +    cnd_timedwait
>> +    cnd_wait
>>       confstr
>>       conj
>>       conjf
>> @@ -158,7 +177,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       crealf
>>       creall
>>       creat
>> -    crypt			(available in external "crypt" library)
>> +    crypt			(available in external "libcrypt" library)
>>       csin
>>       csinf
>>       csinh
>> @@ -191,6 +210,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       dirfd
>>       dirname
>>       div
>> +    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       dlclose
>>       dlerror
>>       dlopen
>> @@ -199,8 +219,9 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       drand48
>>       dup
>>       dup2
>> +    dup3
>>       duplocale
>> -    encrypt			(available in external "crypt" library)
>> +    encrypt			(available in external "libcrypt" library)
>>       endgrent
>>       endhostent
>>       endprotoent
>> @@ -265,6 +286,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       fexecve
>>       fflush
>>       ffs
>> +    ffsl
>> +    ffsll
>>       fgetc
>>       fgetpos
>>       fgets
>> @@ -541,6 +564,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       malloc
>>       mblen
>>       mbrlen
>> +    mbrtoc16
>> +    mbrtoc32
>>       mbrtowc
>>       mbsinit
>>       mbsnrtowcs
>> @@ -551,6 +576,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       memchr
>>       memcmp
>>       memcpy
>> +    memmem
>>       memmove
>>       memset
>>       mkdir
>> @@ -560,6 +586,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       mkfifoat
>>       mknod
>>       mknodat
>> +    mkostemp
>>       mkstemp
>>       mktime
>>       mlock
>> @@ -584,6 +611,12 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       msgrcv			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       msgsnd			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       msync
>> +    mtx_destroy
>> +    mtx_init
>> +    mtx_lock
>> +    mtx_timedlock
>> +    mtx_trylock
>> +    mtx_unlock
>>       munlock
>>       munmap
>>       nan
>> @@ -622,6 +655,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       pclose
>>       perror
>>       pipe
>> +    pipe2
>>       poll
>>       popen
>>       posix_fadvise
>> @@ -630,8 +664,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       posix_memalign
>>       posix_openpt
>>       posix_spawn
>> +    posix_spawn_file_actions_addchdir
>>       posix_spawn_file_actions_addclose
>>       posix_spawn_file_actions_adddup2
>> +    posix_spawn_file_actions_addfchdir
>>       posix_spawn_file_actions_addopen
>>       posix_spawn_file_actions_destroy
>>       posix_spawn_file_actions_init
>> @@ -653,6 +689,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       pow
>>       powf
>>       powl
>> +    ppoll
>>       pread
>>       printf
>>       pselect
>> @@ -686,6 +723,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       pthread_barrierattr_setpshared
>>       pthread_cancel
>>       pthread_cond_broadcast
>> +    pthread_cond_clockwait
>>       pthread_cond_destroy
>>       pthread_cond_init
>>       pthread_cond_signal
>> @@ -709,6 +747,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       pthread_key_create
>>       pthread_key_delete
>>       pthread_kill
>> +    pthread_mutex_clocklock
>>       pthread_mutex_destroy
>>       pthread_mutex_getprioceiling
>>       pthread_mutex_init
>> @@ -728,6 +767,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       pthread_mutexattr_setpshared
>>       pthread_mutexattr_settype
>>       pthread_once
>> +    pthread_rwlock_clockrdlock
>> +    pthread_rwlock_clockwrlock
>>       pthread_rwlock_destroy
>>       pthread_rwlock_init
>>       pthread_rwlock_rdlock
>> @@ -756,6 +797,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       pthread_spin_unlock
>>       pthread_testcancel
>>       ptsname
>> +    ptsname_r
>>       putc
>>       putc_unlocked
>>       putchar
>> @@ -767,6 +809,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       putwchar
>>       pwrite
>>       qsort
>> +    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>> +    quick_exit
>>       raise
>>       rand
>>       rand_r
>> @@ -778,6 +822,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       readlinkat
>>       readv
>>       realloc
>> +    reallocarray
>>       realpath
>>       recv
>>       recvfrom
>> @@ -788,7 +833,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       regfree
>>       remainder
>>       remainderf
>> -    reminderl
>> +    remainderl
>>       remove
>>       remque
>>       remquo
>> @@ -821,9 +866,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       sched_setparam		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       sched_setscheduler		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       sched_yield
>> +    secure_getenv
>>       seed48
>>       seekdir
>>       select
>> +    sem_clockwait
>>       sem_close
>>       sem_destroy
>>       sem_getvalue
>> @@ -849,7 +896,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       sethostent
>>       setitimer			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       setjmp
>> -    setkey			(available in external "crypt" library)
>> +    setkey			(available in external "libcrypt" library)
>>       setlocale
>>       setlogmask
>>       setpgid
>> @@ -874,6 +921,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       shmdt			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       shmget			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       shutdown
>> +    sig2str
>>       sigaction
>>       sigaddset
>>       sigaltstack
>> @@ -925,6 +973,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       stdout
>>       stpcpy
>>       stpncpy
>> +    str2sig
>>       strcasecmp
>>       strcasecmp_l
>>       strcat
>> @@ -942,6 +991,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       strfmon_l
>>       strftime
>>       strftime_l
>> +    strlcat
>> +    strlcpy
>>       strlen
>>       strncasecmp
>>       strncasecmp_l
>> @@ -1000,6 +1051,14 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       tgamma
>>       tgammaf
>>       tgammal
>> +    thrd_create
>> +    thrd_current
>> +    thrd_detach
>> +    thrd_equal
>> +    thrd_exit
>> +    thrd_join
>> +    thrd_sleep
>> +    thrd_yield
>>       time
>>       timer_create		(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       timer_delete
>> @@ -1025,6 +1084,10 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       truncf
>>       truncl
>>       tsearch
>> +    tss_create
>> +    tss_delete
>> +    tss_get
>> +    tss_set
>>       ttyname
>>       ttyname_r
>>       twalk
>> @@ -1046,6 +1109,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       va_copy
>>       va_end
>>       va_start
>> +    vasprintf
>>       vdprintf
>>       vfprintf
>>       vfscanf
>> @@ -1076,6 +1140,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       wcscspn
>>       wcsdup
>>       wcsftime
>> +    wcslcat
>> +    wcslcpy
>>       wcslen
>>       wcsncasecmp
>>       wcsncasecmp_l
>> @@ -1213,10 +1279,8 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       madvise
>>       mkstemps
>>       openpty
>> -    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       rcmd
>>       rcmd_af
>> -    reallocarray
>>       reallocf
>>       res_close
>>       res_init
>> @@ -1249,8 +1313,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       setusershell
>>       statfs
>>       strcasestr
>> -    strlcat
>> -    strlcpy
>>       strsep
>>       timingsafe_bcmp
>>       timingsafe_memcmp
>> @@ -1266,8 +1328,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       wait4
>>       warn
>>       warnx
>> -    wcslcat
>> -    wcslcpy
>>   </screen>
>>   
>>   </sect1>
>> @@ -1276,7 +1336,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>   
>>   <screen>
>>       __mempcpy
>> -    accept4
>>       argz_add
>>       argz_add_sep
>>       argz_append
>> @@ -1290,7 +1349,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       argz_replace
>>       argz_stringify
>>       asnprintf
>> -    asprintf
>>       asprintf_r
>>       basename			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       canonicalize_file_name
>> @@ -1300,9 +1358,7 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       clog10l
>>       close_range			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       crypt_r			(available in external "crypt" library)
>> -    dladdr			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       dremf
>> -    dup3
>>       envz_add
>>       envz_entry
>>       envz_get
>> @@ -1322,8 +1378,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       fedisableexcept
>>       feenableexcept
>>       fegetexcept
>> -    ffsl
>> -    ffsll
>>       fgets_unlocked
>>       fgetwc_unlocked
>>       fgetws_unlocked
>> @@ -1352,35 +1406,23 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       llistxattr
>>       lremovexattr
>>       lsetxattr
>> -    memmem
>>       mempcpy
>>       memrchr
>> -    mkostemp
>>       mkostemps
>> -    pipe2
>> -    posix_spawn_file_actions_addchdir_np
>> -    posix_spawn_file_actions_addfchdir_np
>>       pow10
>>       pow10f
>>       pow10l
>> -    ppoll
>> -    pthread_cond_clockwait
>>       pthread_getaffinity_np
>>       pthread_getattr_np
>>       pthread_getname_np
>> -    pthread_mutex_clocklock
>> -    pthread_rwlock_clockrdlock
>> -    pthread_rwlock_clockwrlock
>>       pthread_setaffinity_np
>>       pthread_setname_np
>>       pthread_sigqueue
>>       pthread_timedjoin_np
>>       pthread_tryjoin_np
>> -    ptsname_r
>>       putwc_unlocked
>>       putwchar_unlocked
>>       renameat2			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>> -    qsort_r			(see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)
>>       quotactl
>>       rawmemchr
>>       removexattr
>> @@ -1388,8 +1430,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       sched_getaffinity
>>       sched_getcpu
>>       sched_setaffinity
>> -    secure_getenv
>> -    sem_clockwait
>>       setxattr
>>       signalfd
>>       sincos
>> @@ -1416,7 +1456,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       updwtmpx
>>       utmpxname
>>       vasnprintf
>> -    vasprintf
>>       vasprintf_r
>>       versionsort
>>       wcsftime_l
>> @@ -1461,8 +1500,6 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       getmntent
>>       memalign
>>       setmntent
>> -    sig2str
>> -    str2sig
>>       xdr_array			(available in external "libtirpc" library)
>>       xdr_bool			(available in external "libtirpc" library)
>>       xdr_bytes			(available in external "libtirpc" library)
>> @@ -1514,49 +1551,17 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>>       xdrstdio_create		(available in external "libtirpc" library)
>>   </screen>
>>   
>> +</sect1>
>> +
>>   <sect1 id="std-iso"><title>System interfaces not in POSIX but compatible with ISO C requirements:</title>
>>   
>>   <screen>
>> -    aligned_alloc		(ISO C11)
>> -    at_quick_exit		(ISO C11)
>> -    c16rtomb			(ISO C11)
>> -    c32rtomb			(ISO C11)
>>       c8rtomb			(ISO C23)
>> -    call_once			(ISO C11)
>> -    cnd_broadcast		(ISO C11)
>> -    cnd_destroy			(ISO C11)
>> -    cnd_init			(ISO C11)
>> -    cnd_signal			(ISO C11)
>> -    cnd_timedwait		(ISO C11)
>> -    cnd_wait			(ISO C11)
>> -    mbrtoc16			(ISO C11)
>> -    mbrtoc32			(ISO C11)
>>       mbrtoc8			(ISO C23)
>> -    mtx_destroy			(ISO C11)
>> -    mtx_init			(ISO C11)
>> -    mtx_lock			(ISO C11)
>> -    mtx_timedlock		(ISO C11)
>> -    mtx_trylock			(ISO C11)
>> -    mtx_unlock			(ISO C11)
>> -    quick_exit			(ISO C11)
>> -    thrd_create			(ISO C11)
>> -    thrd_current		(ISO C11)
>> -    thrd_detach			(ISO C11)
>> -    thrd_equal			(ISO C11)
>> -    thrd_exit			(ISO C11)
>> -    thrd_join			(ISO C11)
>> -    thrd_sleep			(ISO C11)
>> -    thrd_yield			(ISO C11)
>> -    tss_create			(ISO C11)
>> -    tss_delete			(ISO C11)
>> -    tss_get			(ISO C11)
>> -    tss_set			(ISO C11)
>>   </screen>
>>   
>>   </sect1>
>>   
>> -</sect1>
>> -
>>   <sect1 id="std-deprec"><title>Other UNIX system interfaces, not in POSIX.1-2008 or deprecated:</title>
>>   
>>   <screen>
>> -- 
>> 2.45.1


-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
