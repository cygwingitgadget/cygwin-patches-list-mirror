Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3EC443858D38; Mon,  3 Mar 2025 10:42:59 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 32630A80770; Mon, 03 Mar 2025 11:42:57 +0100 (CET)
Date: Mon, 3 Mar 2025 11:42:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
Message-ID: <Z8WHsUDXsVhtOEzS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On Mar  1 22:43, Johannes Schindelin wrote:
> Reportedly a very recent internal build of Windows 11 once again changed
> the current working directory logic a bit, and Cygwin's "magic" (or:
> "technologically sufficiently advanced") code needs to be adjusted

*cough, cough*

> accordingly.
> 
> In particular, the following assembly code can be seen:
> 
> ntdll!RtlpReferenceCurrentDirectory
> 
>   598 00000001`800c6925 488d0db4cd0f00  lea     rcx,[ntdll!FastPebLock (00000001`801c36e0)]
>   583 00000001`800c692c 4c897810        mov     qword ptr [rax+10h],r15
>   588 00000001`800c6930 0f1140c8        movups  xmmword ptr [rax-38h],xmm0
>   598 00000001`800c6934 e82774f4ff      call    ntdll!RtlEnterCriticalSection
> 
> The change necessarily looks a bit different than 4840a56325 (Cygwin:
> Adjust CWD magic to accommodate for the latest Windows previews,
> 2023-05-22): The needle `\x48\x8d\x0d` is already present, as the first
> version of the hack after Windows 8.1 was released. In that code,
> though, the `call` to `RtlEnterCriticalSection` followed the `lea`
> instruction immediately, but now there are two more instructions
> separating them.
> 
> Note: In the long run, we may very well want to follow the insightful
> suggestion by a helpful Windows kernel engineer who pointed out that it
> may be less fragile to implement kind of a disassembler that has a
> better chance to adapt to the ever-changing code of
> `ntdll!RtlpReferenceCurrentDirectory` by skipping uninteresting
> instructions such as `mov %rsp,%rax`, `mov %rbx,0x20(%rax)`, `push %rsi`
> `sub $0x70,%rsp`, etc, and focuses on finding the `lea`, `call
> ntdll!RtlEnterCriticalSection` and `mov ..., rbx` instructions, much
> like it was prototyped out for ARM64 at
> https://gist.github.com/jeremyd2019/aa167df0a0ae422fa6ebaea5b60c80c9

I'm always open to patches to improve this code.  But x86 assembler is
really tricky, me thinks, using any number of bytes for an instruction.
It needs a lot of knowledge of instructons and their respective length,
to skip the uninteresting parts.

But I have a few more ideas how to handle this in future:

- Export some Rtl function from ntdll.dll, returning the cwd pointer
  we're looking for,

- or move the pointer into the PEB,

- or export a new function RtlSetCurrentDirectoryEx_U:

    NTSTATUS NTAPI
    RtlSetCurrentDirectoryEx_U (IN PUNICODE_STRING Path,
                                IN POBJECT_ATTRIBUTES ObjectAttributes,
				IN ULONG ShareAccess,
				IN ULONG OpenOptions);
    						
Doesn't this sound like the cleanest way forward?

> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 599809f941..49740ac465 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -4539,6 +4539,18 @@ find_fast_cwd_pointer ()
>           %rcx for the subsequent RtlEnterCriticalSection call. */
>        lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
>                                         "\x48\x8d\x0d", 3);
> +      if (lock)
> +	{
> +	  /* A recent Windows 11 Preview calls `lea rel(rip),%rcx' then
> +	     a `mov` and a `movups` instruction, and only then
> +	     `callq RtlEnterCriticalSection'.
> +	     */
> +	  if (memmem (lock + 7, 8, "\x4c\x89\x78\x10\x0f\x11\x40\xc8", 8))

Is it really necessary to check for each and every byte between lea and
callq?  I wonder if this can't be simpler by simply checking for the
'\x48\x8d\x0d` needle and then, instead of just assuming a fixed
call_rtl_offset, skip programatically to the next callq 0xe8 byte
within the next 16 bytes or so?


Thanks,
Corinna
