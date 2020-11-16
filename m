Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.9])
 by sourceware.org (Postfix) with ESMTPS id 7F8393861838
 for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020 23:15:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7F8393861838
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id eniekQGdk34axenifklLft; Mon, 16 Nov 2020 16:15:33 -0700
X-Authority-Analysis: v=2.4 cv=LvQsdlRc c=1 sm=1 tr=0 ts=5fb30815
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=zJoJJQHGIN9gWLaHCs4A:9 a=QEXdDO2ut3YA:10
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <072e5252-9056-2af8-bf62-caec89830d38@SystematicSw.ab.ca>
 <20201116120721.GA41926@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: proc(5) and xml version
Message-ID: <080e2620-eb31-1206-76c9-eb3cb49b796c@SystematicSw.ab.ca>
Date: Mon, 16 Nov 2020 16:15:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116120721.GA41926@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO4ho2isf2I7qLM2UBRT4x8eosdGaGvAKq9ovTgz2mlbVX2uSIUha5fPHBeuaudIQMZspchCbaGyCXl2jpV4adELN17QUqMaLwKuJjFRcH1CF8e+WTkT
 L43RFGaln8OqlVChOrEzbi8k/7qwS/N+V9zcSdyfwJWK1ZTmAFZMJWOYPtKOpHz5wWD1DDxOmw09xgv5+wMlfdRUAc6y/Muqtjk=
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 16 Nov 2020 23:15:36 -0000

On 2020-11-16 05:07, Corinna Vinschen wrote:
> Hi Brain,
> 
> On Nov 13 07:25, Brian Inglis wrote:
>> Hacked a Cygwin proc.5 man page FMOI over time, by combing through
>> fhandler_proc..., converted to proc-5.xml using doclifter, back with xmlto
>> as in the build, man width 80 output from both, and diff (all attached).
> 
> Nice idea!
> 
>> Unsure how this might best be fitted into the distro (cygwin, cygwin-doc,
>> ...?) and/or whether there may be xml remediation possible to generate
>> verbatim output left justified with zero margin, and character value
>> displays, the major output issues in the diff? Content feedback is also
>> welcome.
> 
> This could replace the pathnames-proc and pathnames-proc-registry
> sections in specialnames.xml.

Thanks, my searches failed to find that section, so I'll check that out, compare 
to gauge ease of update, and use Jon's info.

