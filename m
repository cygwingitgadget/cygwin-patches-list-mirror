Return-Path: <SRS0=rdKM=DZ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo005.btinternet.com (btprdrgo005.btinternet.com [65.20.50.218])
	by sourceware.org (Postfix) with ESMTP id BE23A4BA2E17
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 12:19:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BE23A4BA2E17
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BE23A4BA2E17
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.218
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779970788; cv=none;
	b=eVrMvEjKgq7cEePDQMv+2m2JDnMpDeRNnicvZM9AuwSjJ1ExHd4xv/k3tX/vazGCeOYAMTlTqVzAXn6A17naMMTOZ7plbMxEzm8ac74nyEOFAMEvDV4EE712s/R7sMndaWZ/CRa9PKC7nh1T2sYbaiG3FuW9fdBq/OIvsuflG38=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779970788; c=relaxed/simple;
	bh=tBsrqjxb44aVvZ7WD4jtAoHgamS5Oa4PgH1Dz6fo8Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=UZ7dSZ7+h127ARMuQSsD1b1TkZ8t55c5wv/vN4OWek1JzLcX8jRBCw5LvLStnrUUbdVQ44mC+B+gSrkUgCb+iH8xGaaWV4RubvclTpRqjMFZkYixcQlRkWfb+6XZIm9J5e/vEWR4utFjuP1oWVTQG4PVlwrRxn3k9ZIkAw2V2Lw=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BE23A4BA2E17
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A0659D00119FBFB
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTESJHZMtOUe7HmUT0j5cRa+hh/0ozG1WY15hCOHcejJtc1AuzPpl50+ApW57XXv4ccYxMmuh5dCHH375u8rDdV3Cz4KHUgBl5zB4uzZWiKplv+NjxfGG15FQM0vCPk8+fdOcJPmMVOAisEp5qGiU5VlhNarURbXZfmLF9HVu/UXXl4eZIoVxdoe7sTrHBucBp01aUkRvhThMC8AiM+TMwlpu/lgAVzxZsNqQBmzy6ZJmyiH3KXm+S5fCWqyPv7ixdRqbcqcudm3lxgM1dpf1gw+8Vi1gYdZFnQUDv9jUQXMKgmI0cD5djCMLYRGcEDmZ/5NvsVCpQSfzyvwPG4MVkqoT1bJipew4EhNXwrpglnAnmSpImlqsly+/FECV/BbK4vEBXkFwvDHyPR3/S0XqQzcZ5iIUd7ClBaq6eCN4+HE/EebG88o/75CsuA/XlWcYwkFCJ5k97h1vxzY1m0Qmb+le7oBeIHEoT+3RyzarqPiDuCzsIzrE1HGjnSjl04Tg2GrrKohmQaPDGyC4Yzi7ilQB3xej8itlO1AcL5m9F4AmLZwWff0zmYeQtIYDhwe/AvnY4lA193XpMf2KgN3ohPPop3/pZHzGBv0i/aUpXmxuLh42361C/0XrPfRsHJkJPry8qJTh91pzG75fNKknvKn0QnK4Rwhb84dGcUHZNCNvQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo005.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A0659D00119FBFB; Thu, 28 May 2026 13:19:37 +0100
Message-ID: <34b42100-1722-4bdc-abf9-e9d159456ee0@dronecode.org.uk>
Date: Thu, 28 May 2026 13:19:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: ssp: add AArch64 build stubs
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
References: <PN0P287MB02952FCE57C59FF18096B96D920E2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN0P287MB02952FCE57C59FF18096B96D920E2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,BODY_8BITS,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/05/2026 09:58, Chandru Kumaresan wrote:
> Hi Corinna,
> 
> This patch adds AArch64 support to SSP, including ARM64 breakpoints, single-step handling, register dumps, and kernel-call tracing support.
> 
> Comments and reviews are welcome.

Thanks!

About the patch title: this says "build stubs", but there doesn't seem 
to be any stubbing here.  This is looks like the right changes to me?

Should it be "ssp: Add AArch64 implementation"?

A few comments below.

