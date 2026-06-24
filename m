Return-Path: <SRS0=WipY=EU=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id C943E4BA543C
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 07:18:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C943E4BA543C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C943E4BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782285486; cv=none;
	b=RL/a/VQiVWg4tx6rIpgUYq57sviRZ1wpvxl4Ta2W0nwVtvoB1w5jsdPeNEfmG/VH7+3Dnn+4HiatUXA01p6gznrkgqnzcmH1LPRUv88IqrVAAqVORIEqcC2ARDnGAWNxPTNILg8f8p6+nx/+zPahSml40Gwexb9bguPN6n7ZY9Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782285486; c=relaxed/simple;
	bh=CXyXmljumUiQSJ12jl16KALlEDZ7wtyU2LV9xZz8y0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=TNKvHzN90C5Tqoh5ZlDpxBpUA01HhWRvGTIwKKUv89D55CUSJpT8eb0U2anTQX1F4nDZNOQoi1VCwQiDSXVKi6dbtP+v8bw+4qAQZ3695i0NSXdH6mcsBJ0nLZVYU2U36uqyP8QyvXpqi2LRTZ6nswgN8iXyYDVELXETeLpNewY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C943E4BA543C
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65O7X6Dx038119
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 00:33:06 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdaQSyGm; Wed Jun 24 00:32:58 2026
Message-ID: <137d80a5-72fe-431a-95d5-67f00f058865@maxrnd.com>
Date: Wed, 24 Jun 2026 00:17:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app
 exits
To: cygwin-patches@cygwin.com
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
 <20260613140917.27155-4-takashi.yano@nifty.ne.jp>
 <dd205968-3113-4010-b1b4-18d9e574ca97@maxrnd.com>
 <20260623223155.15a0159ca60f33284ad6699b@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260623223155.15a0159ca60f33284ad6699b@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

All of your corrections and additions LGTM.  This one can be pushed.
Thanks,

..mark

