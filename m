From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Tue, 05 Jun 2001 03:52:00 -0000
Message-id: <175469249.20010605145207@logos-m.ru>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru> <20010511142639.A26920@redhat.com> <64168820861.20010512154228@logos-m.ru> <178350282529.20010514180653@logos-m.ru> <18289228183.20010524164714@logos-m.ru> <20010529214139.B14906@redhat.com> <13839205033.20010530104808@logos-m.ru> <20010530095435.C17603@redhat.com> <20010531012740.A21788@redhat.com>
X-SW-Source: 2001-q2/msg00279.html

Hi!

Thursday, 31 May, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> On Wed, May 30, 2001 at 09:54:35AM -0400, Christopher Faylor wrote:
>>Ok.  I have some pending changes to path.cc that I would like to get in
>>before you checkin your changes.  I am storing the DriveType and
>>volume information in the path_conv class now.  I'll check this in
>>as soon as I've had a chance to test it some more.

CF> Ok.  These are checked in.  I made all sorts of changes to propate the
CF> remoteness of the path from path_conv and then it turned out that I'd
CF> misdiagnosed the problem I was fixing and I really didn't need it.

CF> I left the setting in because I suspect that it will still be useful,
CF> though.

CF> So, go ahead and check your stuff in, Egor.

done. i've also moved updating of drive type and remoteness flag to
path_conv::update_fs_info(), where all other fs information is updated
whenever rootdir() component of path changes.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