> Thanks & regards,
> K Chandru
> 
> Inline patch
> 
> ---
>   winsup/utils/ssp.c | 152 +++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 140 insertions(+), 12 deletions(-)
> 
> diff --git a/winsup/utils/ssp.c b/winsup/utils/ssp.c
> index 96a90a1d9..8dd7ef2ed 100644
> --- a/winsup/utils/ssp.c
> +++ b/winsup/utils/ssp.c
> @@ -48,6 +48,13 @@ static char opts[] = "+cdehlstvV";
>   typedef DWORD64 CONTEXT_REG;
>   #define CONTEXT_REG_FMT "%016llx"
>   #define ADDR_SSCANF_FMT "%lli"
> +#elif defined(__aarch64__)
> +#define KERNEL_ADDR 0x00007FF000000000
> +#define CONTEXT_SP Sp
> +#define CONTEXT_IP Pc
> +typedef DWORD64 CONTEXT_REG;
> +#define CONTEXT_REG_FMT "%016llx"
> +#define ADDR_SSCANF_FMT "%lli"
>   #else
>   #error unimplemented for this target
>   #endif
> @@ -85,11 +92,18 @@ typedef struct {
> 
>   typedef struct {
>     CONTEXT_REG address;
> +#if defined(__aarch64__)
> +  unsigned char real_insn[4]; /* ARM64 instructions are 4 bytes */
> +#else
>     unsigned char real_byte;
> +#endif
>   } PendingBreakpoints;
> 
>   CONTEXT_REG low_pc, high_pc=0;
>   CONTEXT_REG last_pc=0, pc, last_sp=0, sp;
> +#if defined(__aarch64__)
> +CONTEXT_REG last_lr=0, lr;
> +#endif
>   int total_cycles, count;
>   HANDLE hProcess;
>   PROCESS_INFORMATION procinfo;
> @@ -129,7 +143,12 @@ add_breakpoint (CONTEXT_REG address)
>   {
>     int i;
>     SIZE_T rv;
> -  static char int3[] = { 0xcc };
> +#if defined(__aarch64__)
> +  static unsigned char brk_insn[] = { 0x00, 0x00, 0x20, 0xd4 }; /* BRK #0, which matches MSVC's
> +     __debugbreak recommendation on Windows/ARM64.*/
> +#else
> +  static unsigned char int3[] = { 0xcc };

Seems like this should be '#elif defined(__x86_64)' and then '#else 
#error unimplemented for this target' before the '#endif'?

> +#endif
>     for (i=0; i<num_breakpoints; i++)
>       {
>         if (pending_breakpoints[i].address == address)
> @@ -140,14 +159,23 @@ add_breakpoint (CONTEXT_REG address)
>     if (i == MAXPENDS)
>       return;
>     pending_breakpoints[i].address = address;
> +#if defined(__aarch64__)
> +  ReadProcessMemory (hProcess,
> +                (void *)address,
> +                pending_breakpoints[i].real_insn,
> +                4, &rv);
> +  WriteProcessMemory (hProcess,
> +                 (void *)address,
> +                 (LPVOID)brk_insn, 4, &rv);
> +#else

ditto (and similarly throughout)

>     ReadProcessMemory (hProcess,
>                   (void *)address,
>                   &(pending_breakpoints[i].real_byte),
>                   1, &rv);
> -
>     WriteProcessMemory (hProcess,
>                    (void *)address,
>                    (LPVOID)int3, 1, &rv);
> +#endif

Hmm... did you consider writing something like (untested):

#if defined(__x86_64__)
#define SIZEOF_BRK_INSN 1
#elif defined(__aarch64__)
#define SIZEOF_BRK_INSN 4 /* ARM64 instructions are 4 bytes */
#error unimplemented for this target
#endif

typedef struct {
   CONTEXT_REG address;
   unsigned char real_insn[4];
} PendingBreakpoints;


...

#if defined(__x86_64__)
   static unsigned char brk_insn[] = { 0xcc };
#elif defined(__aarch64__)
   static unsigned char brk_insn[] = { 0x00, 0x00, 0x20, 0xd4 };
#endif

...

   ReadProcessMemory (hProcess,
		     (void *)address,
		     pending_breakpoints[i].real_insn,
		     SIZEOF_BREAK_INSN, &rv);
   WriteProcessMemory (hProcess,
		      (void *)address,
		      (LPVOID)brk_insn, SIZEOF_BREAK_INSN, &rv);


etc., which would reduce the amount of compilation conditionals here?

>     if (i >= num_breakpoints)
>       num_breakpoints = i+1;
>   }
> @@ -162,10 +190,17 @@ remove_breakpoint (CONTEXT_REG address)
>         if (pending_breakpoints[i].address == address)
>        {
>          pending_breakpoints[i].address = 0;
> +#if defined(__aarch64__)
> +       WriteProcessMemory (hProcess,
> +                       (void *)address,
> +                       pending_breakpoints[i].real_insn,
> +                       4, &rv);
> +#else
>          WriteProcessMemory (hProcess,
>                          (void *)address,
>                          &(pending_breakpoints[i].real_byte),
>                          1, &rv);
> +#endif
>          return 1;
>        }
>       }
> @@ -200,10 +235,19 @@ set_step_threads (int threadId, int trace)
>     if (rv != -1)
>       {
>         thread_step_flags[tix] = trace;
> +#if defined(__i386__) || defined(__x86_64__)
>         if (trace)
> -     context.EFlags |= 0x100; /* TRAP (single step) flag */
> +       context.EFlags |= 0x100; /* TRAP (single step) flag */
>         else
> -     context.EFlags &= ~0x100; /* TRAP (single step) flag */
> +       context.EFlags &= ~0x100; /* TRAP (single step) flag */
> +#elif defined(__aarch64__)
> +      if (trace)
> +       context.Cpsr |= 0x00200000; /* PSTATE.SS (single step) flag */
> +      else
> +       context.Cpsr &= ~0x00200000; /* PSTATE.SS (single step) flag */
> +#else
> +#error unimplemented for this target
> +#endif
>         SetThreadContext (thread, &context);
>       }
>   }
> @@ -215,7 +259,13 @@ set_steps ()
>     for (i=0; i<num_active_threads; i++)
>       {
>         GetThreadContext (active_threads[i], &context);
> +#if defined(__i386__) || defined(__x86_64__)
>         s = context.EFlags & 0x0100;
> +#elif defined(__aarch64__)
> +      s = context.Cpsr & 0x00200000; /* PSTATE.SS (single step) flag */
> +#else
> +#error unimplemented for this target
> +#endif
>         if (!s && thread_step_flags[i])
>        {
>          set_step_threads (active_thread_ids[i], 1);
> @@ -257,6 +307,25 @@ dump_registers (HANDLE thread)
>          context.Rax, context.Rbx, context.Rcx, context.Rdx);
>     printf ("esi %016llx edi %016llx ebp %016llx esp %016llx %016llx\n",
>          context.Rsi, context.Rdi, context.Rbp, context.Rsp, context.Rip);
> +#elif defined(__aarch64__)
> +  printf ("x0 %016llx x1 %016llx x2 %016llx x3 %016llx\n",
> +       context.X[0], context.X[1], context.X[2], context.X[3]);
> +  printf ("x4 %016llx x5 %016llx x6 %016llx x7 %016llx\n",
> +       context.X[4], context.X[5], context.X[6], context.X[7]);
> +  printf ("x8 %016llx x9 %016llx x10 %016llx x11 %016llx\n",
> +       context.X[8], context.X[9], context.X[10], context.X[11]);
> +  printf ("x12 %016llx x13 %016llx x14 %016llx x15 %016llx\n",
> +       context.X[12], context.X[13], context.X[14], context.X[15]);
> +  printf ("x16 %016llx x17 %016llx x18 %016llx x19 %016llx\n",
> +       context.X[16], context.X[17], context.X[18], context.X[19]);
> +  printf ("x20 %016llx x21 %016llx x22 %016llx x23 %016llx\n",
> +       context.X[20], context.X[21], context.X[22], context.X[23]);
> +  printf ("x24 %016llx x25 %016llx x26 %016llx x27 %016llx\n",
> +       context.X[24], context.X[25], context.X[26], context.X[27]);
> +  printf ("x28 %016llx fp %016llx lr %016llx\n",
> +       context.X[28], context.Fp, context.Lr);
> +  printf ("sp %016llx pc %016llx cpsr %08x\n",
> +       context.Sp, context.Pc, context.Cpsr);
>   #else
>   #error unimplemented for this target
>   #endif
> @@ -450,11 +519,17 @@ run_program (char *cmdline)
>            case STATUS_BREAKPOINT:
>              if (remove_breakpoint ((CONTEXT_REG)event.u.Exception.ExceptionRecord.ExceptionAddress))
>              {
> +#if defined(__aarch64__)
> +             if (!rv)
> +               SetThreadContext (hThread, &context);
> +             thread_return_address[tix] = context.Lr;
> +#else
>                context.CONTEXT_IP --;
>                if (!rv)
>                  SetThreadContext (hThread, &context);
>                if (ReadProcessMemory (hProcess, (void *)context.CONTEXT_SP, &rv, sizeof(rv), &rv))
>                    thread_return_address[tix] = rv;
> +#endif
>              }
>              set_step_threads (event.dwThreadId, stepping_enabled);
>              /*FALLTHRU*/
> @@ -462,6 +537,9 @@ run_program (char *cmdline)
>              opcode_count++;
>              pc = (CONTEXT_REG)event.u.Exception.ExceptionRecord.ExceptionAddress;
>              sp = context.CONTEXT_SP;
> +#if defined(__aarch64__)
> +           lr = context.Lr;
> +#endif
>              if (tracing_enabled)
>              fprintf (tracefile, CONTEXT_REG_FMT " %08x\n", pc, (int)event.dwThreadId);
>              if (trace_console)
> @@ -486,20 +564,34 @@ run_program (char *cmdline)
>                  }
>              }
> 
> -           if (pc < last_pc || pc > last_pc+10)
> +       if (pc < last_pc || pc > last_pc+10)

