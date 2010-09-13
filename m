Return-Path: <cygwin-patches-return-7105-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7165 invoked by alias); 13 Sep 2010 11:46:15 -0000
Received: (qmail 7145 invoked by uid 22791); 13 Sep 2010 11:46:09 -0000
X-SWARE-Spam-Status: No, hits=1.8 required=5.0	tests=AWL,BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,TW_NV,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Sep 2010 11:45:58 +0000
Received: by fxm9 with SMTP id 9so4385595fxm.2        for <cygwin-patches@cygwin.com>; Mon, 13 Sep 2010 04:45:55 -0700 (PDT)
Received: by 10.223.114.65 with SMTP id d1mr3395644faq.22.1284378355307;        Mon, 13 Sep 2010 04:45:55 -0700 (PDT)
Received: from [10.71.1.25] (wall-ext.hola.org [212.235.66.73])        by mx.google.com with ESMTPS id k15sm2749485fai.16.2010.09.13.04.45.51        (version=SSLv3 cipher=RC4-MD5);        Mon, 13 Sep 2010 04:45:54 -0700 (PDT)
Message-ID: <4C8E0EED.4000606@gmail.com>
Date: Mon, 13 Sep 2010 11:46:00 -0000
From: Yoni Londner <yonihola2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.12) Gecko/20100824 Thunderbird/3.0.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de>
In-Reply-To: <20100906132409.GB14327@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------040009070507010109050000"
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
X-SW-Source: 2010-q3/txt/msg00065.txt.bz2

This is a multi-part message in MIME format.
--------------040009070507010109050000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 17118

Hi,

 >> Abstract: I prepared a patch that improves Cygwin Filesystem
 >> performance by x4 on Cygwin 1.7.5 (1.7.5 vanilla 530ms -->  1.7.5
 >> patched 120ms). I ported the patch to 1.7.7, did tests, and found
 >> out that 1.7.7 had a very serious 9x (!) performance degradation
 >> from 1.7.5 (1.7.5 vanilla 530ms -->  1.7.7 vanilla 3900ms -->  1.7.7
 >> patched 3500ms), which does makes this patch useless until the
 >> performance degradation is fixed.
 >
 > The problem is, I can't reproduce such a degradation.  If I run sometimg
 > like `time ls -l /bin>  /dev/null', the times are very slightly better
 > with 1.7.7 than with 1.7.5 (without caching effect 1200ms vs. 1500ms,
 > with caching effect 500ms vs. 620ms on average).  Starting with 1.7.6,
 > Cygwin reused handles from symlink_info::check in stat() and other
 > syscalls.  If there is such degradation under some circumstances, I need
 > a reproducible scenario, or at least some strace output which shows at
 > which point this happens.  Apart from actual patches this should be
 > discussed on the cygwin-developer list.
 >

First of all, even your results of 1200-1500ms (1st time) and 500-600ms 
(2nd time) is still way way way too long. On linux with an NTFS mount of 
C:/cygwin, this took <2ms!

And even on Win32 CMD.EXE this same operation will take you less than 
100ms. which is 5x to 10x faster.

The main reason for the difference: the Windows CMD.EXE does not open 
file handles, which make the NTFS file system to actually go and read 
each file's first 16KB of contents (even though you did not ask for it!).

My results above were on XP SP3, with anti-virus installed (which is a 
VERY common scenario in Enterprises).

On Win7 without an anti-virus (except the built-in MS anti-virus), my 
results are:
Without the patch 1.7.7: 800ms
With the patch 1.7.7: 320ms

strace is no good at profiling, since it itself modifies the time-flow 
of the execution.

The correct way to measure performance and pin-point it to specific APIs 
stack-traces is by running the long repeated operations (for example: 
'gdb --args ls -l /bin /usr/bin /etc...' so that it will take a LONG 
time to complete, and then pressing CTRL-C in the middle and seeing 
where it is 'stuck'.

After repeating this 4-5 times you easily see what are the Win32 
syscalls that make it slow, since their stack-trace will reappear again 
and again.

The points in the code that I worked on performance improvements in the 
submitted patch were the places which appeared repeatedly in the 
profiling check I did.

 >> My patch:
 >> ------------
 >
 > First of all, your patch is very certainly significant in terms of code
 > size.  If you want to contribute code from it, we need a signed copyright
 > assignment from you.  See http://cygwin.com/contrib.html, the "Before you
 > get started" section.
 >
 > The patch is also missing a ChangeLog entry.  I only took a quick glance
 > over the patch itself.  The code doesn't look correctly formatted in GNU
 > style.  Also, using the diff -up flags would be helpful.
 >

I sent the copyright assignment by snail.
I the patch again, this time using the '-up' options.
I also 'ifdef'ed my changes, each under a different ifdef, so it can be 
easily read.

 >> So I did some performace test on Cygwin 1.7.5, and found out the
 >> biggest bottleneck were:
 >>
 >> - CreateFile()/CloseHandle() on syscalls that only need file node
 >> info retrival, not file contents retrival (such as stat()). This can
 >> be solved by calling Win32 that do not open the File handle itself,
 >> rather query by name, or opening the directory handle (which is MUCH
 >> faster).
 >
 > That's what I tried to speed up in 1.7.6 by keeping the handle from
 > symlink_info::check for reuse in stat.
 >

Its correct that in 1.7.6 you improved re-using of file handles, yet 
there is still some unnecessary openings of file handles, so my patch 
further improves the re-use in additional code-flows.

The 'PC_KEEP_HANDLE' flag you added in 1.7.6 is nice, but a bit problematic.
In my code I managed in many cases not to open a handle at all, and when 
the caller calls with PC_KEEP_HANDLE, then I must open the handle even 
though it was not needed.

The correct way is to open handles on-demand, exactly where they are 
REALLY needed.
So the check_symlink should always return a handle, IF it opened it, and 
the caller should never assume the handle is already open, and the 
caller should open the handle on-demand only when it ACTUALLY needs the 
handle (in which case it will first check if it already has it open, and 
call CreateFile() if not).

Its important to bring down to zero all the unnecessary file handle 
openings.

 >> - ACLs: Windows is not a secure system. And its ACL model is strange
 >> to say the least... Most cygwin users do not use the unix
 >> permissions system on cygwin to achieve security. All they want is
 >> that the unix tools will run on Windows.
 >
 > I don't agree.  Windows is a secure system on the file level if users
 > use the ACLs correctly.  It's not exactly a strange model, it's just
 > unnecessarily complicated for home users.  However, in corporate
 > environments it's utilized a lot.
 >
 > Besides, I made some performance tests myself before 1.7.6, and it
 > turned out that the ACL checks for testing the POSIX permission bits
 > are really not the problem.  The problem was that ls(1) had a test which
 > resulted in calling getacl() twice, just to print the '+' character
 > attached to the POSIX permission bits in `ls -l' output.  That should
 > have gotten slightly better with the latest coreutils.
 >
 > Other than that, just use the "noacl" mount option if you don't like to
 > be bothered with Windows ACLs or, FWIW, POSIX-like permissions.
 >

ACLs are a huge performance degradation, and the mount opetions are a 
very crud implementation for enable/disable.

Changing a mount option is a little like a 'reboot' to the cygwin 
'operating system'. To change it on C:/ you need to close all cygwin 
apps and reopen them.
Also, it is global. It does not allow some applications to work with 
ACLs, and some without.

For example, if compilation or rsync works 4x faster with ACLs off, but 
you still want ACLs enabled for everything else, you can just do in bash:
alias rsync_fast=CYGWIN=noacl /bin/rsync
alias make_fast=CYGWIN=noacl /bin/make

mount options are global and 'per-boot'.
Since it is such a big performance issue, it shou

Microsoft's moto is to force decisions on the end-user. The unix world 
is all about giving the end-user choice. So why Cygwin not give the end 
user the option to dynamically per-process disable ACLs if he wants to?

My run-time per-process ACL disabling options are in ADDITION to the 
mount options, not instead. Let the end-user will decide what to use.

 >> - stat inode number and inode link count: getting the inode in
 >> Windows requires a File handle or Directory handle (not possible to
 >> get inode by file name). Very few applications actually need a REAL
 >> inode number. So using the 'get file info by name' apis are used
 >> (and of course there is an envirnoment if you really want real inode
 >> numbers).
 >
 > Just use the "ihash" mount option if you don't like to use real inode
 > numbers.  However, you don't see hardlinks anymore.
 >
 > I don't like the idea to extend the CYGWIN environment variable with
 > this functionality at all.  I also don't like the idea that these
 > settings are on by default.  So by default you're trading correctness
 > (in a POSIX sense) for speed.  Speed is all well and nice, but it
 > shouldn't be handled more important than correctness.
 >
 > There are certainly other ways to improve Cygwin's performance, which
 > don't trade in correctness in the first place.  We should more
 > concentrate on intelligent caching of file info and handles.
 >

Again this is a matter of global-static options (via mount), or dynamic 
per process/session options via envirnoment.

Again my patch gives the user an OPTION. He can select via mount options 
AND/OR he can select via envirnoment.

For example, he may select to have everything with ihash (for speed), 
yet he might want a specific rsync operation to preserve hardlinks:
alias rsync_h=rsync --hard-links

Give the end-user choice!

 >> - GetVolumeInfo: The C:\ drive does not tend to be changed every
 >> millisecond! Therefore no reason for every filesystem syscall to
 >> call it. Caching this further increased the performance.
 >
 > Does your FS caching take volume mount points into account?
 >

I think it does, though not 100% sure. Your input on this would be welcome!

 >> - File security check: GetSecurityInfo() is implemented in Windows
 >> in usermode dll (Advapi32.dll). It calls at the end
 >> NtQuerySecurityObject(). So I implemented a faster version:
 >> zGetSecurityInfo() which does the same... just faster.
 >
 > Does your code preserve the inheritance entries which are available via
 > GetSecurityInfo?  Note that I don't care at all for the GetSecurityInfo
 > API from a usage POV.  I would prefer to use NtQuerySecurityObject
 > directly.  However, the sole reason for using GetSecurityInfo is the
 > fact that NtQuerySecurityObject only returns the plain ACL as it's
 > stored for the file.  It does not return the ACEs which are inherited
 > from the parent objects.  These are only available via GetSecurityInfo,
 > or by checking the parent ACLs manually.
 >

I followed the assembly of the Windows It performs exactly what Windows 
user-mode Advapi32.dll does.

So its 100% compatible.

 >> - symbolic link files: Opening a file and reading its contents is an
 >> expensive operation. All file cygwin operations must check whether
 >> the file is a symbolic link or not, which is done by opening the
 >> file and reading its contents and checking whether it has the
 >> symlink magic at the beginning of this. Since symbolic link must be
 >
 > That's not correct.  It only opens files which have cetain DOS flags
 > set.  Symlinks are either files with a SYSTEM DOS flag, or .lnk files
 > with the R/O DOS flag set, or reparse points.  So your extension for
 > the test might help a tiny little bit, but since the SYSTEM attribute
 > is only rarely set on file which are not Cygwin symlinks, it's a very
 > rare operation.

Still: why open a file that is by its size we already know for sure that 
it cannot possibly a symlink?!

Yoni

