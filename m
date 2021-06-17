Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 59E88385780B
 for <cygwin-patches@cygwin.com>; Thu, 17 Jun 2021 07:14:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 59E88385780B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 15H5x4QY073025
 for <cygwin-patches@cygwin.com>; Wed, 16 Jun 2021 22:59:04 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.20]"
 via SMTP by m0.truegem.net, id smtpdDSv8ee; Wed Jun 16 22:59:02 2021
Subject: Re: [PATCH] Cygwin: New tool: cygmon
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210612064639.2107-1-mark@maxrnd.com>
 <30137899-0301-3616-5f77-298259ca414b@dronecode.org.uk>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <e5827309-3de5-e449-a5cf-0d2c2507891c@maxrnd.com>
Date: Wed, 16 Jun 2021 22:59:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <30137899-0301-3616-5f77-298259ca414b@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00, BODY_8BITS,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Thu, 17 Jun 2021 07:14:11 -0000

Hi Jon,

I appreciate your review.  I will fold the suggestions from your short email plus 
this longer email into a v2 patch fairly soon.

Jon Turney wrote:
> On 12/06/2021 07:46, Mark Geisert wrote:
> 
>> diff --git a/winsup/utils/cygmon.cc b/winsup/utils/cygmon.cc
>> new file mode 100644
>> index 000000000..9156b27d7
>> --- /dev/null
>> +++ b/winsup/utils/cygmon.cc
[...]
>> +#include "../cygwin/include/sys/cygwin.h"
>> +#include "../cygwin/include/cygwin/version.h"
>> +#include "../cygwin/cygtls_padsize.h"
>> +#include "../cygwin/gcc_seh.h"
> 
> The latest Makefile.am sets things up so these relative paths aren't needed.

Oh yes, I saw those go by but have not made use of the changes.  Will do.

>> +typedef unsigned short ushort;
>> +typedef uint16_t u_int16_t; // to work around ancient gmon.h usage
> 
> 'Non-standard sized type needed by ancient gmon.h' might be clearer

Indeed, thanks.  Will update.

