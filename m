Return-Path: <cygwin-patches-return-7111-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15231 invoked by alias); 22 Sep 2010 05:46:10 -0000
Received: (qmail 15219 invoked by uid 22791); 22 Sep 2010 05:46:08 -0000
X-SWARE-Spam-Status: No, hits=0.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 22 Sep 2010 05:46:04 +0000
Received: by fxm7 with SMTP id 7so180788fxm.2        for <cygwin-patches@cygwin.com>; Tue, 21 Sep 2010 22:46:02 -0700 (PDT)
Received: by 10.223.105.144 with SMTP id t16mr5371381fao.9.1285134361787;        Tue, 21 Sep 2010 22:46:01 -0700 (PDT)
Received: from [10.71.1.25] (wall-ext.hola.org [212.235.66.73])        by mx.google.com with ESMTPS id c20sm4038354fak.33.2010.09.21.22.45.59        (version=SSLv3 cipher=RC4-MD5);        Tue, 21 Sep 2010 22:46:00 -0700 (PDT)
Message-ID: <4C99980F.5010202@gmail.com>
Date: Wed, 22 Sep 2010 05:46:00 -0000
From: Yoni Londner <yonihola2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de> <20100910172312.GA23015@ednor.casa.cgf.cx> <20100910183940.GA14132@calimero.vinschen.de> <4C8C9408.3060304@gmail.com> <20100912114115.GA1113@calimero.vinschen.de> <4C8E0AC7.9080409@gmail.com> <20100914100533.GC15121@calimero.vinschen.de>
In-Reply-To: <20100914100533.GC15121@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-SW-Source: 2010-q3/txt/msg00071.txt.bz2

Hi,

 > There's also the problem of handling NFS shares.  However, I just had an
 > idea how to speed up symlink_info::check without neglecting NFS shares.
 > This will take some time, though since it turns a lot of code upside
 > down.  Stay tuned.

This sounds great! Cygwin filesystem performance is a very important 
issue, and any improvement is more than welcome!

 > I don't understand how you think this should work.  The filter expression
 > given to NtQueryDirectoryFile is either a constant string and has to 
match
 > the filename exactly, or it contains wildcards.  This is documented
 > behaviour: 
http://msdn.microsoft.com/en-us/library/ff567047%28VS.85%29.aspx
 > So, "foo" works, "foo*" works, but a list like "foo foo.exe foo.lnk"
 > does not.

There are two options for stat() and other places the need file info 
(such as check_symlink):

1) CreateFile(the_dir), then NtQueryDirectoryFile("foo*") and retrieve 
all the info (including the hardlink), filter out the results in 
user-mode ("foo", "foo.exe", "foo.lnk"), and then call CloseHandle().

2) CreateFile(the_dir), NtQueryDirectoryFile("foo"), 
NtQueryDirectoryFile("foo.exe"), NtQueryDirectoryFile("foo.lnk"), 
CloseHandle(). The calls to NtQueryDirectoryFile() should be with 
RestartScan=1, so that the the_dir handle can be reused. Also 
ReturnSingleEntry=1 can be set to improve performance.

This is instead what is done today in cygwin:
3) CreateFile("foo"), NtQueryFileInformation(), CloseHandle() (and 
repeat this for "foo.exe" and "foo.lnk")

I did some performance tests comparing #1 #2 and #3.

I found out that #1 and #2 are both around 10x to 100x (!!!) times 
faster than #3.

I checked out why, and found out that #1 and #2 don't modify the access 
time of the file, whereas #3 does. This already immediately causes a 
huge performance penalty (and it is also not according to the posix 
standard: stat("foo") should not update atime of "foo").
Another reason is that the kernel NTFS driver performs automatically 
read-ahead of the file, thus just stat("foo") (which calls 
CreateFile("foo") in #3) causes the first 64k of "foo" to be read from 
the disk - slowing down performance tremendously. Think of "ls /bin" 
with 3500 files: NTFS reads the first 64K of all the 3500 files! no 
wonder it takes so long...
And yet another reason why #3 is way slower than #1 and #2 is the 
anti-viruses: Nearly all Windows users install an AV (or use Win7 MS 
AV). These trap and monitor all CreateFile() to regular files (not to 
directory files). Therefore CreateFile() to a regular file can take a 
lot lot longer than CreateFile() to a directory.

I would suggest using #2 over #1, since its simpler code-wise, and I did 
not see any serious performance difference between the two.

Yoni


On 14/9/2010 12:05 PM, Corinna Vinschen wrote:
> On Sep 13 13:28, Yoni Londner wrote:
>> Hi,
>>
>>> However, isn't that kind of a chicken/egg situation?  If you want to
>>> reuse the content of the FILE_BOTH{_ID}_DIRECTORY_INFORMATION structure
>>> from a previous call to readdir, you would have to call the
>>
>> I am not talking about reusing info from a previous readdir.
>>
>> Every single file cygwin tries to access, it does it in a loop,
>> trying afterwards to check for *.lnk file.
>>
>> Using the directory query operations, it is possible to get this
>> info faster:
>> instead of getting file info for FOO and then for "FOO.lnk",
>> Cygwin can query the directory info for "FOO FOO.LNK" (for the file
>> requested, plus its possible symlink file).
>
> I don't understand how you think this should work.  The filter expression
> given to NtQueryDirectoryFile is either a constant string and has to match
> the filename exactly, or it contains wildcards.  This is documented
> behaviour: http://msdn.microsoft.com/en-us/library/ff567047%28VS.85%29.aspx
> So, "foo" works, "foo*" works, but a list like "foo foo.exe foo.lnk"
> does not.
>
> There's also the problem of handling NFS shares.  However, I just had an
> idea how to speed up symlink_info::check without neglecting NFS shares.
> This will take some time, though since it turns a lot of code upside
> down.  Stay tuned.
>
>
> Corinna
>
