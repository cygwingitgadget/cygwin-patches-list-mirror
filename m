From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: preliminary patch2 for i18n: change the code page to ANSI.
Date: Mon, 03 Jul 2000 19:30:00 -0000
Message-id: <20000703222950.A5294@cygnus.com>
References: <s1saefyooqa.fsf@jaist.ac.jp> <20000703190459.A30846@cygnus.com> <s1s8zviodkm.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00004.html

On Tue, Jul 04, 2000 at 11:04:57AM +0900, Kazuhiro Fujieda wrote:
>> This test against 0xe0 was a recent addition from someone who
>> claimed that it made things work better under 95 or 98, I
>> believe.
>
>You are right. Before you added the test against 0xe0, this test
>was done only against 0. It couldn't distinguish extended keys
>under Win9x.

Ok.  I've applied this patch.  Thanks.

I do wonder if the elimination of the SetFileApisToOEM/CharToOem will
cause other problems since I've tried to eliminate those in the past
but have gotten complaints.

Maybe your changes to fhandler_console are all that is required but I
would appreciate it if you would remain vigilant for complaints on the
cygwin mailing list once this new version is released.

cgf