Incorrect whitespace change. (This line needs to be at least as indented 
as the case label above it belongs to).

>              {
>                static int ncalls=0;
>                static int qq=0;
>                if (++qq % 100 == 0)
>                  fprintf (stderr, " " CONTEXT_REG_FMT " %d %d \r",
>                        pc, ncalls, opcode_count);
> -
> +#if defined(__aarch64__)
> +             if (lr != last_lr && lr == last_pc + 4)
> +#else
>                if (sp == last_sp-sizeof(CONTEXT_REG))
> +#endif
>                  {
>                    ncalls++;
>                    store_call_edge (last_pc, pc);
>                    if (last_pc < KERNEL_ADDR && pc > KERNEL_ADDR)
> -                 {
> +                       {
> +#if defined(__aarch64__)
> +                   CONTEXT_REG retaddr = lr;
> +                   if (verbose)
> +                   printf ("skip kernel call: " CONTEXT_REG_FMT " -> " CONTEXT_REG_FMT ", ret = " CONTEXT_REG_FMT "\n",
> +                               last_pc, pc, retaddr);
> +                   if (retaddr && retaddr < KERNEL_ADDR)
> +                     {
> +                       add_breakpoint (retaddr);
> +                       set_step_threads (event.dwThreadId, 0);
> +                     }
> +#else
>   #if 0
>                      CONTEXT_REG retaddr;
>                      SIZE_T rv;
> @@ -513,13 +605,17 @@ run_program (char *cmdline)
>                      add_breakpoint (retaddr);
>                      set_step_threads (event.dwThreadId, 0);
>   #endif
> -                 }
> +#endif
> +                       }
>                  }
>              }
> 
>              total_cycles++;
>              last_sp = sp;
>              last_pc = pc;
> +#if defined(__aarch64__)
> +           last_lr = lr;
> +#endif
>              if (pc >= low_pc && pc < high_pc)
>              hits[(pc - low_pc)/2] ++;
>              break;
> @@ -534,7 +630,12 @@ run_program (char *cmdline)
>                  dump_registers (hThread);
>              }
>              contv = DBG_EXCEPTION_NOT_HANDLED;
> +#if defined(__aarch64__)
> +           if (!event.u.Exception.dwFirstChance)
> +           running = 0;
> +#else
>              running = 0;
> +#endif

