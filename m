From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [RFA]: patch to 'rename', was Re: Wierd patch problem + simple fix
Date: Mon, 22 May 2000 07:57:00 -0000
Message-id: <20000522105742.A6343@cygnus.com>
References: <392633C8.4B20FBE5@ece.gatech.edu> <20000520215546.E2054@cygnus.com> <39277F56.43288E5E@ece.gatech.edu> <3927DD35.C31AC4AA@vinschen.de> <20000521183456.B1386@cygnus.com> <3928FF7A.B4402B9C@vinschen.de>
X-SW-Source: 2000-q2/msg00072.html

On Mon, May 22, 2000 at 11:35:54AM +0200, Corinna Vinschen wrote:
>Chris Faylor wrote:
>> 
>> On Sun, May 21, 2000 at 02:57:25PM +0200, Corinna Vinschen wrote:
>> >I'm completely unable to reproduce that problem...
>> >
>> >...as far as the $TMP directory is on the same drive
>> >   as the patched file!
>> >[...]
>> But I really can't believe that this is a generic patch bug.
>> /tmp is often located on a different partition than a 'src'
>> directory and it is hard to believe that this could be broken
>> in patch.
>> 
>> Is it possible that some stat (st_dev maybe?) field has changed
>> recently?
>
>I have investigated that phenomenon and I found that
>`MoveFile' returns ERROR_FILE_EXISTS while our `rename'
>code checks only for ERROR_ALREADY_EXISTS. Perhaps the return
>code is OS dependent? I'm testing mainly on W2K.

Or this got dropped when I recently rewrote that function.  Please
check in the patch.  It looks good.

cgf

>ChangeLog:
>==========
>
>	* syscalls.cc (_rename): Additionally check for ERROR_FILE_EXISTS
>	if MoveFile fails.