> I think by using the refentry markup the man page would be generated
> automagically, but Jon (CCed) is the definitiv source of wisdom here.
> 
> A few comments in terms of the content...
> 
>> The
>> .I /proc/[pid]
>> subdirectories are visible when iterating through
>> .I /proc
>> with
>> .BR getdents (2)
>        ^^^^^^^^
> 
> We don't have that system call.  readdir(2) is the matching, exposed API.
> 
>> .I /proc/[pid]/environ
>> This read-only file contains the initial environment that was set
>> when the currently executing program was started via
>> .BR execve (2).
> 
> Neither Cygwin nor Windows maintain the initial environment.  What you
> get is the current environment, with all changes performed by the process
> itself.
> 
>> If, after an
>> .BR execve (2),
>> the process modifies its environment
>> (e.g., by calling functions such as
>> .BR putenv (3)
>> or modifying the
>> .BR environ (7)
>> variable directly),
>> this file will
>> .I not
>> reflect those changes.
> 
> Yeah, see above.
> 
>> .IR /proc/[pid]/mounts
>> file, and fixes various other problems with that file
>> (e.g., nonextensibility,
>> failure to distinguish per-mount versus per-superblock options).
>> .IP
>> The file contains lines of the form:
>> .IP
>> .in 0n
>> .EX
>> 36 35 98:0 /mnt1 /mnt2 rw,noatime master:1 \- ext3 /dev/root rw,errors=continue
>> (1)(2)(3)   (4)   (5)      (6)      (7)   (8) (9)   (10)         (11)
>> .in
>> .EE
>> .IP
>> The numbers in parentheses are labels for the descriptions below:
>> .RS 7
>> .TP 5
>> (1)
>> mount ID: a unique ID for the mount (may be reused after
>> .BR umount (2)).
>> .TP
>> (2)
>> parent ID: the ID of the parent mount
>> (or of self for the root of this mount namespace's mount tree).
> 
> Has no meaning in Cygwin, it's just the same number as (1).
> 
>> If the parent mount point lies outside the process's root directory (see
>> .BR chroot (2)),
>> the ID shown here won't have a corresponding record in
> 
> That affects chroot as well.  I'd rather not mention this function
> call anyway, it was a bad idea in the first place.
> 
>> .I mountinfo
>> whose mount ID (field 1) matches this parent mount ID
>> (because mount points that lie outside the process's root directory
>> are not shown in
>> .IR mountinfo ).
>> As a special case of this point,
>> the process's root mount point may have a parent mount
>> (for the initramfs filesystem) that lies
>> .\" Miklos Szeredi, Nov 2017: The hidden one is the initramfs, I believe
>> .\" mtk: In the initial mount namespace, this hidden ID has the value 0
>> outside the process's root directory,
>> and an entry for that mount point will not appear in
> 
> I think this can entirely go away either.
> 
>> (7)
>> optional fields: zero or more fields of the form "tag[:value]"; see below.
> 
> This field doesn't exist on Cygwin.  Do we have to update the output
> to follow current Linux?
> 
>> .TP
>> (8)
>> separator: the end of the optional fields is marked by a single hyphen.
> 
> So that's field 7.
> 
>> .TP
>> (9)
>> filesystem type: the filesystem type in the form "type[.subtype]".
> 
> Field 8
> 
>> .TP
>> (10)
>> mount source: filesystem-specific information or "none".
> 
> Field 9
> 
>> .TP
>> (11)
>> super options: per-superblock options (see
>> .BR mount (2)).
> 
> Field 10, always ro or rw, so it's just the info if the filesystem is
> read-only or read-write
> 
>> .I /proc/[pid]/stat
>> Status information about the process.
>> This is used by
>> .BR ps (1).
> 
> Only by ps from the procps package
> 
>> One of the following characters, indicating process state:
>> .RS
>> .IP R 3
>> Runnable
>> .IP O
>> Running
> 
> We don't generate O, but I don't quite grok why.  There is a per-Thread
> StateRunning state in Windows, so I don't see why the code doesn't just
> use it.  A process with a single thread in StateRunning is running, no?
> 
>> .IP S
>> Sleeping in an interruptible wait
>> .IP D
>> Waiting in uninterruptible
>> disk sleep
> 
> We don't know the 'D' state.
> 
>> (14) \fIutime\fP \ %lu
>> Amount of time that this process has been scheduled in user mode,
>> measured in clock ticks (divide by
>> .IR sysconf(_SC_CLK_TCK) ).
> 
> This includes Cygwin time.
> 
>> This includes guest time, \fIguest_time\fP
>> (time spent running a virtual CPU, see below),
>> so that applications that are not aware of the guest time field
>> do not lose that time from their calculations.
> 
> The guest time hints should go away, I think.
> 
>> (16) \fIcutime\fP \ %ld
>> (17) \fIcstime\fP \ %ld
> 
> Faked.
> 
>> (20) \fInum_threads\fP \ %ld
>> Number of threads in this process.
> 
> Always 0, albeit we probably could print this info.
> 
>> This file is a symbolic link that points to the user's
>> Windows mapped drive mount point, and behaves in the same way as
>> .IR root .
> 
> I don't understand what you're trying to say here.
> 
>> Incidentally, this file may be used by
>> .BR mount (8)
>> when no filesystem is specified and it didn't manage to determine the
>> filesystem type.
>> Then filesystems contained in this file are tried
>> (excepted those that are marked with "nodev").
> 
> Doesn't work that way on Cygwin
> 
>> .I /proc/sys
>> This directory contains a number of files
>> and subdirectories corresponding to kernel variables.
>> These variables can be read using
>> the \fI/proc\fP filesystem, and the (deprecated)
>> .BR sysctl (2)
>> system call.
> 
> This is wrong for Cygwin.  /proc/sys is kind of a mount point, pointing
> into the native NT object namespace.  E.g., /proc/sys/GLOBAL?? is the
> native NT directory containing native NT object namespace symlinks
> constituting the DOS device names as returned by the QueryDosDevice
> WinAPI call.  Global?? is the global subdir available to all sessions.
> Session-specific ?? dirs exist
> 
> https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file#nt-namespaces may be helpful here.
> 
>> These files list the System V Interprocess Communication (IPC) objects
>> (respectively: message queues, semaphores, and shared memory)
>> that currently exist on the system,
>> providing similar information to that available via
>> .BR ipcs (1).
>> These files have headers and are formatted (one IPC object per line)
>> for easy understanding.
> 
>> .BR svipc (7)
>> provides further background on the information shown by these files.
> 
> This should be replaced with the info that the files in sysvipc
> are only available if cygserver is running, just as SYSV ipc, too.
> 
>> This string identifies the kernel version that is currently running.
>                               ^^^^^^
>                               Cygwin
>> .SH COLOPHON
>> This page is part of version 3 of
> 
> I would skip that "of version 3" part
> 
> Other than these minor nits, this looks great!

Thanks for that great feedback.
I did careful comparisons of Cygwin vs Linux outputs, and the fhandler_proc... 
and fhandler_process... code, and left known values (status D, O) and suitably 
weasel-worded comments (mounts, mountinfo e.g. zero or more optional...) as is, 
or added some weasel-words, but missed weeding a few irrelevant points which 
I'll cull, change the rest to incorporate the comments, including changing 
"kernel" to Cygwin, make it xml, update, and repost some time in the future...

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