Hmmm... this is probably just generically right, I guess.

>              break;
>            }
> 
> @@ -542,19 +643,39 @@ run_program (char *cmdline)
>            {
>              if (pc == thread_return_address[tix])
>              {
> +#if defined(__i386__) || defined(__x86_64__)
>                if (context.EFlags & 0x100)
>                  {
>                    context.EFlags &= ~0x100; /* TRAP (single step) flag */
>                    SetThreadContext (hThread, &context);
>                  }
> +#elif defined(__aarch64__)
> +             if (context.Cpsr & 0x00200000)
> +               {
> +                 context.Cpsr &= ~0x00200000; /* PSTATE.SS (single step) flag */
> +                 SetThreadContext (hThread, &context);
> +               }
> +#else
> +#error unimplemented for this target
> +#endif
>              }
>              else if (stepping_enabled)
>              {
> +#if defined(__i386__) || defined(__x86_64__)
>                if (!(context.EFlags & 0x100))
>                  {
>                    context.EFlags |= 0x100; /* TRAP (single step) flag */
>                    SetThreadContext (hThread, &context);
>                  }
> +#elif defined(__aarch64__)
> +             if (!(context.Cpsr & 0x00200000))
> +               {
> +                 context.Cpsr |= 0x00200000; /* PSTATE.SS (single step) flag */
> +                 SetThreadContext (hThread, &context);
> +               }
> +#else
> +#error unimplemented for this target
> +#endif
>              }
>            }
>          break;
> @@ -916,10 +1037,17 @@ main (int argc, char **argv)
>       }
>     memset (hits, 0, range+4);
> 
> -  fprintf (stderr, "prun: [" CONTEXT_REG_FMT "," CONTEXT_REG_FMT "] Running '%s'\n",
> +    fprintf (stderr, "prun: [" CONTEXT_REG_FMT "," CONTEXT_REG_FMT "] Running '%s'\n",

Whitespace change?

>          low_pc, high_pc, argv[optind]);
> -
> -  run_program (argv[optind]);
> +  {
> +    char *cmdline_copy = strdup (argv[optind]);
> +    if (!cmdline_copy)
> +      {
> +     fprintf (stderr, "Out of memory duplicating cmdline\n");
> +     exit (1);
> +      }
> +    run_program (cmdline_copy);
> +  }
  A comment about why we need to make copy of the cmdline would be nice.

(it just says "fix" in the patch commentary, but I haven't a clue what 
it's fixing)

