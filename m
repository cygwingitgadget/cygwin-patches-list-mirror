Return-Path: <cygwin-patches-return-9922-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36021 invoked by alias); 13 Jan 2020 17:24:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35999 invoked by uid 89); 13 Jan 2020 17:24:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=principal, introduction, HX-Languages-Length:2701, Principal
X-HELO: us-smtp-delivery-1.mimecast.com
Received: from us-smtp-1.mimecast.com (HELO us-smtp-delivery-1.mimecast.com) (205.139.110.61) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 17:24:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;	s=mimecast20190719; t=1578936273;	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:	 to:to:cc:mime-version:mime-version:content-type:content-type:	 content-transfer-encoding:content-transfer-encoding:	 in-reply-to:in-reply-to:references:references;	bh=GjgLHv3kvJUInewVq1T8TmByrlpUC8XXdfWX7cRMBog=;	b=BkQAY7RRfFYcoN2Wdt7trqqn6ykA3JxJKC7dA/Um8VEGGcWnwBxhol3YBtK4txz8gqGrW7	/1Z2xiWd1oN0Bjs/99xEYPjogyvoDIY34NX/kZOC5VaYMIsJp7a+EzAFwhpBI3f9SebLrf	wMa326qeO3vvGGQgCH+qNno2m/uXwoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id us-mta-136-bnNgSvMENq-1sHr0yK5GEA-1; Mon, 13 Jan 2020 12:24:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5049D477	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:24:30 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 292245C1BB	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:24:30 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
To: cygwin-patches@cygwin.com
References: <20191229175637.1050-1-kbrown@cornell.edu> <20200113152809.GE5858@calimero.vinschen.de> <9f83d272-2dad-f652-d0c8-f3eb3b425ac2@cornell.edu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8361114f-0ca9-fe51-1c4c-382192582ded@redhat.com>
Date: Mon, 13 Jan 2020 17:24:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <9f83d272-2dad-f652-d0c8-f3eb3b425ac2@cornell.edu>
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00028.txt

On 1/13/20 10:53 AM, Ken Brown wrote:
> On 1/13/2020 10:28 AM, Corinna Vinschen wrote:
>> Hi Ken,
>>
>> On Dec 29 17:56, Ken Brown wrote:
>>> Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
>>> Following Linux, the first patch in this series allows the call to
>>> succeed if O_PATH is also specified.
>>>

>>
>>    O_PATH (since Linux 2.6.39)
>>     Obtain a file descriptor that can be used for two  purposes:  to
>>     indicate a location in the filesystem tree and to perform opera=E2=
=80=90
>>     tions that act purely at the file descriptor  level.   The  file
>>     itself  is not opened, and other file operations (e.g., read(2),
>>     write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2), mmap(2))
>>                          ^^^^^^^^^
>>     fail with the error EBADF.
>>     ^^^^^^^^^           ^^^^^
>>

On BSD systems, you are able to run lchmod to change permissions on a=20
symlink (with effect on who is able to follow that symlink during=20
pathname resolution); Linux does not support that, and POSIX does not=20
mandate support for that, so fchmodat() is allowed to fail on symlinks=20
even while fchownat() is required to work on symlinks.

>> That'd from the current F31 man pages.
>>
>>> Am I missing something?
>>
>> Good question.  Let me ask in return, did *I* now miss something?
>=20
> I don't think so.  I think we agree, although maybe I didn't express myse=
lf
> clearly enough for that to be obvious.  What confused me was the following
> paragraph further down in the open(2) man page (still discussing O_PATH):
>=20
>     If pathname is a symbolic link and the O_NOFOLLOW flag is also
>     specified, then the call returns a file descriptor referring
>     to the symbolic link.  This file descriptor can be used as the
>     dirfd argument in calls to fchownat(2), fstatat(2), linkat(2),
>                                ^^^^^^^^^^^
>     and readlinkat(2) with an empty pathname to have the calls
>     operate on the symbolic link.
>=20
> I don't know why they include fchownat here, since the resulting call wou=
ld fail
> with EBADF.  So I didn't implement that in my patch series.

I'm not sure if the question here is about fchownat() (where you CAN=20
change owner of a symlink on Linux, same as with lchown()) or about=20
fchmodat() (where you would attempt to change permissions of a symlink,=20
as on BSD, but where Linux lacks lchmod()).

Another wrinkle is that for the longest time, the Linux kernel did not=20
make it possible to correctly implement fchmodat(AT_SYMLINK_NOFOLLOW);=20
it is only with the recent introduction of the fchmodat2() syscall that=20
this has become possible (https://patchwork.kernel.org/patch/9596301/)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