>> +#include "../cygwin/gmon.h"
[...]
>> +size_t
>> +sample (HANDLE h)
>> +{
>> +  static CONTEXT *context = NULL;
>> +  size_t status;
>> +
>> +  if (!context)
>> +    {
>> +      context = (CONTEXT *) calloc (1, sizeof (CONTEXT));
>> +      context->ContextFlags = CONTEXT_CONTROL;
>> +    }
> 
> Why isn't this just 'static CONTEXT'?
> 
> But it also shouldn't be static, because this function needs to be thread-safe as 
> it is called by the profiler thread for every inferior process?

Oof, I must've gotten sidetracked off of coding the change from static to auto by 
a squirrel or a shiny disc or something.  Yes, the local context buffer needs to 
be thread-safe in case of multiple children being profiled.  I knew that...

[...]
>> +  else
>> +//TODO this approach might not support 32-bit executables on 64-bit
> 
> It definitely doesn't. But that's fine.

Will make the comment more definitive.

[...]
>> +void
>> +start_profiler (child *c)
>> +{
>> +  DWORD  tid;
>> +
>> +  if (verbose)
>> +    note ("*** start profiler thread on pid %lu\n", c->pid);
>> +  c->hquitevt = CreateEvent (NULL, TRUE, FALSE, NULL);
>> +  if (!c->hquitevt)
>> +    error (0, "unable to create quit event\n");
>> +  c->profiling = 1;
>> +  c->hprofthr = CreateThread (NULL, 0, profiler, (void *) c, 0, &tid);
>> +  if (!c->hprofthr)
>> +    error (0, "unable to create profiling thread\n");
>> +
>> +//SetThreadPriority (c->hprofthr, THREAD_PRIORITY_TIME_CRITICAL); Don't do this!
> 
> But now I want to see what happens when I do!

You'll be sorry, but yeah the warning here is important because there's a real 
temptation here to do something, anything.. I'll make it more descriptive.

[...]
>> +      fd = open (filename, O_CREAT | O_TRUNC | O_WRONLY | O_BINARY);
[...]
>> +      close (fd);
>> +      chmod (filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);//XXX ineffective
> 
> ???

For the life of me I could not figure out how to make the output file mode 0644 
with either open() flags or chmod() afterwards.  I keep getting unwanted 'x' bits 
set.  Perhaps a side-effect of this being a native program rather than a Cygwin 
program.  I just flagged it until I can resolve it.

[...]
>> +void
>> +info_profile_file (char *filename)
> 
> I think this should be a separate tool, since it's not really part of the function 
> of this tool.

Yeah, I guess so.  I didn't think of that option.  I just saw this as too big to 
be a Cygwin-specific patch to gprof, where it could plausibly go.  I will split 
this out to a separate tool called 'gmoninfo' or some such.  Suggestions welcome.

[...]
>> +IMAGE_SECTION_HEADER *
>> +find_text_section (LPVOID base, HANDLE h)
>> +{
>> +  static IMAGE_SECTION_HEADER asect;
>> +  DWORD  lfanew;
>> +  WORD   machine;
>> +  WORD   nsects;
>> +  DWORD  ntsig;
>> +  char  *ptr = (char *) base;
>> +
>> +  IMAGE_DOS_HEADER *idh = (IMAGE_DOS_HEADER *) ptr;
>> +  read_child ((void *) &lfanew, sizeof (lfanew), &idh->e_lfanew, h);
>> +  ptr += lfanew;
>> +
>> +  /* Code handles 32- or 64-bit headers depending on compilation environment. */
>> +  /*TODO It doesn't yet handle 32-bit headers on 64-bit Cygwin or v/v.        */
>> +  IMAGE_NT_HEADERS *inth = (IMAGE_NT_HEADERS *) ptr;
>> +  read_child ((void *) &ntsig, sizeof (ntsig), &inth->Signature, h);
>> +  if (ntsig != IMAGE_NT_SIGNATURE)
>> +    error (0, "find_text_section: NT signature not found\n");
>> +
>> +  read_child ((void *) &machine, sizeof (machine),
>> +              &inth->FileHeader.Machine, h);
>> +#ifdef __x86_64__
>> +  if (machine != IMAGE_FILE_MACHINE_AMD64)
>> +#else
>> +  if (machine != IMAGE_FILE_MACHINE_I386)
>> +#endif
>> +    error (0, "target program was built for different machine architecture\n");
>> +
>> +  read_child ((void *) &nsects, sizeof (nsects),
>> +              &inth->FileHeader.NumberOfSections, h);
>> +  ptr += sizeof (*inth);
>> +
>> +  IMAGE_SECTION_HEADER *ish = (IMAGE_SECTION_HEADER *) ptr;
>> +  for (int i = 0; i < nsects; i++)
>> +    {
>> +      read_child ((void *) &asect, sizeof (asect), ish, h);
>> +      if (0 == memcmp (".text\0\0\0", &asect.Name, 8))
>> +        return &asect;
>> +      ish++;
>> +    }
> 
> While this is adequate and correct in 99% of cases, I think what you're perhaps 
> looking for here is sections which are executable?

I suppose so, but since the gmon.out files (and gprof) can't deal with disjoint 
address spans directly that would mean an additional gmon.out file for each span. 
It could work, but I'm vaguely disturbed by the idea.

> (Well, really we want to enumerate executable memory regions in the inferior, to 
> profile dynamically generated code as well, but...)

Even more disturbing :), but yes, could be done.  At some point the linear search 
for which sampling buffer to bump a bucket in might need changing to a hashed 
lookup...

[...]
>> +int
>> +load_cygwin ()
>> +{
> 
> So: I wonder if this tool should just link with the cygwin DLL.
> 
> I think the historical reason for strace to not be a cygwin executable is so that 
> it can be used to debug problems with cygwin executables startup.
> 
> I don't think that reason applies here?

You're correct that that reason doesn't apply here.  Making this a Cygwin program 
would also make it much easier to debug!  IIRC I started writing this as a Cygwin 
program but switched to a native Windows model when I started cribbing code from 
strace.  But I guess in hindsight it wasn't really necessary to switch.  Thanks 
for bringing this up for consideration.

Thanks & Regards,

..mark
