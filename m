Return-Path: <cygwin-patches-return-7412-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6654 invoked by alias); 29 May 2011 08:42:12 -0000
Received: (qmail 6638 invoked by uid 22791); 29 May 2011 08:42:10 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TW_DB
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 29 May 2011 08:41:40 +0000
Received: (qmail 3180 invoked by uid 107); 29 May 2011 05:51:35 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Sun, 29 May 2011 07:51:35 +0200
Message-ID: <4DE1DEE7.8030307@cs.utoronto.ca>
Date: Sun, 29 May 2011 08:42:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Bug in cmalloc? Was: Re: Problems with: Improvements to fork handling (2/5)
References: <4DCAD609.70106@cs.utoronto.ca> <20110528205000.GA30326@ednor.casa.cgf.cx> <4DE179DE.8040008@cs.utoronto.ca> <20110529002317.GA31865@ednor.casa.cgf.cx> <4DE1B101.4000603@cs.utoronto.ca> <4DE1CD9D.20608@gmail.com>
In-Reply-To: <4DE1CD9D.20608@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00178.txt.bz2

On 29/05/2011 12:37 AM, Daniel Colascione wrote:
> On 5/28/11 7:35 PM, Ryan Johnson wrote:
>> On 28/05/2011 8:23 PM, Christopher Faylor wrote:
>>> On Sat, May 28, 2011 at 06:40:30PM -0400, Ryan Johnson wrote:
>>>> On 28/05/2011 4:50 PM, Christopher Faylor wrote:
>>>>> On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>>>>>> This patch has the parent sort its dll list topologically by
>>>>>> dependencies. Previously, attempts to load a DLL_LOAD dll risked
>>>>>> pulling
>>>>>> in dependencies automatically, and the latter would then not benefit
>>>>> >from the code which "encourages" them to land in the right places. The
>>>>>> dependency tracking is achieved using a simple class which allows to
>>>>>> introspect a mapped dll image and pull out the dependencies it lists.
>>>>>> The code currently rebuilds the dependency list at every fork rather
>>>>>> than attempt to update it properly as modules are loaded and unloaded.
>>>>>> Note that the topsort optimization affects only cygwin dlls, so any
>>>>>> windows dlls which are pulled in dynamically (directly or indirectly)
>>>>>> will still impose the usual risk of address space clobbers.
>>>>> Bad news.
>>>>>
>>>>> I applied this patch and the one after it but then noticed that zsh
>>>>> started
>>>>> producing:  "bad address: " errors.
>>>>>
>>>>> path:4: bad address: /share/bin/dopath
>>>>> term:1: bad address: /bin/tee
>>>>>
>>>>> The errors disappear when I back this patch out.
>>>>>
>>>>> FWIW, I was running "zsh -l".  I have somewhat complicated
>>>>> .zshrc/.zlogin/.zshenv files.  I'll post them if needed.
>>>>>
>>>>> Until this is fixed, this patch and the subsequent ones which rely on
>>>>> it, can't go in.  I did commit this fix but it has been backed out now.
>>>> Hmm. I also see bad address errors in bash sometimes. However, when I
>>>> searched through the cygwin mailing list archives I saw that other
>>>> people have reported this problem in the past [1], so I figured it was
>>>> some existing, sporadic issue rather than my patch...
>>>>
>>>> Could you tell me what a 'bad address' error is? I'd be happy to debug
>>>> this, but really don't know what kind of bug I'm hunting here, except
>>>> that it might be a problem wow64 and suspending threads [2]. Whatever
>>>> became of these bad address errors the last time(s) they cropped up? I
>>>> can't find any resolution with Google, at least.
>>> If I had any insight beyond "It works without the patch and it doesn't
>>> work with it" I would have shared it.
>> Let me rephrase a bit... The error happens too early in fork for gdb to
>> be any help, and I was hoping you could tell me what part(s) of cygwin
>> are capable of "raising" this error -- it seems to be a linux (not
>> Windows) flavor of error message, but the case-insensitive regexp
>> 'bad.address' does not match anything in the cygwin sources.
> The actual string is in strerror.c in newlib, which is why you didn't
> find it with a grep on winsup/cygwin. The error code is EFAULT. There
> are 127 places in the cygwin1.dll where EFAULT can raised, according to
> grep '\bEFAULT\b' *.cc. In most of them, EFAULT is raised after
> something called san has detected that to Windows raised an unexpected
> structured exception. My hunch would be to look in spawn.cc first, in
> spawn_guts, but I haven't read your patch in enough detail to narrow the
> problem down further. strace might be handy.
Wow. You nailed it. I fired up windbg and had it follow a cmd.exe into 
bash --login and descendants, and sure enough, there was an access 
violation when spawn_guts called build_env and the latter called cmalloc.

Anyway, after a long and twisty debug session, I have reason to believe 
that either cmalloc/cfree is buggy, or the bug resides somewhere else 
entirely and my patch just tickles it: freeing memory in the reverse 
order it was allocated in causes Bad Things (tm) to happen, even on an 
unpatched version of my 12 May CVS snapshot (which predates my fork 
patches).

It is a known/intentional restriction of the HEAP_2_DLL that memory must 
be freed in the order it was allocated? The default cygheap most likely 
has the problem as well -- that's why I was crashing and had to call 
cmalloc instead of crealloc(NULL, ...).

(Hairy details and test case below)

Ryan

Details: Disabling the topsort call fixed the problem (no surprise), as 
did allocating dependencies from static storage rather than calling 
malloc. I worried the latter just masked the bug, and sure enough, 
calling cmalloc/cfree on dummy data during the sort brought the bug back 
-- even though the cmalloc'd memory was never touched (??). However, 
calling cmalloc/cfree once per dll instead of performing the topsort did 
not trigger the bug. Reversing order of the list (with cmalloc'd 
dependencies) instead of topsorting it caused the bug to come back.

So, I defined this small function:

static void break_cmalloc(int depth, int maxdepth) {
     void* x = cmalloc (HEAP_2_DLL, 32);
     cfree(x);
     if (depth < maxdepth)
         break_cmalloc(depth+1, maxdepth);
}

and called it during fork instead of dlls.topsort(), with maxdepth=5. No 
bug (as expected).

Then I moved the call to cfree below the recursion, so memory gets freed 
in reverse order. Bang. Bash goes down and takes mintty with it after 
briefly flashing 'bad address.' Calling bash from cmd.exe hangs the 
latter so badly Windows can't kill it (I guess I'll have to reboot).

I rolled back to the last CVS checkout I did (May 12), and the above 
function reproduces the bug there as well. AFAIK, Corinna had merged my 
/proc/maps patch by then, but the only fork-related changes were to fix 
the uninitialized value in that one constructor, and to make failed 
forkees not call dtors.