On 6/9/2010 4:24 PM, Corinna Vinschen wrote:
> Hi Yoni,
>
> On Sep  6 12:52, Yoni Londner wrote:
>> Hi,
>>
>> Abstract: I prepared a patch that improves Cygwin Filesystem
>> performance by x4 on Cygwin 1.7.5 (1.7.5 vanilla 530ms -->  1.7.5
>> patched 120ms). I ported the patch to 1.7.7, did tests, and found
>> out that 1.7.7 had a very serious 9x (!) performance degradation
>> from 1.7.5 (1.7.5 vanilla 530ms -->  1.7.7 vanilla 3900ms -->  1.7.7
>> patched 3500ms), which does makes this patch useless until the
>> performance degradation is fixed.
>
> The problem is, I can't reproduce such a degradation.  If I run sometimg
> like `time ls -l /bin>  /dev/null', the times are very slightly better
> with 1.7.7 than with 1.7.5 (without caching effect 1200ms vs. 1500ms,
> with caching effect 500ms vs. 620ms on average).  Starting with 1.7.6,
> Cygwin reused handles from symlink_info::check in stat() and other
> syscalls.  If there is such degradation under some circumstances, I need
> a reproducible scenario, or at least some strace output which shows at
> which point this happens.  Apart from actual patches this should be
> discussed on the cygwin-developer list.
>
>> =======================================================================
>> My patch:
>> ------------
>
> First of all, your patch is very certainly significant in terms of code
> size.  If you want to contribute code from it, we need a signed copyright
> assignment from you.  See http://cygwin.com/contrib.html, the "Before you
> get started" section.
>
> The patch is also missing a ChangeLog entry.  I only took a quick glance
> over the patch itself.  The code doesn't look correctly formatted in GNU
> style.  Also, using the diff -up flags would be helpful.
>
>> So I did some performace test on Cygwin 1.7.5, and found out the
>> biggest bottleneck were:
>>
>> - CreateFile()/CloseHandle() on syscalls that only need file node
>> info retrival, not file contents retrival (such as stat()). This can
>> be solved by calling Win32 that do not open the File handle itself,
>> rather query by name, or opening the directory handle (which is MUCH
>> faster).
>
> That's what I tried to speed up in 1.7.6 by keeping the handle from
> symlink_info::check for reuse in stat.
>
>> - repetitive Win32 Kernel calls on a single syscall (stat() would
>> call up to 5 CreateFile/CloseHandle pairs plus another additional 5
>> to 10 Win32 APIs).
>> on stat() system calls, managed to improve the performance of ls
>> approx. by 4 times. This can be solved by caching: first time in a
>> syscall the API is called the result is stored, so the second time
>> the info is needed, it is re-used.
>
> I agree.  We could use caching fileinfo more extensively, though carefully,
> at least for the time of a single syscall.
>
>> - ACLs: Windows is not a secure system. And its ACL model is strange
>> to say the least... Most cygwin users do not use the unix
>> permissions system on cygwin to achieve security. All they want is
>> that the unix tools will run on Windows.
>
> I don't agree.  Windows is a secure system on the file level if users
> use the ACLs correctly.  It's not exactly a strange model, it's just
> unnecessarily complicated for home users.  However, in corporate
> environments it's utilized a lot.
>
> Besides, I made some performance tests myself before 1.7.6, and it
> turned out that the ACL checks for testing the POSIX permission bits
> are really not the problem.  The problem was that ls(1) had a test which
> resulted in calling getacl() twice, just to print the '+' character
> attached to the POSIX permission bits in `ls -l' output.  That should
> have gotten slightly better with the latest coreutils.
>
> Other than that, just use the "noacl" mount option if you don't like to
> be bothered with Windows ACLs or, FWIW, POSIX-like permissions.
>
>> - stat inode number and inode link count: getting the inode in
>> Windows requires a File handle or Directory handle (not possible to
>> get inode by file name). Very few applications actually need a REAL
>> inode number. So using the 'get file info by name' apis are used
>> (and of course there is an envirnoment if you really want real inode
>> numbers).
>
> Just use the "ihash" mount option if you don't like to use real inode
> numbers.  However, you don't see hardlinks anymore.
>
> I don't like the idea to extend the CYGWIN environment variable with
> this functionality at all.  I also don't like the idea that these
> settings are on by default.  So by default you're trading correctness
> (in a POSIX sense) for speed.  Speed is all well and nice, but it
> shouldn't be handled more important than correctness.
>
> There are certainly other ways to improve Cygwin's performance, which
> don't trade in correctness in the first place.  We should more
> concentrate on intelligent caching of file info and handles.
>
>> - GetVolumeInfo: The C:\ drive does not tend to be changed every
>> millisecond! Therefore no reason for every filesystem syscall to
>> call it. Caching this further increased the performance.
>
> Does your FS caching take volume mount points into account?
>
>> - File security check: GetSecurityInfo() is implemented in Windows
>> in usermode dll (Advapi32.dll). It calls at the end
>> NtQuerySecurityObject(). So I implemented a faster version:
>> zGetSecurityInfo() which does the same... just faster.
>
> Does your code preserve the inheritance entries which are available via
> GetSecurityInfo?  Note that I don't care at all for the GetSecurityInfo
> API from a usage POV.  I would prefer to use NtQuerySecurityObject
> directly.  However, the sole reason for using GetSecurityInfo is the
> fact that NtQuerySecurityObject only returns the plain ACL as it's
> stored for the file.  It does not return the ACEs which are inherited
> from the parent objects.  These are only available via GetSecurityInfo,
> or by checking the parent ACLs manually.
>
>> - symbolic link files: Opening a file and reading its contents is an
>> expensive operation. All file cygwin operations must check whether
>> the file is a symbolic link or not, which is done by opening the
>> file and reading its contents and checking whether it has the
>> symlink magic at the beginning of this. Since symbolic link must be
>
> That's not correct.  It only opens files which have cetain DOS flags
> set.  Symlinks are either files with a SYSTEM DOS flag, or .lnk files
> with the R/O DOS flag set, or reparse points.  So your extension for
> the test might help a tiny little bit, but since the SYSTEM attribute
> is only rarely set on file which are not Cygwin symlinks, it's a very
> rare operation.
>
>
> Corinna
>

--------------040009070507010109050000
Content-Type: text/plain;
 name="cygwin.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cygwin.patch"
Content-length: 42367

