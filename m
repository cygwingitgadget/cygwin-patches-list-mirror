Return-Path: <cygwin-patches-return-9890-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65411 invoked by alias); 30 Dec 2019 20:54:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65402 invoked by uid 89); 30 Dec 2019 20:54:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=responsibility, H*f:sk:aafbc75, H*MI:sk:aafbc75, H*i:sk:aafbc75
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Dec 2019 20:54:49 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id m23riJD3i17ZDm23siens8; Mon, 30 Dec 2019 13:54:48 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
To: cygwin-patches@cygwin.com
References: <20191229175637.1050-1-kbrown@cornell.edu> <d88c5dee-9457-3c39-960c-ea07842cd0c5@SystematicSw.ab.ca> <aafbc75d-11db-0faf-6e13-72681c5784a3@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <f964457b-9d33-a252-3cc9-e035a4fe1c1a@SystematicSw.ab.ca>
Date: Mon, 30 Dec 2019 20:54:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <aafbc75d-11db-0faf-6e13-72681c5784a3@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00161.txt.bz2

On 2019-12-30 12:53, Ken Brown wrote:
> On 12/30/2019 2:18 PM, Brian Inglis wrote:
>> On 2019-12-29 10:56, Ken Brown wrote:
>>> Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
>>> Following Linux, the first patch in this series allows the call to
>>> succeed if O_PATH is also specified.
>>>
>>> According to the Linux man page for 'open', the file descriptor
>>> returned by the call should be usable as the dirfd argument in calls
>>> to fstatat and readlinkat with an empty pathname, to have
>>> the calls operate on the symbolic link.  The second and third patches
>>> achieve this.  For fstatat, we do this by adding support
>>> for the AT_EMPTY_PATH flag.
>>>
>>> Note: The man page mentions fchownat and linkat also.  linkat already
>>> supports the AT_EMPTY_PATH flag, so nothing needs to be done.  But I
>>> don't understand how this could work for fchownat, because fchown
>>> fails with EBADF if its fd argument was opened with O_PATH.  So I
>>> haven't touched fchownat.
>>>
>>> Am I missing something?
>>
>> WSL $ man 2 chown
>> ...
>> "AT_EMPTY_PATH (since Linux 2.6.39)
>> If pathname is an empty string, operate on the file referred to
>> by dirfd (which may have been obtained using the open(2) O_PATH
>> flag). In  this case, dirfd can refer to any type of file, not
>> just a directory. If dirfd is AT_FDCWD, the  call operates on
>> the current working directory. This flag is Linux-specific; deâ
>> fine _GNU_SOURCE to obtain its definition."
>>
>> says chown the dirfd, regardless of what it is,
>> except if AT_FDCWD, chown the CWD.
>>
>> WSL $ man 2 open
>> "O_PATH (since Linux 2.6.39)
>> Obtain a file descriptor that can be used for two purposes: to
>> indicate a location in the filesystem tree and to perform
>> operations that act purely at the file descriptor level.  The
>> file itself is not opened, and other file operations (e.g.,
>> read(2), write(2), fchmod(2), fchown(2), fgetxattr(2),
>> ioctl(2), mmap(2)) fail with the error EBADF."
>>
>> O_PATH does not open the file, so fchown returns EBADF,
>> as it requires an fd of an open file.
> 
> I think you've just confirmed what I already said: If fchownat is called with 
> AT_EMPTY_PATH, with an empty pathname, and with dirfd referring to a file that 
> was opened with O_PATH, then fchownat will fail with EBADF.
> 
> So for the purposes of this patch series, I don't see the point of adding 
> support for AT_EMPTY_PATH in fchownat.
> 
> Am I missing something?

That is the user's problem: it is their responsibility to pass an fd open for
reading or searching, not one opened with O_PATH (on Linux or Cygwin), or
AT_FDCWD; it is Cygwin's responsibility to ensure that valid args succeed and
invalid args return the expected errno.

$ man fchownat
...
"EBADF  The path argument does not specify an absolute path and
	the fd argument is neither AT_FDCWD nor a valid file descriptor
	open for reading or searching."

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