On 6/23/2026 6:31 AM, Takashi Yano wrote:
> Hi Mark,
> 
> Thanks for reviewing.
> 
> On Tue, 23 Jun 2026 01:07:16 -0700
> Mark Geisert  wrote:
>> Hi Takashi,
>>
>> On 6/13/2026 7:09 AM, Takashi Yano wrote:
>>> Previously, the cygwin process on pty is always a child of another
>>> cygwin app on pty. If a cygwin app is a child of non-cygwin app
>>> in pseudo console, it was running on console originating from
>>> pseudo console. Now, the child of a non-cygwin app on pseudo console
>>> is running on pty, so, it is necessary to restore the pty state
>>> to the state where the parent process is running. This patch
>>> does the following fixup:
>>>    1) Switch pipe mode to cyg-pipe to nat-pipe.
>>                           ^^^^^^^^^^^^^^^^^^^^^^^ this can't be correct
> 
> Auch! "from cyg-pipe to nat-pipe"
>>
>>>    2) Notify the current cursor position to pseudo console
>>>
>>> These prevent the problems:
>>>    1) Run 'cat' in cmd.exe and stop it by Ctrl-C. After that
>>>       cmd.exe cannot receive key input.
>>>    2) Run 'ps' in cmd.exe. The cursor position will not be
>>>       maintained correctly after that.
>>>
>>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>>> Reviewed-by:
>>> ---
>>>    winsup/cygwin/fhandler/pty.cc           | 73 ++++++++++++++++++++++++-
>>>    winsup/cygwin/local_includes/fhandler.h |  2 +
>>>    winsup/cygwin/local_includes/tty.h      |  1 +
>>>    3 files changed, 73 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
>>> index b3a8d57cc..f4473bb69 100644
>>> --- a/winsup/cygwin/fhandler/pty.cc
>>> +++ b/winsup/cygwin/fhandler/pty.cc
>>> @@ -388,6 +388,52 @@ atexit_func (void)
>>>        }
>>>    }
>>>    
>>> +void
>>> +fhandler_pty_slave::req_fixup_pcon_state (void)
>>> +{
>>> +  while (true)
>>> +    {
>>> +      WaitForSingleObject (input_mutex, mutex_timeout);
>>> +      if (!get_ttyp ()->pcon_start_pid)
>>> +	break;
>>> +      /* Another request is on going. */
>>> +      ReleaseMutex (input_mutex);
>>> +      yield ();
>>> +    }
>>> +
>>> +  DWORD n;
>>> +  /* indicates that this "ESC[6n" is just for fixing-up corsor position */
>>                                                              ^^^^^^ typo here
> 
> Fixed.
> 
>>> +  get_ttyp ()->req_fixup_pcon_cur_pos = true;
>>> +  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
>>> +					 is just for transfer input */
>>> +  get_ttyp ()->pcon_start = true;
>>> +  get_ttyp ()->pcon_start_pid = myself->pid;
>>> +  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
>>> +  ReleaseMutex (input_mutex);
>>> +  while (get_ttyp ()->pcon_start_pid)
>>> +    /* wait for completion of fixing-up in master::write(). */
>>> +    yield ();
>>> +}
>>> +
>>> +void
>>> +fhandler_pty_master::fixup_pcon_cursor_position (int x, int y)
>>> +{
>>> +  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
>>> +				   get_ttyp ()->nat_pipe_owner_pid);
>>> +  HANDLE h_pcon_out = NULL;
>>> +  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
>>> +		   GetCurrentProcess (), &h_pcon_out,
>>> +		   0, TRUE, DUPLICATE_SAME_ACCESS);
>>> +  CloseHandle (pcon_owner);
>>> +  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
>>> +  DWORD resume_pid =
>>> +    fhandler_pty_common::attach_console_temporarily (target_pid);
>>> +  COORD cur_pos = {(SHORT) (x - 1), (SHORT) (y - 1)};
>>> +  SetConsoleCursorPosition (h_pcon_out, cur_pos);
>>> +  fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
>>> +  CloseHandle (h_pcon_out);
>>> +}
>>> +
>>>    #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
>>>    /* CreateProcess() is hooked for GDB etc. */
>>>    DEF_HOOK (CreateProcessA);
>>> @@ -1162,6 +1208,19 @@ err_no_msg:
>>>    bool
>>>    fhandler_pty_slave::open_setup (int flags)
>>>    {
>>> +  if (get_ttyp ()->pcon_activated)
>>> +    {
>>> +      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
>>> +				       get_ttyp ()->nat_pipe_owner_pid);
>>> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
>>> +		       GetCurrentProcess (), &get_handle_nat (),
>>> +		       0, TRUE, DUPLICATE_SAME_ACCESS);
>>> +      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
>>> +		       GetCurrentProcess (), &get_output_handle_nat (),
>>> +		       0, TRUE, DUPLICATE_SAME_ACCESS);
>>> +      CloseHandle (pcon_owner);
>>> +    }
>>> +
>>>      set_flags ((flags & ~O_TEXT) | O_BINARY);
>>>      myself->set_ctty (this, flags);
>>>      report_tty_counts (this, "opened", "");
>>> @@ -1171,6 +1230,9 @@ fhandler_pty_slave::open_setup (int flags)
>>>    void
>>>    fhandler_pty_slave::cleanup ()
>>>    {
>>> +  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
>>> +    req_fixup_pcon_state ();
>>> +
>>>      /* This used to always call fhandler_pty_common::close when we were execing
>>>         but that caused multiple closes of the handles associated with this pty.
>>>         Since close_all_files is not called until after the cygwin process has
>>> @@ -2478,7 +2540,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>>>    	      /* req_xfer_input is true if "ESC[6n" was sent just for
>>>    		 triggering transfer_input() in master. In this case,
>>>    		 the response sequence should not be written. */
>>
>> The above comment describes the req_xfer case, but says nothing about
>> the the req_fixup_pcon_cur_pos case now inserted before it.
> 
> I'll modify the comment above like:
>        /* req_fixup_pcon_cur_pos is true if "ESC[6n" was sent
>           for requesting cursor-position-fixup that is needed
>           when a non-cygwin app executes a cygwin app and the
>           cygwin app exits.
>           req_xfer_input is true if "ESC[6n" was sent just for
>           triggering transfer_input() in master. In this case,
>           the response sequence should not be written. */
> 
> Does this look OK to you?

That's great!

..mark