SW5kZXg6IHdpbnN1cC9jeWd3aW4vY3lndGxzLmNjCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2lu
L2N5Z3Rscy5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS43MgpkaWZmIC11
IC1wIC1yMS43MiBjeWd0bHMuY2MKLS0tIHdpbnN1cC9jeWd3aW4vY3lndGxz
LmNjCTI4IEZlYiAyMDEwIDE1OjU0OjI1IC0wMDAwCTEuNzIKKysrIHdpbnN1
cC9jeWd3aW4vY3lndGxzLmNjCTEzIFNlcCAyMDEwIDExOjQxOjU4IC0wMDAw
CkBAIC0xNjEsNiArMTYxLDkgQEAgX2N5Z3Rsczo6cmVtb3ZlIChEV09SRCB3
YWl0KQogICAgICAgZnJlZV9sb2NhbCAocHJvdG9lbnRfYnVmKTsKICAgICAg
IGZyZWVfbG9jYWwgKHNlcnZlbnRfYnVmKTsKICAgICAgIGZyZWVfbG9jYWwg
KGhvc3RlbnRfYnVmKTsKKyNpZmRlZiBVU0VfRkFTVF9TRUNVUklUWQorICAg
ICAgZnJlZV9sb2NhbCAoc2VjdXJpdHlfYnVmKTsKKyNlbmRpZgogICAgIH0K
IAogICAvKiBGcmVlIHRlbXBvcmFyeSBUTFMgcGF0aCBidWZmZXJzLiAqLwpJ
bmRleDogd2luc3VwL2N5Z3dpbi9jeWd0bHMuaAo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9j
eWd0bHMuaCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS42NgpkaWZmIC11IC1w
IC1yMS42NiBjeWd0bHMuaAotLS0gd2luc3VwL2N5Z3dpbi9jeWd0bHMuaAky
IE1hciAyMDEwIDAwOjQ5OjE1IC0wMDAwCTEuNjYKKysrIHdpbnN1cC9jeWd3
aW4vY3lndGxzLmgJMTMgU2VwIDIwMTAgMTE6NDE6NTggLTAwMDAKQEAgLTE0
NCw2ICsxNDQsMTIgQEAgc3RydWN0IF9sb2NhbF9zdG9yYWdlCiAKICAgLyog
QWxsIGZ1bmN0aW9ucyByZXF1aXJpbmcgdGVtcG9yYXJ5IHBhdGggYnVmZmVy
cy4gKi8KICAgdGxzX3BhdGhidWYgcGF0aGJ1ZnM7CisKKyNpZmRlZiBVU0Vf
RkFTVF9TRUNVUklUWQorICAvKiBzZWN1cml0eS5jYyAqLworICB2b2lkICpz
ZWN1cml0eV9idWY7CisgIGludCBzZWN1cml0eV9idWZfbGVuOworI2VuZGlm
CiB9OwogCiB0eXBlZGVmIHN0cnVjdCBzdHJ1Y3Rfd2FpdHEKSW5kZXg6IHdp
bnN1cC9jeWd3aW4vZW52aXJvbi5jYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9lbnZpcm9u
LmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjE4MwpkaWZmIC11IC1wIC1y
MS4xODMgZW52aXJvbi5jYwotLS0gd2luc3VwL2N5Z3dpbi9lbnZpcm9uLmNj
CTE4IE1heSAyMDEwIDE0OjMwOjUwIC0wMDAwCTEuMTgzCisrKyB3aW5zdXAv
Y3lnd2luL2Vudmlyb24uY2MJMTMgU2VwIDIwMTAgMTE6NDE6NTggLTAwMDAK
QEAgLTM0LDYgKzM0LDIxIEBAIGRldGFpbHMuICovCiBleHRlcm4gYm9vbCBk
b3NfZmlsZV93YXJuaW5nOwogZXh0ZXJuIGJvb2wgaWdub3JlX2Nhc2Vfd2l0
aF9nbG9iOwogZXh0ZXJuIGJvb2wgYWxsb3dfd2luc3ltbGlua3M7CisjaWZk
ZWYgRkFTVF9TWU1MSU5LX0NIRUNLCitleHRlcm4gYm9vbCBmYXN0X3N5bWxp
bmtfY2hlY2s7CisjZW5kaWYKKyNpZmRlZiBGQVNUX1NFQ1VUSVJZX0NIRUNL
CitleHRlcm4gYm9vbCBmYXN0X3NlY3VyaXR5X2luZm87CisjZW5kaWYKKyNp
ZmRlZiBVU0VfQUNMCitleHRlcm4gYm9vbCB1c2VfYWNsOworI2VuZGlmCisj
aWZkZWYgVVNFX0ZTX0lORk9fQ0FDSEUKK2V4dGVybiBib29sIHVzZV9mc19p
bmZvX2NhY2hlOworI2VuZGlmCisjaWZkZWYgVVNFX0lOT0RFX0ZST01fSEFT
SAorZXh0ZXJuIGJvb2wgaW5vZGVfZnJvbV9oYXNoOworI2VuZGlmCiBib29s
IHJlc2V0X2NvbSA9IGZhbHNlOwogc3RhdGljIGJvb2wgZW52Y2FjaGUgPSB0
cnVlOwogc3RhdGljIGJvb2wgY3JlYXRlX3VwY2FzZWVudiA9IGZhbHNlOwpA
QCAtNjA1LDYgKzYyMCwyMSBAQCBzdGF0aWMgc3RydWN0IHBhcnNlX3RoaW5n
CiAgIHsidHR5Iiwge05VTEx9LCBzZXRfcHJvY2Vzc19zdGF0ZSwgTlVMTCwg
e3swfSwge1BJRF9VU0VUVFl9fX0sCiAgIHsidXBjYXNlZW52IiwgeyZjcmVh
dGVfdXBjYXNlZW52fSwganVzdHNldCwgTlVMTCwge3tmYWxzZX0sIHt0cnVl
fX19LAogICB7IndpbnN5bWxpbmtzIiwgeyZhbGxvd193aW5zeW1saW5rc30s
IGp1c3RzZXQsIE5VTEwsIHt7ZmFsc2V9LCB7dHJ1ZX19fSwKKyNpZmRlZiBG
QVNUX1NZTUxJTktfQ0hFQ0sKKyAgeyJmYXN0X3N5bWxpbmtfY2hlY2siLCB7
JmZhc3Rfc3ltbGlua19jaGVja30sIGp1c3RzZXQsIE5VTEwsIHt7ZmFsc2V9
LCB7dHJ1ZX19fSwKKyNlbmRpZgorI2lmZGVmIFVTRV9BQ0wKKyAgeyJ1c2Vf
YWNsIiwgeyZ1c2VfYWNsfSwganVzdHNldCwgTlVMTCwge3tmYWxzZX0sIHt0
cnVlfX19LAorI2VuZGlmCisjaWZkZWYgVVNFX0ZTX0lORk9fQ0FDSEUKKyAg
eyJ1c2VfZnNfaW5mb19jYWNoZSIsIHsmdXNlX2ZzX2luZm9fY2FjaGV9LCBq
dXN0c2V0LCBOVUxMLCB7e2ZhbHNlfSwge3RydWV9fX0sCisjZW5kaWYKKyNp
ZmRlZiBVU0VfSU5PREVfRlJPTV9IQVNICisgIHsiaW5vZGVfZnJvbV9oYXNo
IiwgeyZpbm9kZV9mcm9tX2hhc2h9LCBqdXN0c2V0LCBOVUxMLCB7e2ZhbHNl
fSwge3RydWV9fX0sCisjZW5kaWYKKyNpZmRlZiBGQVNUX1NFQ1VUSVJZX0NI
RUNLCisgIHsiZmFzdF9zZWN1cml0eV9pbmZvIiwgeyZmYXN0X3NlY3VyaXR5
X2luZm99LCBqdXN0c2V0LCBOVUxMLCB7e2ZhbHNlfSwge3RydWV9fX0sCisj
ZW5kaWYKICAge05VTEwsIHswfSwganVzdHNldCwgMCwge3swfSwgezB9fX0K
IH07CiAKQEAgLTYxNiw2ICs2NDYsOSBAQCBwYXJzZV9vcHRpb25zIChjaGFy
ICpidWYpCiAgIGludCBpc3RydWU7CiAgIGNoYXIgKnAsICpsYXN0czsKICAg
cGFyc2VfdGhpbmcgKms7CisjaWZkZWYgVVNFX0FDTAorICBUQ0hBUiBleGVf
bmFtZVtNQVhfUEFUSF07CisjZW5kaWYKIAogICBpZiAoYnVmID09IE5VTEwp
CiAgICAgewpAQCAtNjk0LDYgKzcyNywxNyBAQCBwYXJzZV9vcHRpb25zIChj
aGFyICpidWYpCiAJICAgIGJyZWFrOwogCSAgfQogICAgICAgfQorI2lmZGVm
IFVTRV9BQ0wKKyAgaWYgKEdldE1vZHVsZUZpbGVOYW1lKDAsIGV4ZV9uYW1l
LCBNQVhfUEFUSCkgJiYgKHN0cnN0cihleGVfbmFtZSwgImNobW9kIikgfHwK
KyAgICAgIHN0cnN0cihleGVfbmFtZSwgImNob3duIikgfHwgc3Ryc3RyKGV4
ZV9uYW1lLCAiY2hncnAiKSkpCisgIHsKKyAgICAgIHVzZV9hY2wgPSAxOwor
ICB9CisjZW5kaWYKKyNpZiBkZWZpbmVkKFVTRV9BQ0wpICYmIGRlZmluZWQo
VVNFX0lOT0RFX0ZST01fSEFTSCkKKyAgaWYgKCFpbm9kZV9mcm9tX2hhc2gp
CisgICAgICB1c2VfYWNsID0gMTsKKyNlbmRpZgogICBkZWJ1Z19wcmludGYg
KCJyZXR1cm5pbmciKTsKIH0KIApJbmRleDogd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl9kaXNrX2ZpbGUuY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZGlz
a19maWxlLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjMzNApkaWZmIC11
IC1wIC1yMS4zMzQgZmhhbmRsZXJfZGlza19maWxlLmNjCi0tLSB3aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyX2Rpc2tfZmlsZS5jYwkyMCBBdWcgMjAxMCAxMTox
ODo1OCAtMDAwMAkxLjMzNAorKysgd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9k
aXNrX2ZpbGUuY2MJMTMgU2VwIDIwMTAgMTE6NDE6NTkgLTAwMDAKQEAgLTMw
LDYgKzMwLDEzIEBAIGRldGFpbHMuICovCiAjZGVmaW5lIF9DT01QSUxJTkdf
TkVXTElCCiAjaW5jbHVkZSA8ZGlyZW50Lmg+CiAKKyNpZmRlZiBVU0VfSU5P
REVfRlJPTV9IQVNICitib29sIGlub2RlX2Zyb21faGFzaCA9IHRydWU7Cisj
ZW5kaWYKKyNpZmRlZiBDQUNIRV9GSQorYm9vbCBjYWNoZV9maSA9IHRydWU7
CisjZW5kaWYKKwogY2xhc3MgX19ESVJfbW91bnRzCiB7CiAgIGludAkJIGNv
dW50OwpAQCAtMTQwLDYgKzE0NywxMCBAQCBwdWJsaWM6CiBpbmxpbmUgYm9v
bAogcGF0aF9jb252Ojppc2dvb2RfaW5vZGUgKF9faW5vNjRfdCBpbm8pIGNv
bnN0CiB7CisjaWZkZWYgVVNFX0lOT0RFX0ZST01fSEFTSAorICBpZiAoaW5v
ZGVfZnJvbV9oYXNoKQorICAgIHJldHVybiAwOworI2VuZGlmCiAgIC8qIFdl
IGNhbid0IHRydXN0IHJlbW90ZSBpbm9kZSBudW1iZXJzIG9mIG9ubHkgMzIg
Yml0LiAgVGhhdCBtZWFucywKICAgICAgYWxsIHJlbW90ZSBpbm9kZSBudW1i
ZXJzIHdoZW4gcnVubmluZyB1bmRlciBOVDQsIGFzIHdlbGwgYXMgcmVtb3Rl
IE5UNAogICAgICBOVEZTLCBhcyB3ZWxsIGFzIHNoYXJlcyBvZiBTYW1iYSB2
ZXJzaW9uIDwgMy4wLgpAQCAtNDE3LDExICs0MjgsMzUgQEAgZmhhbmRsZXJf
YmFzZTo6ZnN0YXRfYnlfaGFuZGxlIChzdHJ1Y3QgXwogCQkgICAgICAgZ2V0
X2RldiAoKSwKIAkJICAgICAgIGZzaS5FbmRPZkZpbGUuUXVhZFBhcnQsCiAJ
CSAgICAgICBmc2kuQWxsb2NhdGlvblNpemUuUXVhZFBhcnQsCisjaWZkZWYg
VVNFX0lOT0RFX0ZST01fSEFTSAorCQkgICAgICAgaW5vZGVfZnJvbV9oYXNo
ID8gMCA6IGZpaS5GaWxlSWQuUXVhZFBhcnQsIAorI2Vsc2UKIAkJICAgICAg
IGlubywKKyNlbmRpZgogCQkgICAgICAgZnNpLk51bWJlck9mTGlua3MsCiAJ
CSAgICAgICBmaS5mYmkuRmlsZUF0dHJpYnV0ZXMpOwogfQogCisjaWYgZGVm
aW5lZChDQUNIRV9GSSkgfHwgZGVmaW5lZCAoRkFTVF9TWU1MSU5LX0NIRUNL
KQoraW50IHBhdGhfY29udl91cGRhdGVfZmkocGF0aF9jb252ICpwYywgUFVO
SUNPREVfU1RSSU5HIHBhdGgpCit7CisgICAgV0NIQVIgX3BhdGhbTUFYX1BB
VEhdOworICAgIGlmIChwYXRoLT5MZW5ndGg+TUFYX1BBVEgpCisJcmV0dXJu
IDA7CisgICAgbWVtY3B5KF9wYXRoLCBwYXRoLT5CdWZmZXIsIHBhdGgtPkxl
bmd0aCk7CisgICAgX3BhdGhbcGF0aC0+TGVuZ3RoL3NpemVvZihXQ0hBUild
ID0gMDsKKyAgICBpZiAocGMtPmZpX3VwZGF0ZWQgPiAwICYmICF3Y3NjbXAo
cGMtPmZpX3BhdGgsIF9wYXRoKSkKKwlyZXR1cm4gcGMtPmZpX3VwZGF0ZWQ7
CisgICAgd2NzY3B5KHBjLT5maV9wYXRoLCBfcGF0aCk7CisgICAgT0JKRUNU
X0FUVFJJQlVURVMgYXR0cjsKKyAgICBJbml0aWFsaXplT2JqZWN0QXR0cmli
dXRlcygmYXR0ciwgcGF0aCwKKwlwYy0+b2JqY2FzZWluc2Vuc2l0aXZlKCkg
LCBOVUxMLCBOVUxMKTsKKyAgICBwYy0+ZmlfdXBkYXRlZCA9IE50UXVlcnlG
dWxsQXR0cmlidXRlc0ZpbGUoJmF0dHIsCisJKFBGSUxFX05FVFdPUktfT1BF
Tl9JTkZPUk1BVElPTikmcGMtPmZpKSA/IC0xIDogMTsKKyAgICByZXR1cm4g
cGMtPmZpX3VwZGF0ZWQ7Cit9CisjZW5kaWYKKwogaW50IF9fc3RkY2FsbAog
ZmhhbmRsZXJfYmFzZTo6ZnN0YXRfYnlfbmFtZSAoc3RydWN0IF9fc3RhdDY0
ICpidWYpCiB7CkBAIC00MzcsNiArNDcyLDIyIEBAIGZoYW5kbGVyX2Jhc2U6
OmZzdGF0X2J5X25hbWUgKHN0cnVjdCBfX3MKICAgfSBmZGlfYnVmOwogICBM
QVJHRV9JTlRFR0VSIEZpbGVJZDsKIAorI2lmZGVmIENBQ0hFX0ZJCisgIGlm
IChjYWNoZV9maSkKKyAgeworICAgICAgZGVidWdfcHJpbnRmICgic3RhcnQg
ZnN0YXRfYnlfbmFtZSIpOworICAgICAgaWYgKHBhdGhfY29udl91cGRhdGVf
ZmkoJnBjLCBwYy5nZXRfbnRfbmF0aXZlX3BhdGgoKSk8MCkKKwkgIGdvdG8g
dG9vX2JhZDsKKyAgICAgIGlmIChwYy5pc19yZXBfc3ltbGluaygpKQorCSAg
cGMuZmkuRmlsZUF0dHJpYnV0ZXMgJj0gfkZJTEVfQVRUUklCVVRFX0RJUkVD
VE9SWTsKKyAgICAgIHBjLmZpbGVfYXR0cmlidXRlcyhwYy5maS5GaWxlQXR0
cmlidXRlcyk7CisgICAgICByZXR1cm4gZnN0YXRfaGVscGVyIChidWYsCisJ
ICAmcGMuZmkuQ2hhbmdlVGltZSwgJnBjLmZpLkxhc3RBY2Nlc3NUaW1lLCAm
cGMuZmkuTGFzdFdyaXRlVGltZSwKKwkgICZwYy5maS5DcmVhdGlvblRpbWUs
IHBjLmZzX3NlcmlhbF9udW1iZXIgKCksCisJICBwYy5maS5FbmRPZkZpbGUu
UXVhZFBhcnQsIHBjLmZpLkFsbG9jYXRpb25TaXplLlF1YWRQYXJ0LCAwLCAx
LAorCSAgcGMuZmkuRmlsZUF0dHJpYnV0ZXMpOworICB9CisjZW5kaWYKICAg
UnRsU3BsaXRVbmljb2RlUGF0aCAocGMuZ2V0X250X25hdGl2ZV9wYXRoICgp
LCAmZGlybmFtZSwgJmJhc2VuYW1lKTsKICAgSW5pdGlhbGl6ZU9iamVjdEF0
dHJpYnV0ZXMgKCZhdHRyLCAmZGlybmFtZSwgcGMub2JqY2FzZWluc2Vuc2l0
aXZlICgpLAogCQkJICAgICAgTlVMTCwgTlVMTCk7CkBAIC01MDksNyArNTYw
LDkgQEAgaW50IF9fc3RkY2FsbAogZmhhbmRsZXJfYmFzZTo6ZnN0YXRfZnMg
KHN0cnVjdCBfX3N0YXQ2NCAqYnVmKQogewogICBpbnQgcmVzID0gLTE7Cisj
aWZuZGVmIENBQ0hFX0ZJCiAgIGludCBvcmV0OworI2VuZGlmCiAgIGludCBv
cGVuX2ZsYWdzID0gT19SRE9OTFkgfCBPX0JJTkFSWTsKIAogICBpZiAoZ2V0
X3N0YXRfaGFuZGxlICgpKQpAQCAtNTIwLDYgKzU3MywxMSBAQCBmaGFuZGxl
cl9iYXNlOjpmc3RhdF9mcyAoc3RydWN0IF9fc3RhdDY0CiAJcmVzID0gZnN0
YXRfYnlfbmFtZSAoYnVmKTsKICAgICAgIHJldHVybiByZXM7CiAgICAgfQor
I2lmZGVmIENBQ0hFX0ZJCisgIHF1ZXJ5X29wZW4gKHF1ZXJ5X3JlYWRfYXR0
cmlidXRlcyk7CisgIHJlcyA9IGZzdGF0X2J5X25hbWUgKGJ1Zik7CisgIGlm
IChyZXMgJiYgb3Blbl9mcyAob3Blbl9mbGFncywgMCkpCisjZWxzZQogICAv
KiBGaXJzdCB0cnkgdG8gb3BlbiB3aXRoIGdlbmVyaWMgcmVhZCBhY2Nlc3Mu
ICBUaGlzIGFsbG93cyB0byByZWFkIHRoZSBmaWxlCiAgICAgIGluIGZzdGF0
X2hlbHBlciAod2hlbiBjaGVja2luZyBmb3IgZXhlY3V0YWJpbGl0eSkgd2l0
aG91dCBoYXZpbmcgdG8KICAgICAgcmUtb3BlbiBpdC4gIE9wZW5pbmcgYSBm
aWxlIGNhbiB0YWtlIGEgbG90IG9mIHRpbWUgb24gbmV0d29yayBkcml2ZXMK
QEAgLTUzMSw2ICs1ODksNyBAQCBmaGFuZGxlcl9iYXNlOjpmc3RhdF9mcyAo
c3RydWN0IF9fc3RhdDY0CiAgICAgICBvcmV0ID0gb3Blbl9mcyAob3Blbl9m
bGFncywgMCk7CiAgICAgfQogICBpZiAob3JldCkKKyNlbmRpZgogICAgIHsK
ICAgICAgIC8qIFdlIG5vdyBoYXZlIGEgdmFsaWQgaGFuZGxlLCByZWdhcmRs
ZXNzIG9mIHRoZSAibm9oYW5kbGUiIHN0YXRlLgogCSBTaW5jZSBmaGFuZGxl
cl9iYXNlOjpvcGVuIG9ubHkgY2FsbHMgQ2xvc2VIYW5kbGUgaWYgIW5vaGFu
ZGxlLApAQCAtNTQzLDggKzYwMiwxMCBAQCBmaGFuZGxlcl9iYXNlOjpmc3Rh
dF9mcyAoc3RydWN0IF9fc3RhdDY0CiAgICAgICBub2hhbmRsZSAobm9faGFu
ZGxlKTsKICAgICAgIHNldF9pb19oYW5kbGUgKE5VTEwpOwogICAgIH0KKyNp
Zm5kZWYgQ0FDSEVfRkkKICAgaWYgKHJlcykKICAgICByZXMgPSBmc3RhdF9i
eV9uYW1lIChidWYpOworI2VuZGlmCiAKICAgcmV0dXJuIHJlczsKIH0KQEAg
LTU5Miw3ICs2NTMsMTEgQEAgZmhhbmRsZXJfYmFzZTo6ZnN0YXRfaGVscGVy
IChzdHJ1Y3QgX19zdAogI2VuZGlmCiAKICAgLyogRW5mb3JjZSBuYW1laGFz
aCBhcyBpbm9kZSBudW1iZXIgb24gdW50cnVzdGVkIGZpbGUgc3lzdGVtcy4g
Ki8KKyNpZmRlZiBVU0VfSU5PREVfRlJPTV9IQVNICisgIGlmICghaW5vZGVf
ZnJvbV9oYXNoICYmIG5GaWxlSW5kZXggJiYgcGMuaXNnb29kX2lub2RlIChu
RmlsZUluZGV4KSkKKyNlbHNlCiAgIGlmIChuRmlsZUluZGV4ICYmIHBjLmlz
Z29vZF9pbm9kZSAobkZpbGVJbmRleCkpCisjZW5kaWYKICAgICBidWYtPnN0
X2lubyA9IChfX2lubzY0X3QpIG5GaWxlSW5kZXg7CiAgIGVsc2UKICAgICBi
dWYtPnN0X2lubyA9IGdldF9pbm8gKCk7CkluZGV4OiB3aW5zdXAvY3lnd2lu
L21vdW50LmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9j
dnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL21vdW50LmNjLHYKcmV0cmlldmlu
ZyByZXZpc2lvbiAxLjY0CmRpZmYgLXUgLXAgLXIxLjY0IG1vdW50LmNjCi0t
LSB3aW5zdXAvY3lnd2luL21vdW50LmNjCTI1IEF1ZyAyMDEwIDA5OjIwOjEx
IC0wMDAwCTEuNjQKKysrIHdpbnN1cC9jeWd3aW4vbW91bnQuY2MJMTMgU2Vw
IDIwMTAgMTE6NDI6MDAgLTAwMDAKQEAgLTQ4LDYgKzQ4LDEwIEBAIGRldGFp
bHMuICovCiBib29sIE5PX0NPUFkgbW91bnRfaW5mbzo6Z290X3Vzcl9iaW47
CiBib29sIE5PX0NPUFkgbW91bnRfaW5mbzo6Z290X3Vzcl9saWI7CiBpbnQg
Tk9fQ09QWSBtb3VudF9pbmZvOjpyb290X2lkeCA9IC0xOworI2lmIGRlZmlu
ZWQoVVNFX0FDTCkgfHwgZGVmaW5lZChVU0VfRlNfSU5GT19DQUNIRSkKK2Jv
b2wgdXNlX2FjbCA9IGZhbHNlOworYm9vbCB1c2VfZnNfaW5mb19jYWNoZSA9
IHRydWU7CisjZW5kaWYKIAogLyogaXNfdW5jX3NoYXJlOiBSZXR1cm4gbm9u
LXplcm8gaWYgUEFUSCBiZWdpbnMgd2l0aCAvL3NlcnZlci9zaGFyZQogCQkg
b3Igd2l0aCBvbmUgb2YgdGhlIG5hdGl2ZSBwcmVmaXhlcyAvLy4vIG9yIC8v
Py8KQEAgLTEwNSw2ICsxMDksMTEzIEBAIHN0cnVjdCBzbWJfZXh0ZW5kZWRf
aW5mbyB7CiB9OwogI3ByYWdtYSBwYWNrKHBvcCkKIAorI2lmZGVmIFVTRV9G
U19JTkZPX0NBQ0hFCit0eXBlZGVmIHN0cnVjdCBmc19pbmZvX2xpc3RfdCB7
CisgICAgc3RydWN0IGZzX2luZm9fbGlzdF90ICpuZXh0OworICAgIGZzX2lu
Zm8gZnNpOworICAgIHdjaGFyX3QgcGF0aFtNQVhfUEFUSF07CisgICAgaW50
IHBhdGhfbGVuOworfSBmc19pbmZvX2xpc3RfdDsKKworc3RhdGljIGZzX2lu
Zm9fbGlzdF90ICpmc19pbmZvX2xpc3Q7CitzdGF0aWMgaW50IGluX2ZzX2lu
Zm9fdXBkYXRlOworCitpbnQgZnNfaW5mb19sb29rdXAoZnNfaW5mbyAqZnNp
LCBQVU5JQ09ERV9TVFJJTkcgdXBhdGgpCit7CisgICAgaW50IHNob3J0ZXN0
ID0gMDsKKyAgICBmc19pbmZvX2xpc3RfdCAqZiwgKmZvdW5kID0gTlVMTDsK
KyAgICBpZiAoaW5fZnNfaW5mb191cGRhdGUpCisJcmV0dXJuIDA7CisgICAg
LyogZmluZCBmaXJzdCAobG9uZ2VzdCBtYXRjaCkgKi8KKyAgICBmb3IgKGYg
PSBmc19pbmZvX2xpc3Q7IGYgIT0gTlVMTDsgZj1mLT5uZXh0KQorICAgIHsK
KwlpZiAoIXdjc25jbXAoZi0+cGF0aCwgdXBhdGgtPkJ1ZmZlciwgZi0+cGF0
aF9sZW4pKQorCXsKKwkgICAgaWYgKCFzaG9ydGVzdCB8fCBzaG9ydGVzdCA+
IGYtPnBhdGhfbGVuKQorCSAgICB7CisJCXNob3J0ZXN0ID0gZi0+cGF0aF9s
ZW47CisJCWZvdW5kID0gZjsKKwkgICAgfQorCX0KKyAgICB9CisgICAgaWYg
KCFmb3VuZCkKKwlyZXR1cm4gMDsKKyAgICBtZW1jcHkoZnNpLCAmZm91bmQt
PmZzaSwgc2l6ZW9mKGZzaSkpOworICAgIHJldHVybiAxOworfQorCitzdGF0
aWMgaW5saW5lIGludCBmc19pbmZvX2VxKGZzX2luZm8gKmEsIGZzX2luZm8g
KmIpCit7CisgICAgcmV0dXJuIGEtPnNlcmlhbF9udW1iZXIoKT09Yi0+c2Vy
aWFsX251bWJlcigpICYmCisJIW1lbWNtcCgmYS0+c3RhdHVzLCAmYi0+c3Rh
dHVzLCBzaXplb2YoYS0+c3RhdHVzKSk7Cit9CisKK3N0YXRpYyB2b2lkIGZz
X2luZm9fdXBkYXRlKGZzX2luZm8gKmZzaSwgUFVOSUNPREVfU1RSSU5HIHVw
YXRoKQoreworICAgIHdjaGFyX3Qgc2Nhbl9wYXRoW01BWF9QQVRIXSwgc2F2
ZSwgKnA7CisgICAgZnNfaW5mbyAqX2ZzaSwgKnNjYW4gPSBOVUxMOworICAg
IGZzX2luZm9fbGlzdF90ICpmOworICAgIFVOSUNPREVfU1RSSU5HICB1c3Ry
OworICAgIGlmIChpbl9mc19pbmZvX3VwZGF0ZSkKKwlyZXR1cm47CisgICAg
aW5fZnNfaW5mb191cGRhdGUrKzsKKyAgICBfZnNpID0gbmV3IGZzX2luZm8o
KTsKKyAgICBfZnNpLT51cGRhdGUodXBhdGgsIE5VTEwpOworICAgIC8qIHNh
bml0eSBjaGVjayAqLworICAgIGlmICghZnNfaW5mb19lcShfZnNpLCBmc2kp
KQorICAgIHsKKwlkZWJ1Z19wcmludGYoImZzX2luZm9fdXBkYXRlOiBzdHJh
bmdlOiBnb3QgZGlmZmVyZW50IHZvbHVtZSIpOworCWRlbGV0ZSBfZnNpOwor
CWdvdG8gRXhpdDsKKyAgICB9CisgICAgLyogc2NhbiB1cCB0aGUgcGF0aCB0
byBmaW5kIHRoZSBiYXNlIGRpcmVjdG9yeSBvZiB0aGUgbW91bnQgKi8KKyAg
ICB3Y3NjcHkoc2Nhbl9wYXRoLCB1cGF0aC0+QnVmZmVyKTsKKyAgICB3aGls
ZSAoKHA9d2NzcmNocihzY2FuX3BhdGgsICdcXCcpKSkKKyAgICB7CisJc2F2
ZSA9ICpwOworCSpwID0gMDsKKwlpZiAocD09c2Nhbl9wYXRoKQorCXsKKwkg
ICAgKnAgPSBzYXZlOworCSAgICBicmVhazsKKwl9CisJaWYgKHNjYW4pCisJ
ICAgIGRlbGV0ZSBzY2FuOworCXNjYW4gPSBuZXcgZnNfaW5mbygpOworCXVz
dHIuQnVmZmVyID0gc2Nhbl9wYXRoOworCXVzdHIuTGVuZ3RoID0gd2NzbGVu
KHNjYW5fcGF0aCk7CisJdXN0ci5NYXhpbXVtTGVuZ3RoID0gc2l6ZW9mKHNj
YW5fcGF0aCk7CisJaWYgKCFzY2FuLT51cGRhdGUoJnVzdHIsIE5VTEwpIHx8
ICFmc19pbmZvX2VxKHNjYW4sIGZzaSkpCisJeworCSAgICAqcCA9IHNhdmU7
CisJICAgIGJyZWFrOworCX0KKyAgICB9CisgICAgaWYgKHNjYW4pCisJZGVs
ZXRlIHNjYW47CisgICAgZiA9IChmc19pbmZvX2xpc3RfdCopY2FsbG9jKHNp
emVvZigqZiksIDEpOworICAgIG1lbWNweSgmZi0+ZnNpLCBfZnNpLCBzaXpl
b2YoX2ZzaSkpOworICAgIGYtPnBhdGhfbGVuID0gd2NzbGVuKHNjYW5fcGF0
aCk7CisgICAgd2NzY3B5KGYtPnBhdGgsIHNjYW5fcGF0aCk7CisgICAgZi0+
bmV4dCA9IGZzX2luZm9fbGlzdDsKKyAgICBmc19pbmZvX2xpc3QgPSBmOwor
RXhpdDoKKyAgICBpbl9mc19pbmZvX3VwZGF0ZS0tOworfQorI2VuZGlmCisK
KyNpZmRlZiBVU0VfQUNMCitib29sIGZzX2luZm86Omhhc19hY2xzKGJvb2wg
dmFsKQoreworICAgIHJldHVybiAoYm9vbCkgKHN0YXR1cy5oYXNfYWNscyA9
IHZhbCk7Cit9CisKK2Jvb2wgZnNfaW5mbzo6aGFzX2FjbHMoKSBjb25zdAor
eworICAgIHJldHVybiB1c2VfYWNsID8gc3RhdHVzLmhhc19hY2xzIDogMDsK
K30KKyNlbmRpZgorCiBib29sCiBmc19pbmZvOjp1cGRhdGUgKFBVTklDT0RF
X1NUUklORyB1cGF0aCwgSEFORExFIGluX3ZvbCkKIHsKQEAgLTEyNSw2ICsy
MzYsMTAgQEAgZnNfaW5mbzo6dXBkYXRlIChQVU5JQ09ERV9TVFJJTkcgdXBh
dGgsIAogICB9IGZmdmlfYnVmOwogICBVTklDT0RFX1NUUklORyBmc25hbWU7
CiAKKyNpZmRlZiBVU0VfRlNfSU5GT19DQUNIRQorICBpZiAodXNlX2ZzX2lu
Zm9fY2FjaGUgJiYgIXVzZV9hY2wgJiYgZnNfaW5mb19sb29rdXAodGhpcywg
dXBhdGgpKQorICAgICAgcmV0dXJuIHRydWU7CisjZW5kaWYKICAgY2xlYXIg
KCk7CiAgIGlmIChpbl92b2wpCiAgICAgdm9sID0gaW5fdm9sOwpAQCAtMzU1
LDYgKzQ3MCwxMSBAQCBmc19pbmZvOjp1cGRhdGUgKFBVTklDT0RFX1NUUklO
RyB1cGF0aCwgCiAKICAgaWYgKCFpbl92b2wpCiAgICAgTnRDbG9zZSAodm9s
KTsKKworI2lmZGVmIFVTRV9GU19JTkZPX0NBQ0hFCisgIGlmICh1c2VfZnNf
aW5mb19jYWNoZSAmJiAhdXNlX2FjbCkKKyAgICAgIGZzX2luZm9fdXBkYXRl
KHRoaXMsIHVwYXRoKTsKKyNlbmRpZgogICByZXR1cm4gdHJ1ZTsKIH0KIApJ
bmRleDogd2luc3VwL2N5Z3dpbi9tb3VudC5oCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL21v
dW50LmgsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTQKZGlmZiAtdSAtcCAt
cjEuMTQgbW91bnQuaAotLS0gd2luc3VwL2N5Z3dpbi9tb3VudC5oCTkgQXVn
IDIwMTAgMDg6MTg6MzAgLTAwMDAJMS4xNAorKysgd2luc3VwL2N5Z3dpbi9t
b3VudC5oCTEzIFNlcCAyMDEwIDExOjQyOjAwIC0wMDAwCkBAIC00Myw2ICs0
MywxMyBAQCBleHRlcm4gc3RydWN0IGZzX25hbWVzX3QgewogCiBjbGFzcyBm
c19pbmZvCiB7CisjaWZkZWYgVVNFX0ZTX0lORk9fQ0FDSEUKKyAgVUxPTkcg
c2VybnVtOwkJCS8qIFZvbHVtZSBTZXJpYWwgTnVtYmVyICovCisgIGNoYXIg
ZnNuWzgwXTsJCQkvKiBXaW5kb3dzIGZpbGVzeXN0ZW0gbmFtZSAqLworICB1
bnNpZ25lZCBsb25nIGdvdF9mcyAoKSBjb25zdCB7IHJldHVybiBzdGF0dXMu
ZnNfdHlwZSAhPSBub25lOyB9CisKKyBwdWJsaWM6CisjZW5kaWYKICAgc3Ry
dWN0IHN0YXR1c19mbGFncwogICB7CiAgICAgVUxPTkcgZmxhZ3M7CQkvKiBW
b2x1bWUgZmxhZ3MgKi8KQEAgLTU4LDExICs2NSwxMyBAQCBjbGFzcyBmc19p
bmZvCiAgICAgdW5zaWduZWQgaGFzX2J1Z2d5X2Jhc2ljX2luZm8JOiAxOwog
ICAgIHVuc2lnbmVkIGhhc19kb3NfZmlsZW5hbWVzX29ubHkJOiAxOwogICB9
IHN0YXR1czsKKyNpZm5kZWYgVVNFX0ZTX0lORk9fQ0FDSEUKICAgVUxPTkcg
c2VybnVtOwkJCS8qIFZvbHVtZSBTZXJpYWwgTnVtYmVyICovCiAgIGNoYXIg
ZnNuWzgwXTsJCQkvKiBXaW5kb3dzIGZpbGVzeXN0ZW0gbmFtZSAqLwogICB1
bnNpZ25lZCBsb25nIGdvdF9mcyAoKSBjb25zdCB7IHJldHVybiBzdGF0dXMu
ZnNfdHlwZSAhPSBub25lOyB9CiAKICBwdWJsaWM6CisjZW5kaWYKICAgdm9p
ZCBjbGVhciAoKQogICB7CiAgICAgbWVtc2V0ICgmc3RhdHVzLCAwICwgc2l6
ZW9mIHN0YXR1cyk7CkBAIC03NSw3ICs4NCwxMiBAQCBjbGFzcyBmc19pbmZv
CiAgIElNUExFTUVOVF9TVEFUVVNfRkxBRyAoVUxPTkcsIHNhbWJhX3ZlcnNp
b24pCiAgIElNUExFTUVOVF9TVEFUVVNfRkxBRyAoVUxPTkcsIG5hbWVfbGVu
KQogICBJTVBMRU1FTlRfU1RBVFVTX0ZMQUcgKGJvb2wsIGlzX3JlbW90ZV9k
cml2ZSkKKyNpZmRlZiBVU0VfQUNMCisgIGJvb2wgaGFzX2FjbHMoYm9vbCB2
YWwpOworICBib29sIGhhc19hY2xzKCkgY29uc3Q7CisjZWxzZQogICBJTVBM
RU1FTlRfU1RBVFVTX0ZMQUcgKGJvb2wsIGhhc19hY2xzKQorI2VuZGlmCiAg
IElNUExFTUVOVF9TVEFUVVNfRkxBRyAoYm9vbCwgaGFzZ29vZF9pbm9kZSkK
ICAgSU1QTEVNRU5UX1NUQVRVU19GTEFHIChib29sLCBjYXNlaW5zZW5zaXRp
dmUpCiAgIElNUExFTUVOVF9TVEFUVVNfRkxBRyAoYm9vbCwgaGFzX2J1Z2d5
X29wZW4pCkluZGV4OiB3aW5zdXAvY3lnd2luL3BhdGguY2MKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9j
eWd3aW4vcGF0aC5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS42MDQKZGlm
ZiAtdSAtcCAtcjEuNjA0IHBhdGguY2MKLS0tIHdpbnN1cC9jeWd3aW4vcGF0
aC5jYwkyNyBBdWcgMjAxMCAxNzo1ODo0MyAtMDAwMAkxLjYwNAorKysgd2lu
c3VwL2N5Z3dpbi9wYXRoLmNjCTEzIFNlcCAyMDEwIDExOjQyOjAzIC0wMDAw
CkBAIC03Myw3ICs3MywxNCBAQAogI2luY2x1ZGUgPHdjaGFyLmg+CiAjaW5j
bHVkZSA8d2N0eXBlLmg+CiAKKyNpZmRlZiBESVNBQkxFX0RPU19GSUxFX1dB
Uk5JTkcKK2Jvb2wgZG9zX2ZpbGVfd2FybmluZyA9IGZhbHNlOworI2Vsc2UK
IGJvb2wgZG9zX2ZpbGVfd2FybmluZyA9IHRydWU7CisjZW5kaWYKKyNpZmRl
ZiBGQVNUX1NZTUxJTktfQ0hFQ0sKK2Jvb2wgZmFzdF9zeW1saW5rX2NoZWNr
ID0gdHJ1ZTsKKyNlbmRpZgogCiBzdWZmaXhfaW5mbyBzdGF0X3N1ZmZpeGVz
W10gPQogewpAQCAtOTcsNyArMTA0LDExIEBAIHN0cnVjdCBzeW1saW5rX2lu
Zm8KICAgX21pbm9yX3QgbWlub3I7CiAgIF9tb2RlX3QgbW9kZTsKICAgaW50
IGNoZWNrIChjaGFyICpwYXRoLCBjb25zdCBzdWZmaXhfaW5mbyAqc3VmZml4
ZXMsIGZzX2luZm8gJmZzLAorI2lmZGVmIEZBU1RfU1lNTElOS19DSEVDSwor
ICAgICAgICAgICAgIHBhdGhfY29udl9oYW5kbGUgJmNvbnZfaGRsLCBwYXRo
X2NvbnYgKnBjKTsKKyNlbHNlCiAJICAgICBwYXRoX2NvbnZfaGFuZGxlICZj
b252X2hkbCk7CisjZW5kaWYKICAgaW50IHNldCAoY2hhciAqcGF0aCk7CiAg
IGJvb2wgcGFyc2VfZGV2aWNlIChjb25zdCBjaGFyICopOwogICBpbnQgY2hl
Y2tfc3lzZmlsZSAoSEFORExFIGgpOwpAQCAtODI2LDcgKzgzNywxMSBAQCBw
YXRoX2NvbnY6OmNoZWNrIChjb25zdCBjaGFyICpzcmMsIHVuc2lnCiAJICBp
ZiAoaXNfbXNkb3MpCiAJICAgIHN5bS5wZmxhZ3MgfD0gUEFUSF9OT1BPU0lY
IHwgUEFUSF9OT0FDTDsKIAorI2lmZGVmIEZBU1RfU1lNTElOS19DSEVDSwor
CSAgc3ltbGVuID0gc3ltLmNoZWNrIChmdWxsX3BhdGgsIHN1ZmYsIGZzLCBj
b252X2hhbmRsZSwgdGhpcyk7CisjZWxzZQogCSAgc3ltbGVuID0gc3ltLmNo
ZWNrIChmdWxsX3BhdGgsIHN1ZmYsIGZzLCBjb252X2hhbmRsZSk7CisjZW5k
aWYKIAogaXNfdmlydHVhbF9zeW1saW5rOgogCkBAIC0yMTgzLDExICsyMTk4
LDIwIEBAIHN5bWxpbmtfaW5mbzo6cGFyc2VfZGV2aWNlIChjb25zdCBjaGFy
ICoKIAogaW50CiBzeW1saW5rX2luZm86OmNoZWNrIChjaGFyICpwYXRoLCBj
b25zdCBzdWZmaXhfaW5mbyAqc3VmZml4ZXMsIGZzX2luZm8gJmZzLAorI2lm
ZGVmIEZBU1RfU1lNTElOS19DSEVDSworCQkgICAgIHBhdGhfY29udl9oYW5k
bGUgJmNvbnZfaGRsLCBwYXRoX2NvbnYgKnBjKQorI2Vsc2UKIAkJICAgICBw
YXRoX2NvbnZfaGFuZGxlICZjb252X2hkbCkKKyNlbmRpZgogewogICBpbnQg
cmVzOwogICBIQU5ETEUgaDsKKyNpZmRlZiBGQVNUX1NZTUxJTktfQ0hFQ0sK
KyAgTlRTVEFUVVMgc3RhdHVzID0gLTE7CisgIExBUkdFX0lOVEVHRVIgZmls
ZXNpemUgPSAgeyBRdWFkUGFydDowTEwgfTsKKyNlbHNlCiAgIE5UU1RBVFVT
IHN0YXR1czsKKyNlbmRpZgogICBVTklDT0RFX1NUUklORyB1cGF0aDsKICAg
T0JKRUNUX0FUVFJJQlVURVMgYXR0cjsKICAgSU9fU1RBVFVTX0JMT0NLIGlv
OwpAQCAtMjIyNSw2ICsyMjQ5LDMwIEBAIHJlc3RhcnQ6CiAKICMgZGVmaW5l
IE1JTl9TVEFUX0FDQ0VTUwkoUkVBRF9DT05UUk9MIHwgRklMRV9SRUFEX0FU
VFJJQlVURVMpCiAjIGRlZmluZSBGVUxMX1NUQVRfQUNDRVNTCShTWU5DSFJP
TklaRSB8IEdFTkVSSUNfUkVBRCkKKworI2lmZGVmIEZBU1RfU1lNTElOS19D
SEVDSworI2RlZmluZSBGSUxFX0NSRUFURV9GTEFHUyAoRklMRV9PUEVOX1JF
UEFSU0VfUE9JTlQgfCBGSUxFX1JBTkRPTV9BQ0NFU1MpCisKKyNkZWZpbmUg
T1BFTl9JRl9ORUVERUQoKSBcCisgICAgICBpZiAoIWgpIFwKKyAgICAgIHsg
XAorCSAgc3RhdHVzID0gTnRDcmVhdGVGaWxlICgmaCwgXAorCSAgICAgIGFj
Y2VzcyA9IEZVTExfU1RBVF9BQ0NFU1MsICZhdHRyLCAmaW8sIE5VTEwsIDAs
IFwKKwkgICAgICBGSUxFX1NIQVJFX1ZBTElEX0ZMQUdTLCBGSUxFX09QRU4s
IFwKKwkgICAgICBGSUxFX09QRU5fUkVQQVJTRV9QT0lOVCB8IEZJTEVfT1BF
Tl9GT1JfQkFDS1VQX0lOVEVOVCwgXAorCSAgICAgIGVhYnVmLCBlYXNpemUp
OyBcCisgICAgICAgICAgaWYgKHN0YXR1cyA9PSBTVEFUVVNfQUNDRVNTX0RF
TklFRCkgXAorCSAgeyBcCisJICAgICAgc3RhdHVzID0gTnRDcmVhdGVGaWxl
ICgmaCwgYWNjZXNzID0gTUlOX1NUQVRfQUNDRVNTLCAmYXR0ciwgJmlvLCBc
CisJCQkJIE5VTEwsIDAsIEZJTEVfU0hBUkVfVkFMSURfRkxBR1MsIEZJTEVf
T1BFTiwgXAorCQkJCSBGSUxFX0NSRUFURV9GTEFHUywgXAorCQkJCSBlYWJ1
ZiwgZWFzaXplKTsgXAorCSAgICAgIGRlYnVnX3ByaW50ZiAoIiVwID0gTnRD
cmVhdGVGaWxlICgyOiVTKSIsIHN0YXR1cywgJnVwYXRoKTsgXAorCX0gXAor
ICAgICAgICBlbHNlIFwKKwkgIGRlYnVnX3ByaW50ZiAoIiVwID0gTnRDcmVh
dGVGaWxlICgxOiVTKSIsIHN0YXR1cywgJnVwYXRoKTsgXAorICAgICAgfQor
I2VuZGlmCiAgIEFDQ0VTU19NQVNLIGFjY2VzcyA9IDA7CiAKICAgYm9vbCBo
YWRfZXh0ID0gISEqZXh0X2hlcmU7CkBAIC0yMjM5LDYgKzIyODcsMjIgQEAg
cmVzdGFydDoKIAkgIE50Q2xvc2UgKGgpOwogCSAgaCA9IE5VTEw7CiAJfQor
I2lmZGVmIEZBU1RfU1lNTElOS19DSEVDSworICAgICAgaWYgKGZhc3Rfc3lt
bGlua19jaGVjaykKKyAgICAgIHsKKwkgIGZpbGVzaXplLlF1YWRQYXJ0ID0g
MExMOworCSAgaWYgKHBhdGhfY29udl91cGRhdGVfZmkocGMsICZ1cGF0aCk+
MCkKKwkgIHsKKwkgICAgICBzdGF0dXMgPSAwOworCSAgICAgIGZpbGVhdHRy
ID0gcGMtPmZpLkZpbGVBdHRyaWJ1dGVzOworCSAgICAgIGZpbGVzaXplID0g
cGMtPmZpLkFsbG9jYXRpb25TaXplOworCSAgfQorCSAgZWxzZQorCSAgICAg
IE9QRU5fSUZfTkVFREVEKCk7CisgICAgICB9CisgICAgICBlbHNlCisgICAg
ICB7CisjZW5kaWYKICAgICAgIC8qIFRoZSBFQSBnaXZlbiB0byBOdENyZWF0
ZUZpbGUgYWxsb3dzIHRvIGdldCBhIGhhbmRsZSB0byBhIHN5bWxpbmsgb24K
IAkgYW4gTkZTIHNoYXJlLCByYXRoZXIgdGhhbiBnZXR0aW5nIGEgaGFuZGxl
IHRvIHRoZSB0YXJnZXQgb2YgdGhlCiAJIHN5bWxpbmsgKHdoaWNoIHdvdWxk
IHNwb2lsIHRoZSB0YXNrIG9mIHRoaXMgbWV0aG9kIHF1aXRlIGEgYml0KS4K
QEAgLTIyNDYsMjAgKzIzMTAsMzEgQEAgcmVzdGFydDoKIAkgdG8gc3BlY2lh
bCBjYXNlIE5GUyB0b28gbXVjaC4gKi8KICAgICAgIHN0YXR1cyA9IE50Q3Jl
YXRlRmlsZSAoJmgsIGFjY2VzcyA9IEZVTExfU1RBVF9BQ0NFU1MsICZhdHRy
LCAmaW8sIE5VTEwsCiAJCQkgICAgIDAsIEZJTEVfU0hBUkVfVkFMSURfRkxB
R1MsIEZJTEVfT1BFTiwKKyNpZmRlZiBGQVNUX1NZTUxJTktfQ0hFQ0sKKwkJ
CSAgICAgRklMRV9DUkVBVEVfRkxBR1MsCisjZWxzZQogCQkJICAgICBGSUxF
X09QRU5fUkVQQVJTRV9QT0lOVAogCQkJICAgICB8IEZJTEVfT1BFTl9GT1Jf
QkFDS1VQX0lOVEVOVCwKKyNlbmRpZgogCQkJICAgICBlYWJ1ZiwgZWFzaXpl
KTsKICAgICAgIGlmIChzdGF0dXMgPT0gU1RBVFVTX0FDQ0VTU19ERU5JRUQp
CiAJewogCSAgc3RhdHVzID0gTnRDcmVhdGVGaWxlICgmaCwgYWNjZXNzID0g
TUlOX1NUQVRfQUNDRVNTLCAmYXR0ciwgJmlvLAogCQkJCSBOVUxMLCAwLCBG
SUxFX1NIQVJFX1ZBTElEX0ZMQUdTLCBGSUxFX09QRU4sCisjaWZkZWYgRkFT
VF9TWU1MSU5LX0NIRUNLCisJCQkJIEZJTEVfQ1JFQVRFX0ZMQUdTLAorI2Vs
c2UKIAkJCQkgRklMRV9PUEVOX1JFUEFSU0VfUE9JTlQKIAkJCQkgfCBGSUxF
X09QRU5fRk9SX0JBQ0tVUF9JTlRFTlQsCisjZW5kaWYKIAkJCQkgZWFidWYs
IGVhc2l6ZSk7CiAJICBkZWJ1Z19wcmludGYgKCIlcCA9IE50Q3JlYXRlRmls
ZSAoMjolUykiLCBzdGF0dXMsICZ1cGF0aCk7CiAJfQogICAgICAgZWxzZQog
CWRlYnVnX3ByaW50ZiAoIiVwID0gTnRDcmVhdGVGaWxlICgxOiVTKSIsIHN0
YXR1cywgJnVwYXRoKTsKKyNpZmRlZiBGQVNUX1NZTUxJTktfQ0hFQ0sKKyAg
ICAgIH0KKyNlbmRpZgogICAgICAgLyogTm8gcmlnaHQgdG8gYWNjZXNzIEVB
cyBvciBFQXMgbm90IHN1cHBvcnRlZD8gKi8KICAgICAgIGlmICghTlRfU1VD
Q0VTUyAoc3RhdHVzKQogCSAgJiYgKHN0YXR1cyA9PSBTVEFUVVNfQUNDRVNT
X0RFTklFRApAQCAtMjI4MSwxNCArMjM1NiwyMiBAQCByZXN0YXJ0OgogCSAg
ICB9CiAJICBzdGF0dXMgPSBOdE9wZW5GaWxlICgmaCwgYWNjZXNzID0gRlVM
TF9TVEFUX0FDQ0VTUywgJmF0dHIsICZpbywKIAkJCSAgICAgICBGSUxFX1NI
QVJFX1ZBTElEX0ZMQUdTLAorI2lmZGVmIEZBU1RfU1lNTElOS19DSEVDSwor
CQkJICAgICAgIEZJTEVfQ1JFQVRFX0ZMQUdTKTsKKyNlbHNlCiAJCQkgICAg
ICAgRklMRV9PUEVOX1JFUEFSU0VfUE9JTlQKIAkJCSAgICAgICB8IEZJTEVf
T1BFTl9GT1JfQkFDS1VQX0lOVEVOVCk7CisjZW5kaWYKIAkgIGlmIChzdGF0
dXMgPT0gU1RBVFVTX0FDQ0VTU19ERU5JRUQpCiAJICAgIHsKIAkgICAgICBz
dGF0dXMgPSBOdE9wZW5GaWxlICgmaCwgYWNjZXNzID0gTUlOX1NUQVRfQUND
RVNTLCAmYXR0ciwgJmlvLAogCQkJCSAgIEZJTEVfU0hBUkVfVkFMSURfRkxB
R1MsCisjaWZkZWYgRkFTVF9TWU1MSU5LX0NIRUNLCisJCQkJICAgRklMRV9D
UkVBVEVfRkxBR1MpOworI2Vsc2UKIAkJCQkgICBGSUxFX09QRU5fUkVQQVJT
RV9QT0lOVAogCQkJCSAgIHwgRklMRV9PUEVOX0ZPUl9CQUNLVVBfSU5URU5U
KTsKKyNlbmRpZgogCSAgICAgIGRlYnVnX3ByaW50ZiAoIiVwID0gTnRPcGVu
RmlsZSAobm8tRUFzIDI6JVMpIiwgc3RhdHVzLCAmdXBhdGgpOwogCSAgICB9
CiAJICBlbHNlCkBAIC0yMzA2LDggKzIzODksMTIgQEAgcmVzdGFydDoKIAkg
ICAgICBhdHRyLkF0dHJpYnV0ZXMgPSBPQkpfQ0FTRV9JTlNFTlNJVElWRTsK
IAkgICAgICBzdGF0dXMgPSBOdE9wZW5GaWxlICgmaCwgUkVBRF9DT05UUk9M
IHwgRklMRV9SRUFEX0FUVFJJQlVURVMsCiAJCQkJICAgJmF0dHIsICZpbywg
RklMRV9TSEFSRV9WQUxJRF9GTEFHUywKKyNpZmRlZiBGQVNUX1NZTUxJTktf
Q0hFQ0sKKwkJCQkgICBGSUxFX0NSRUFURV9GTEFHUyk7CisjZWxzZQogCQkJ
CSAgIEZJTEVfT1BFTl9SRVBBUlNFX1BPSU5UCiAJCQkJICAgfCBGSUxFX09Q
RU5fRk9SX0JBQ0tVUF9JTlRFTlQpOworI2VuZGlmCiAJICAgICAgZGVidWdf
cHJpbnRmICgiJXAgPSBOdE9wZW5GaWxlIChicm9rZW4tVURGLCAlUykiLCBz
dGF0dXMsICZ1cGF0aCk7CiAJICAgICAgYXR0ci5BdHRyaWJ1dGVzID0gMDsK
IAkgICAgICBpZiAoTlRfU1VDQ0VTUyAoc3RhdHVzKSkKQEAgLTIzNjYsMTEg
KzI0NTMsMjggQEAgcmVzdGFydDoKIAkgIC8qIENoZWNrIGZpbGUgc3lzdGVt
IHdoaWxlIHdlJ3JlIGhhdmluZyB0aGUgZmlsZSBvcGVuIGFueXdheS4KIAkg
ICAgIFRoaXMgc3BlZWRzIHVwIHBhdGhfY29udiBub3RpY2FibHkgKH4xMCUp
LiAqLwogCSAgJiYgKGZzLmluaXRlZCAoKSB8fCBmcy51cGRhdGUgKCZ1cGF0
aCwgaCkpCisjaWZkZWYgRkFTVF9TWU1MSU5LX0NIRUNLCisJICAmJiAoZmFz
dF9zeW1saW5rX2NoZWNrID8gcGF0aF9jb252X3VwZGF0ZV9maShwYywgJnVw
YXRoKT4wIDoKKwkgICAgIE5UX1NVQ0NFU1MgKHN0YXR1cyA9IGZzLmhhc19i
dWdneV9iYXNpY19pbmZvICgpCisJCQkgPyBOdFF1ZXJ5QXR0cmlidXRlc0Zp
bGUgKCZhdHRyLCAmZmJpKQorCQkJIDogTnRRdWVyeUluZm9ybWF0aW9uRmls
ZSAoaCwgJmlvLCAmZmJpLCBzaXplb2YgZmJpLAorCQkJCQkJICAgRmlsZUJh
c2ljSW5mb3JtYXRpb24pKSkpCisgICAgICB7CisJICBpZiAoZmFzdF9zeW1s
aW5rX2NoZWNrKQorCSAgeworCSAgICAgIGZpbGVhdHRyID0gcGMtPmZpLkZp
bGVBdHRyaWJ1dGVzOworCSAgICAgIGZpbGVzaXplID0gcGMtPmZpLkFsbG9j
YXRpb25TaXplOworCSAgfQorCSAgZWxzZQorCSAgICAgIGZpbGVhdHRyID0g
ZmJpLkZpbGVBdHRyaWJ1dGVzOworICAgICAgfQorI2Vsc2UKIAkgICYmIE5U
X1NVQ0NFU1MgKHN0YXR1cyA9IGZzLmhhc19idWdneV9iYXNpY19pbmZvICgp
CiAJCQkgPyBOdFF1ZXJ5QXR0cmlidXRlc0ZpbGUgKCZhdHRyLCAmZmJpKQog
CQkJIDogTnRRdWVyeUluZm9ybWF0aW9uRmlsZSAoaCwgJmlvLCAmZmJpLCBz
aXplb2YgZmJpLAogCQkJCQkJICAgRmlsZUJhc2ljSW5mb3JtYXRpb24pKSkK
IAlmaWxlYXR0ciA9IGZiaS5GaWxlQXR0cmlidXRlczsKKyNlbmRpZgogICAg
ICAgZWxzZQogCXsKIAkgIGRlYnVnX3ByaW50ZiAoIiVwID0gTnRRdWVyeUlu
Zm9ybWF0aW9uRmlsZSAoJVMpIiwgc3RhdHVzLCAmdXBhdGgpOwpAQCAtMjQ4
NCw2ICsyNTg4LDkgQEAgcmVzdGFydDoKICAgICAgIGlmICgoZmlsZWF0dHIg
JiAoRklMRV9BVFRSSUJVVEVfUkVBRE9OTFkgfCBGSUxFX0FUVFJJQlVURV9E
SVJFQ1RPUlkpKQogCSAgPT0gRklMRV9BVFRSSUJVVEVfUkVBRE9OTFkgJiYg
c3VmZml4Lmxua19tYXRjaCAoKSkKIAl7CisjaWZkZWYgRkFTVF9TWU1MSU5L
X0NIRUNLCisJICBPUEVOX0lGX05FRURFRCgpOworI2VuZGlmCiAJICBpZiAo
IShhY2Nlc3MgJiBHRU5FUklDX1JFQUQpKQogCSAgICByZXMgPSAwOwogCSAg
ZWxzZQpAQCAtMjUyNiw2ICsyNjMzLDkgQEAgcmVzdGFydDoKICAgICAgIGVs
c2UgaWYgKChmaWxlYXR0ciAmIEZJTEVfQVRUUklCVVRFX1JFUEFSU0VfUE9J
TlQpCiAJICAgICAgICYmICFmcy5pc19yZW1vdGVfZHJpdmUoKSkKIAl7Cisj
aWZkZWYgRkFTVF9TWU1MSU5LX0NIRUNLCisJICBPUEVOX0lGX05FRURFRCgp
OworI2VuZGlmCiAJICByZXMgPSBjaGVja19yZXBhcnNlX3BvaW50IChoKTsK
IAkgIGlmIChyZXMgPT0gLTEpCiAJICAgIHsKQEAgLTI1NTAsOCArMjY2MCwx
NyBAQCByZXN0YXJ0OgogCSBoYXZlIHRoZSBgc3lzdGVtJyBmaWxlIGF0dHJp
YnV0ZS4gIE9ubHkgZmlsZXMgY2FuIGJlIHN5bWxpbmtzCiAJICh3aGljaCBj
YW4gYmUgc3ltbGlua3MgdG8gZGlyZWN0b3JpZXMpLiAqLwogICAgICAgZWxz
ZSBpZiAoKGZpbGVhdHRyICYgKEZJTEVfQVRUUklCVVRFX1NZU1RFTSB8IEZJ
TEVfQVRUUklCVVRFX0RJUkVDVE9SWSkpCisjaWZkZWYgRkFTVF9TWU1MSU5L
X0NIRUNLCisJICAgICAgID09IEZJTEVfQVRUUklCVVRFX1NZU1RFTSAmJgor
CSAgICAgICAoIWZhc3Rfc3ltbGlua19jaGVjayA/IDEgOgorCQkgICAoZmls
ZXNpemUuUXVhZFBhcnQ+c3RybGVuKCIhPHN5bWxpbms+IikgJiYgZmlsZXNp
emUuUXVhZFBhcnQ8NTEyKSkpCisjZWxzZQogCSAgICAgICA9PSBGSUxFX0FU
VFJJQlVURV9TWVNURU0pCisjZW5kaWYKIAl7CisjaWZkZWYgRkFTVF9TWU1M
SU5LX0NIRUNLCisJICBPUEVOX0lGX05FRURFRCgpOworI2VuZGlmCiAJICBp
ZiAoIShhY2Nlc3MgJiBHRU5FUklDX1JFQUQpKQogCSAgICByZXMgPSAwOwog
CSAgZWxzZQpAQCAtMjU2NSw2ICsyNjg0LDkgQEAgcmVzdGFydDoKIAkgKHdo
aWNoIGNhbiBiZSBzeW1saW5rcyB0byBkaXJlY3RvcmllcykuICovCiAgICAg
ICBlbHNlIGlmIChmcy5pc19uZnMgKCkgJiYgIW5vX2VhICYmICEoZmlsZWF0
dHIgJiBGSUxFX0FUVFJJQlVURV9ESVJFQ1RPUlkpKQogCXsKKyNpZmRlZiBG
QVNUX1NZTUxJTktfQ0hFQ0sKKwkgIE9QRU5fSUZfTkVFREVEKCk7CisjZW5k
aWYKIAkgIGlmICghKGFjY2VzcyAmIEdFTkVSSUNfUkVBRCkpCiAJICAgIHJl
cyA9IDA7CiAJICBlbHNlCkBAIC0yNTgxLDYgKzI3MDMsMTAgQEAgcmVzdGFy
dDoKICAgICAgIGJyZWFrOwogICAgIH0KIAorI2lmZGVmIEZBU1RfU1lNTElO
S19DSEVDSworICBpZiAocGZsYWdzICYgUENfS0VFUF9IQU5ETEUpCisgICAg
ICBPUEVOX0lGX05FRURFRCgpOworI2VuZGlmCiAgIGlmIChoKQogICAgIHsK
ICAgICAgIGlmIChwZmxhZ3MgJiBQQ19LRUVQX0hBTkRMRSkKSW5kZXg6IHdp
bnN1cC9jeWd3aW4vcGF0aC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3BhdGguaCx2CnJl
dHJpZXZpbmcgcmV2aXNpb24gMS4xNDUKZGlmZiAtdSAtcCAtcjEuMTQ1IHBh
dGguaAotLS0gd2luc3VwL2N5Z3dpbi9wYXRoLmgJNCBKdWwgMjAxMCAxNzox
MjoyNiAtMDAwMAkxLjE0NQorKysgd2luc3VwL2N5Z3dpbi9wYXRoLmgJMTMg
U2VwIDIwMTAgMTE6NDI6MDYgLTAwMDAKQEAgLTExNSw3ICsxMTUsMjAgQEAg
cHVibGljOgogfTsKIAogY2xhc3Mgc3ltbGlua19pbmZvOworI2lmIGRlZmlu
ZWQoRkFTVF9TWU1MSU5LX0NIRUNLKSB8fCBkZWZpbmVkKENBQ0hFX0ZJKQor
c3RydWN0IEZJTEVfTkVUV09SS19PUEVOX0lORk9STUFUSU9OMiB7CisgIExB
UkdFX0lOVEVHRVIgQ3JlYXRpb25UaW1lOworICBMQVJHRV9JTlRFR0VSIExh
c3RBY2Nlc3NUaW1lOworICBMQVJHRV9JTlRFR0VSIExhc3RXcml0ZVRpbWU7
CisgIExBUkdFX0lOVEVHRVIgQ2hhbmdlVGltZTsKKyAgTEFSR0VfSU5URUdF
UiBBbGxvY2F0aW9uU2l6ZTsKKyAgTEFSR0VfSU5URUdFUiBFbmRPZkZpbGU7
CisgIFVMT05HIEZpbGVBdHRyaWJ1dGVzOworfTsKIAorZXh0ZXJuIGJvb2wg
aW5vZGVfZnJvbV9oYXNoOworaW50IHBhdGhfY29udl91cGRhdGVfZmkocGF0
aF9jb252ICpwYywgUFVOSUNPREVfU1RSSU5HIHBhdGgpOworI2VuZGlmCiBj
bGFzcyBwYXRoX2NvbnYKIHsKICAgRFdPUkQgZmlsZWF0dHI7CkBAIC0xMzMs
MTEgKzE0NiwyMSBAQCBjbGFzcyBwYXRoX2NvbnYKICAgY29uc3QgY2hhciAq
bm9ybWFsaXplZF9wYXRoOwogICBpbnQgZXJyb3I7CiAgIGRldmljZSBkZXY7
CisjaWYgZGVmaW5lZChGQVNUX1NZTUxJTktfQ0hFQ0spIHx8IGRlZmluZWQo
Q0FDSEVfRkkpCisgIGludCBmaV91cGRhdGVkOworICB3Y2hhcl90IGZpX3Bh
dGhbTUFYX1BBVEhdOworICBGSUxFX05FVFdPUktfT1BFTl9JTkZPUk1BVElP
TjIgZmk7CisjZW5kaWYKIAogICBib29sIGlzcmVtb3RlICgpIGNvbnN0IHty
ZXR1cm4gZnMuaXNfcmVtb3RlX2RyaXZlICgpO30KICAgVUxPTkcgb2JqY2Fz
ZWluc2Vuc2l0aXZlICgpIGNvbnN0IHtyZXR1cm4gY2FzZWluc2Vuc2l0aXZl
O30KICAgYm9vbCBoYXNfYWNscyAoKSBjb25zdCB7cmV0dXJuICEocGF0aF9m
bGFncyAmIFBBVEhfTk9BQ0wpICYmIGZzLmhhc19hY2xzICgpOyB9CisjaWZk
ZWYgSU5PREVfRlJPTV9IQVNICisgIGJvb2wgaGFzZ29vZF9pbm9kZSAoKSBj
b25zdCB7cmV0dXJuIGlub2RlX2Zyb21faGFzaCA/IDAgOgorICAgICAgIShw
YXRoX2ZsYWdzICYgUEFUSF9JSEFTSCk7IH0KKyNlbHNlCiAgIGJvb2wgaGFz
Z29vZF9pbm9kZSAoKSBjb25zdCB7cmV0dXJuICEocGF0aF9mbGFncyAmIFBB
VEhfSUhBU0gpOyB9CisjZW5kaWYKICAgYm9vbCBpc2dvb2RfaW5vZGUgKF9f
aW5vNjRfdCBpbm8pIGNvbnN0OwogICBpbnQgaGFzX3N5bWxpbmtzICgpIGNv
bnN0IHtyZXR1cm4gcGF0aF9mbGFncyAmIFBBVEhfSEFTX1NZTUxJTktTO30K
ICAgaW50IGhhc19kb3NfZmlsZW5hbWVzX29ubHkgKCkgY29uc3Qge3JldHVy
biBwYXRoX2ZsYWdzICYgUEFUSF9ET1M7fQpAQCAtMjAwLDcgKzIyMywxMSBA
QCBjbGFzcyBwYXRoX2NvbnYKICAgcGF0aF9jb252IChjb25zdCBkZXZpY2Um
IGluX2RldikKICAgOiBmaWxlYXR0ciAoSU5WQUxJRF9GSUxFX0FUVFJJQlVU
RVMpLCB3aWRlX3BhdGggKE5VTEwpLCBwYXRoIChOVUxMKSwKICAgICBwYXRo
X2ZsYWdzICgwKSwga25vd25fc3VmZml4IChOVUxMKSwgbm9ybWFsaXplZF9w
YXRoIChOVUxMKSwgZXJyb3IgKDApLAorI2lmIGRlZmluZWQoRkFTVF9TWU1M
SU5LX0NIRUNLKSB8fCBkZWZpbmVkKENBQ0hFX0ZJKQorICAgIGRldiAoaW5f
ZGV2KSwgZmlfdXBkYXRlZCAoMCkKKyNlbHNlCiAgICAgZGV2IChpbl9kZXYp
CisjZW5kaWYKICAgewogICAgIHNldF9wYXRoIChpbl9kZXYubmF0aXZlKTsK
ICAgfQpAQCAtMjA5LDYgKzIzNiw5IEBAIGNsYXNzIHBhdGhfY29udgogCSAg
ICAgY29uc3Qgc3VmZml4X2luZm8gKnN1ZmZpeGVzID0gTlVMTCkKICAgOiBm
aWxlYXR0ciAoSU5WQUxJRF9GSUxFX0FUVFJJQlVURVMpLCB3aWRlX3BhdGgg
KE5VTEwpLCBwYXRoIChOVUxMKSwKICAgICBwYXRoX2ZsYWdzICgwKSwga25v
d25fc3VmZml4IChOVUxMKSwgbm9ybWFsaXplZF9wYXRoIChOVUxMKSwgZXJy
b3IgKDApCisjaWYgZGVmaW5lZChGQVNUX1NZTUxJTktfQ0hFQ0spIHx8IGRl
ZmluZWQoQ0FDSEVfRkkpCisgICAgLCBmaV91cGRhdGVkICgwKQorI2VuZGlm
CiAgIHsKICAgICBjaGVjayAoc3JjLCBvcHQsIHN1ZmZpeGVzKTsKICAgfQpA
QCAtMjE3LDYgKzI0Nyw5IEBAIGNsYXNzIHBhdGhfY29udgogCSAgICAgY29u
c3Qgc3VmZml4X2luZm8gKnN1ZmZpeGVzID0gTlVMTCkKICAgOiBmaWxlYXR0
ciAoSU5WQUxJRF9GSUxFX0FUVFJJQlVURVMpLCB3aWRlX3BhdGggKE5VTEwp
LCBwYXRoIChOVUxMKSwKICAgICBwYXRoX2ZsYWdzICgwKSwga25vd25fc3Vm
Zml4IChOVUxMKSwgbm9ybWFsaXplZF9wYXRoIChOVUxMKSwgZXJyb3IgKDAp
CisjaWYgZGVmaW5lZChGQVNUX1NZTUxJTktfQ0hFQ0spIHx8IGRlZmluZWQo
Q0FDSEVfRkkpCisgICAgLCBmaV91cGRhdGVkICgwKQorI2VuZGlmCiAgIHsK
ICAgICBjaGVjayAoc3JjLCBvcHQgfCBQQ19OVUxMRU1QVFksIHN1ZmZpeGVz
KTsKICAgfQpAQCAtMjI1LDYgKzI1OCw5IEBAIGNsYXNzIHBhdGhfY29udgog
CSAgICAgY29uc3Qgc3VmZml4X2luZm8gKnN1ZmZpeGVzID0gTlVMTCkKICAg
OiBmaWxlYXR0ciAoSU5WQUxJRF9GSUxFX0FUVFJJQlVURVMpLCB3aWRlX3Bh
dGggKE5VTEwpLCBwYXRoIChOVUxMKSwKICAgICBwYXRoX2ZsYWdzICgwKSwg
a25vd25fc3VmZml4IChOVUxMKSwgbm9ybWFsaXplZF9wYXRoIChOVUxMKSwg
ZXJyb3IgKDApCisjaWYgZGVmaW5lZChGQVNUX1NZTUxJTktfQ0hFQ0spIHx8
IGRlZmluZWQoQ0FDSEVfRkkpCisgICAgLCBmaV91cGRhdGVkICgwKQorI2Vu
ZGlmCiAgIHsKICAgICBjaGVjayAoc3JjLCBvcHQgfCBQQ19OVUxMRU1QVFks
IHN1ZmZpeGVzKTsKICAgfQpAQCAtMjMyLDYgKzI2OCw5IEBAIGNsYXNzIHBh
dGhfY29udgogICBwYXRoX2NvbnYgKCkKICAgOiBmaWxlYXR0ciAoSU5WQUxJ
RF9GSUxFX0FUVFJJQlVURVMpLCB3aWRlX3BhdGggKE5VTEwpLCBwYXRoIChO
VUxMKSwKICAgICBwYXRoX2ZsYWdzICgwKSwga25vd25fc3VmZml4IChOVUxM
KSwgbm9ybWFsaXplZF9wYXRoIChOVUxMKSwgZXJyb3IgKDApCisjaWYgZGVm
aW5lZChGQVNUX1NZTUxJTktfQ0hFQ0spIHx8IGRlZmluZWQoQ0FDSEVfRkkp
CisgICAgLCBmaV91cGRhdGVkICgwKQorI2VuZGlmCiAgIHt9CiAKICAgfnBh
dGhfY29udiAoKTsKSW5kZXg6IHdpbnN1cC9jeWd3aW4vc2VjdXJpdHkuY2MK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3Jj
L3dpbnN1cC9jeWd3aW4vc2VjdXJpdHkuY2MsdgpyZXRyaWV2aW5nIHJldmlz
aW9uIDEuMjQyCmRpZmYgLXUgLXAgLXIxLjI0MiBzZWN1cml0eS5jYwotLS0g
d2luc3VwL2N5Z3dpbi9zZWN1cml0eS5jYwkyMiBKdW4gMjAxMCAwOTo1NDoz
NiAtMDAwMAkxLjI0MgorKysgd2luc3VwL2N5Z3dpbi9zZWN1cml0eS5jYwkx
MyBTZXAgMjAxMCAxMTo0MjowNyAtMDAwMApAQCAtMjYsNiArMjYsMTY2IEBA
IGRldGFpbHMuICovCiAjaW5jbHVkZSAicHdkZ3JwLmgiCiAjaW5jbHVkZSA8
YWNsYXBpLmg+CiAKKyNpZmRlZiBGQVNUX1NFQ1VUSVJZX0NIRUNLCitib29s
IGZhc3Rfc2VjdXJpdHlfaW5mbyA9IHRydWU7CisKK2V4dGVybiAiQyIgewor
TlRTVEFUVVMgV0lOQVBJIFJ0bEdldE93bmVyU2VjdXJpdHlEZXNjcmlwdG9y
KAorICAgIFBTRUNVUklUWV9ERVNDUklQVE9SIFNlY3VyaXR5RGVzY3JpcHRv
ciwgUFNJRCAqT3duZXIsCisgICAgUEJPT0xFQU4gT3duZXJEZWZhdWx0ZWQp
OworTlRTVEFUVVMgV0lOQVBJIFJ0bEdldEdyb3VwU2VjdXJpdHlEZXNjcmlw
dG9yKAorICAgIFBTRUNVUklUWV9ERVNDUklQVE9SIFNlY3VyaXR5RGVzY3Jp
cHRvciwgUFNJRCAqR3JvdXAsCisgICAgUEJPT0xFQU4gR3JvdXBEZWZhdWx0
ZWQpOworTlRTVEFUVVMgV0lOQVBJIFJ0bEdldERhY2xTZWN1cml0eURlc2Ny
aXB0b3IoCisgICAgUFNFQ1VSSVRZX0RFU0NSSVBUT1IgU2VjdXJpdHlEZXNj
cmlwdG9yLAorICAgIFBCT09MRUFOIERhY2xQcmVzZW50LCBQQUNMICpEYWNs
LCBQQk9PTEVBTiBEYWNsRGVmYXVsdGVkKTsKK05UU1RBVFVTIFdJTkFQSSBS
dGxHZXRTYWNsU2VjdXJpdHlEZXNjcmlwdG9yKAorICAgIFBTRUNVUklUWV9E
RVNDUklQVE9SIFNlY3VyaXR5RGVzY3JpcHRvciwgUEJPT0xFQU4gU2FjbFBy
ZXNlbnQsIFBBQ0wgKlNhY2wsCisgICAgUEJPT0xFQU4gU2FjbERlZmF1bHRl
ZCk7CitVTE9ORyBXSU5BUEkgUnRsTGVuZ3RoU2VjdXJpdHlEZXNjcmlwdG9y
KAorICAgIFBTRUNVUklUWV9ERVNDUklQVE9SIFNlY3VyaXR5RGVzY3JpcHRv
cik7CitOVFNUQVRVUyBXSU5BUEkgUnRsQ3JlYXRlU2VjdXJpdHlEZXNjcmlw
dG9yKAorICAgIFBTRUNVUklUWV9ERVNDUklQVE9SIFNlY3VyaXR5RGVzY3Jp
cHRvciwgVUxPTkcgUmV2aXNpb24pOworTlRTVEFUVVMgV0lOQVBJIFJ0bENv
cHlTaWQoVUxPTkcgRGVzdGluYXRpb25TaWRMZW5ndGgsIFBTSUQgRGVzdGlu
YXRpb25TaWQsCisgIFBTSUQgU291cmNlU2lkKTsKK1VMT05HIFdJTkFQSSBS
dGxMZW5ndGhTaWQgKFBTSUQgU2lkKTsKK05UU1RBVFVTIFdJTkFQSSBSdGxT
ZXRPd25lclNlY3VyaXR5RGVzY3JpcHRvcigKKyAgICBQU0VDVVJJVFlfREVT
Q1JJUFRPUiBTZWN1cml0eURlc2NyaXB0b3IsIFBTSUQgT3duZXIsCisgICAg
Qk9PTEVBTiBPd25lckRlZmF1bHRlZCk7CitOVFNUQVRVUyBXSU5BUEkgUnRs
U2V0R3JvdXBTZWN1cml0eURlc2NyaXB0b3IoCisgICAgUFNFQ1VSSVRZX0RF
U0NSSVBUT1IgU2VjdXJpdHlEZXNjcmlwdG9yLCBQU0lEIEdyb3VwLAorICAg
IEJPT0xFQU4gR3JvdXBEZWZhdWx0ZWQpOworTlRTVEFUVVMgV0lOQVBJIFJ0
bFNldERhY2xTZWN1cml0eURlc2NyaXB0b3IoCisgICAgUFNFQ1VSSVRZX0RF
U0NSSVBUT1IgU2VjdXJpdHlEZXNjcmlwdG9yLCBCT09MRUFOIERhY2xQcmVz
ZW50LCBQQUNMIERhY2wsCisgICAgQk9PTEVBTiBEYWNsRGVmYXVsdGVkKTsK
K05UU1RBVFVTIFdJTkFQSSBSdGxTZXRTYWNsU2VjdXJpdHlEZXNjcmlwdG9y
KAorICAgIFBTRUNVUklUWV9ERVNDUklQVE9SIFNlY3VyaXR5RGVzY3JpcHRv
ciwgQk9PTEVBTiBTYWNsUHJlc2VudCwgUEFDTCBTYWNsLAorICAgIEJPT0xF
QU4gU2FjbERlZmF1bHRlZCk7Cit9CisKKyNkZWZpbmUgSUZfUFRSX1NFVChw
dHIsIHZhbCkgXAorZG8geyBcCisgICAgaWYgKHB0cikgXAorICAgICAgICAq
KHB0cikgPSB2YWw7IFwKK30gd2hpbGUgKDApCitEV09SRCB6R2V0U2VjdXJp
dHlEZXNjcmlwdG9yUGFydHMoUElTRUNVUklUWV9ERVNDUklQVE9SIHNkLAor
ICAgIFNFQ1VSSVRZX0lORk9STUFUSU9OIHNpLCBQU0lEICpzaWRvLCBQU0lE
ICpzaWRnLAorICAgIFBBQ0wgKmRhY2wsIFBBQ0wgKnNhY2wsIFBTRUNVUklU
WV9ERVNDUklQVE9SICpvdXRfc2QpCit7CisgICAgTlRTVEFUVVMgc3RhdCA9
IDA7CisgICAgUElTRUNVUklUWV9ERVNDUklQVE9SIF9vdXRfc2QgPSBOVUxM
OworICAgIFBBQ0wgX2RhY2wgPSBOVUxMLCBfc2FjbCA9IE5VTEw7CisgICAg
Qk9PTEVBTiB1bnVzZWQsIGhhdmVfcGFyYW07CisgICAgRFdPUkQgcmV0ID0g
Tk9fRVJST1I7CisgICAgY2hhciAqYnVmOworICAgIFBTSUQgb3duZXIgPSBO
VUxMLCBncm91cCA9IE5VTEw7CisgICAgSUZfUFRSX1NFVChzaWRvLCBOVUxM
KTsKKyAgICBJRl9QVFJfU0VUKHNpZGcsIE5VTEwpOworICAgIElGX1BUUl9T
RVQoZGFjbCwgTlVMTCk7CisgICAgSUZfUFRSX1NFVChzYWNsLCBOVUxMKTsK
KyAgICAqb3V0X3NkID0gTlVMTDsKKyAgICBpZiAoKHN0YXQgPSBSdGxHZXRP
d25lclNlY3VyaXR5RGVzY3JpcHRvcihzZCwgJm93bmVyLCAmdW51c2VkKSkp
CisJZ290byBFeGl0OworICAgIGlmICgoc3RhdCA9IFJ0bEdldEdyb3VwU2Vj
dXJpdHlEZXNjcmlwdG9yKHNkLCAmZ3JvdXAsICZ1bnVzZWQpKSkKKwlnb3Rv
IEV4aXQ7CisgICAgaWYgKChzdGF0ID0gUnRsR2V0RGFjbFNlY3VyaXR5RGVz
Y3JpcHRvcihzZCwgJmhhdmVfcGFyYW0sICZfZGFjbCwKKwkmdW51c2VkKSkp
CisgICAgeworCWdvdG8gRXhpdDsKKyAgICB9CisgICAgaWYgKCFoYXZlX3Bh
cmFtKQorCV9kYWNsID0gTlVMTDsKKyAgICBpZiAoKHN0YXQgPSBSdGxHZXRT
YWNsU2VjdXJpdHlEZXNjcmlwdG9yKHNkLCAmaGF2ZV9wYXJhbSwgJl9zYWNs
LAorCSZ1bnVzZWQpKSkKKyAgICB7CisJZ290byBFeGl0OworICAgIH0KKyAg
ICBpZiAoIWhhdmVfcGFyYW0pCisJX3NhY2wgPSBOVUxMOworICAgIF9vdXRf
c2QgPSAoUElTRUNVUklUWV9ERVNDUklQVE9SKUxvY2FsQWxsb2MoTFBUUiwK
KwlSdGxMZW5ndGhTZWN1cml0eURlc2NyaXB0b3Ioc2QpKTsKKyAgICBSdGxD
cmVhdGVTZWN1cml0eURlc2NyaXB0b3IoX291dF9zZCwgU0VDVVJJVFlfREVT
Q1JJUFRPUl9SRVZJU0lPTik7CisgICAgYnVmID0gKGNoYXIgKilfb3V0X3Nk
ICsgc2l6ZW9mKFNFQ1VSSVRZX0RFU0NSSVBUT1IpOworICAgIGlmIChzaSAm
IE9XTkVSX1NFQ1VSSVRZX0lORk9STUFUSU9OKQorICAgIHsKKwlpZiAoIW93
bmVyKQorCXsKKwkgICAgcmV0ID0gRVJST1JfTk9fU0VDVVJJVFlfT05fT0JK
RUNUOworCSAgICBnb3RvIEV4aXQ7CisJfQorCVJ0bENvcHlTaWQoUnRsTGVu
Z3RoU2lkKG93bmVyKSwgKFBTSUQpYnVmLCBvd25lcik7CisJUnRsU2V0T3du
ZXJTZWN1cml0eURlc2NyaXB0b3IoX291dF9zZCwgKFBTSUQpYnVmLCAwKTsK
KwlidWYgKz0gUnRsTGVuZ3RoU2lkKG93bmVyKTsKKwlJRl9QVFJfU0VUKHNp
ZG8sIF9vdXRfc2QtPk93bmVyKTsKKyAgICB9CisgICAgaWYgKHNpICYgR1JP
VVBfU0VDVVJJVFlfSU5GT1JNQVRJT04pCisgICAgeworCWlmICghZ3JvdXAp
CisJeworCSAgICByZXQgPSBFUlJPUl9OT19TRUNVUklUWV9PTl9PQkpFQ1Q7
CisJICAgIGdvdG8gRXhpdDsKKwl9CisJUnRsQ29weVNpZChSdGxMZW5ndGhT
aWQoZ3JvdXApLCAoUFNJRClidWYsIGdyb3VwKTsKKwlSdGxTZXRHcm91cFNl
Y3VyaXR5RGVzY3JpcHRvcihfb3V0X3NkLCAoUFNJRClidWYsIDApOworCWJ1
ZiArPSBSdGxMZW5ndGhTaWQoZ3JvdXApOworCUlGX1BUUl9TRVQoc2lkZywg
X291dF9zZC0+R3JvdXApOworICAgIH0KKyAgICBpZiAoKHNpICYgREFDTF9T
RUNVUklUWV9JTkZPUk1BVElPTikgJiYgX2RhY2wpCisgICAgeworCW1lbWNw
eShidWYsIF9kYWNsLCBfZGFjbC0+QWNsU2l6ZSk7CisJUnRsU2V0RGFjbFNl
Y3VyaXR5RGVzY3JpcHRvcihfb3V0X3NkLCAxLCAoQUNMICopYnVmLCAwKTsK
KwlJRl9QVFJfU0VUKGRhY2wsIF9vdXRfc2QtPkRhY2wpOworICAgIH0KKyAg
ICBpZiAoKHNpICYgU0FDTF9TRUNVUklUWV9JTkZPUk1BVElPTikgJiYgX3Nh
Y2wpCisgICAgeworICAgICAgICBtZW1jcHkoYnVmLCBfc2FjbCwgX3NhY2wt
PkFjbFNpemUpOworICAgICAgICBSdGxTZXRTYWNsU2VjdXJpdHlEZXNjcmlw
dG9yKF9vdXRfc2QsIDEsIChBQ0wgKilidWYsIDApOworCUlGX1BUUl9TRVQo
c2FjbCwgX291dF9zZC0+U2FjbCk7CisgICAgfQorICAgICpvdXRfc2QgPSBf
b3V0X3NkOworICAgIF9vdXRfc2QgPSBOVUxMOworRXhpdDoKKyAgICBpZiAo
c3RhdCkKKwlyZXQgPSBSdGxOdFN0YXR1c1RvRG9zRXJyb3Ioc3RhdCk7Cisg
ICAgaWYgKF9vdXRfc2QpCisJTG9jYWxGcmVlKF9vdXRfc2QpOworICAgIHJl
dHVybiByZXQ7Cit9CisKKyNkZWZpbmUgUFNEX0JBU0VfTEVOR1RIIDEwMjQK
K0RXT1JEIHpHZXRTZWN1cml0eUluZm8oSEFORExFIGZoLCBTRV9PQkpFQ1Rf
VFlQRSBPYmplY3RUeXBlLAorICAgIFNFQ1VSSVRZX0lORk9STUFUSU9OIFNl
Y3VyaXR5SW5mbywgUFNJRCAqcHBzaWRPd25lciwgUFNJRCAqcHBzaWRHcm91
cCwKKyAgICBQQUNMICpwcERhY2wsIFBBQ0wgKnBwU2FjbCwgUFNFQ1VSSVRZ
X0RFU0NSSVBUT1IgKnBwU2VjdXJpdHlEZXNjcmlwdG9yKQoreworICAgIFVM
T05HIGJ5dGVzX25lZWRlZCA9IDA7CisgICAgaW50IHJldDsKKyAgICBpZiAo
KHJldCA9IE50UXVlcnlTZWN1cml0eU9iamVjdChmaCwgU2VjdXJpdHlJbmZv
LAorCShQSVNFQ1VSSVRZX0RFU0NSSVBUT1IpX215X3Rscy5sb2NhbHMuc2Vj
dXJpdHlfYnVmLAorCV9teV90bHMubG9jYWxzLnNlY3VyaXR5X2J1Zl9sZW4s
ICZieXRlc19uZWVkZWQpKSkKKyAgICB7CisJaWYgKHJldCE9U1RBVFVTX0JV
RkZFUl9UT09fU01BTEwpCisJICAgIHJldHVybiBSdGxOdFN0YXR1c1RvRG9z
RXJyb3IocmV0KTsKKwlfbXlfdGxzLmxvY2Fscy5zZWN1cml0eV9idWYgPSBy
ZWFsbG9jKF9teV90bHMubG9jYWxzLnNlY3VyaXR5X2J1ZiwKKwkgICAgYnl0
ZXNfbmVlZGVkKTsKKwlfbXlfdGxzLmxvY2Fscy5zZWN1cml0eV9idWZfbGVu
ID0gYnl0ZXNfbmVlZGVkOworCWlmICgocmV0ID0gTnRRdWVyeVNlY3VyaXR5
T2JqZWN0KGZoLCBTZWN1cml0eUluZm8sCisJICAgIChQSVNFQ1VSSVRZX0RF
U0NSSVBUT1IpX215X3Rscy5sb2NhbHMuc2VjdXJpdHlfYnVmLAorCSAgICBf
bXlfdGxzLmxvY2Fscy5zZWN1cml0eV9idWZfbGVuLCAmYnl0ZXNfbmVlZGVk
KSkpCisJeworCSAgICByZXR1cm4gcmV0OworCX0KKyAgICB9CisgICAgaWYg
KHJldD09Tk9fRVJST1IpCisgICAgeworCXJldHVybiB6R2V0U2VjdXJpdHlE
ZXNjcmlwdG9yUGFydHMoCisJICAgIChQSVNFQ1VSSVRZX0RFU0NSSVBUT1Ip
X215X3Rscy5sb2NhbHMuc2VjdXJpdHlfYnVmLAorCSAgICBTZWN1cml0eUlu
Zm8sIHBwc2lkT3duZXIsIHBwc2lkR3JvdXAsIHBwRGFjbCwgcHBTYWNsLAor
CSAgICBwcFNlY3VyaXR5RGVzY3JpcHRvcik7CisgICAgfQorICAgIHJldHVy
biByZXQ7Cit9CisjZW5kaWYKKwogI2RlZmluZSBBTExfU0VDVVJJVFlfSU5G
T1JNQVRJT04gKERBQ0xfU0VDVVJJVFlfSU5GT1JNQVRJT04gXAogCQkJCSAg
fCBHUk9VUF9TRUNVUklUWV9JTkZPUk1BVElPTiBcCiAJCQkJICB8IE9XTkVS
X1NFQ1VSSVRZX0lORk9STUFUSU9OKQpAQCAtNDcsOCArMjA3LDIxIEBAIGdl
dF9maWxlX3NkIChIQU5ETEUgZmgsIHBhdGhfY29udiAmcGMsIHMKIAkgICAg
IElOSEVSSVRFRF9BQ0UgZmxhZyBpcyBuZXZlciBzZXQuICBPbmx5IGJ5IGNh
bGxpbmcgR2V0U2VjdXJpdHlJbmZvCiAJICAgICB5b3UgZ2V0IHRoaXMgaW5m
b3JtYXRpb24uICBPaCB3ZWxsLiAqLwogCSAgUFNFQ1VSSVRZX0RFU0NSSVBU
T1IgcHNkOworI2lmZGVmIEZBU1RfU0VDVVRJUllfQ0hFQ0sKKwkgIGlmIChm
YXN0X3NlY3VyaXR5X2luZm8pCisJICB7CisJICAgICAgZXJyb3IgPSB6R2V0
U2VjdXJpdHlJbmZvIChmaCwgU0VfRklMRV9PQkpFQ1QsIAorCQkgIEFMTF9T
RUNVUklUWV9JTkZPUk1BVElPTiwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwg
JnBzZCk7CisJICB9CisJICBlbHNlCisJICB7CisJICAgICAgZXJyb3IgPSBH
ZXRTZWN1cml0eUluZm8gKGZoLCBTRV9GSUxFX09CSkVDVCwgCisJCSAgQUxM
X1NFQ1VSSVRZX0lORk9STUFUSU9OLCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxM
LCAmcHNkKTsKKwkgIH0KKyNlbHNlCiAJICBlcnJvciA9IEdldFNlY3VyaXR5
SW5mbyAoZmgsIFNFX0ZJTEVfT0JKRUNULCBBTExfU0VDVVJJVFlfSU5GT1JN
QVRJT04sCiAJCQkJICAgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgJnBzZCk7
CisjZW5kaWYKIAkgIGlmIChlcnJvciA9PSBFUlJPUl9TVUNDRVNTKQogCSAg
ICB7CiAJICAgICAgc2QgPSBwc2Q7Cg==

--------------040009070507010109050000--
