Return-Path: <cygwin-patches-return-9925-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73329 invoked by alias); 13 Jan 2020 18:37:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73320 invoked by uid 89); 13 Jan 2020 18:37:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=affects, H*MI:sk:1552bbe, HX-Languages-Length:1817, H*f:sk:1552bbe
X-HELO: us-smtp-1.mimecast.com
Received: from us-smtp-delivery-1.mimecast.com (HELO us-smtp-1.mimecast.com) (207.211.31.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 18:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;	s=mimecast20190719; t=1578940636;	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:	 to:to:cc:mime-version:mime-version:content-type:content-type:	 content-transfer-encoding:content-transfer-encoding:	 in-reply-to:in-reply-to:references:references;	bh=qK+tZyfv4dZfPkt7/2LC17UFTUgeRlCti40/0aAj0xM=;	b=cn6vMN6DaDnu8NgWpt+f8XN8rgtqb8r4/XvxQD9fJPiI3BWC7KWRJNw42zLbRD+Mg6E7zA	c8QUWgSO96T/FnYMSFoocw6vtPSkZM3qVbF+KCOM8M0drLASCrnogLAfJSOyayv0ydEL0c	WblviYrklpSVB5qJMhOlXkEPQmS3oQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id us-mta-231-0g_v1BZjNfuKAdzTTQ06Gw-1; Mon, 13 Jan 2020 13:37:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A876818B5FBA	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 18:37:13 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 803E05DA70	for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 18:37:13 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
To: cygwin-patches@cygwin.com
References: <20191229175637.1050-1-kbrown@cornell.edu> <20200113152809.GE5858@calimero.vinschen.de> <9f83d272-2dad-f652-d0c8-f3eb3b425ac2@cornell.edu> <8361114f-0ca9-fe51-1c4c-382192582ded@redhat.com> <1552bbe6-986a-0006-7afd-028eb0655f15@cornell.edu>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2680c6c-a0d3-6081-45e9-806ddd3c7f90@redhat.com>
Date: Mon, 13 Jan 2020 18:37:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1552bbe6-986a-0006-7afd-028eb0655f15@cornell.edu>
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00031.txt

On 1/13/20 11:44 AM, Ken Brown wrote:

>>> I don't think so.=C2=A0 I think we agree, although maybe I didn't expre=
ss myself
>>> clearly enough for that to be obvious.=C2=A0 What confused me was the f=
ollowing
>>> paragraph further down in the open(2) man page (still discussing O_PATH=
):
>>>
>>>  =C2=A0=C2=A0=C2=A0 If pathname is a symbolic link and the O_NOFOLLOW f=
lag is also
>>>  =C2=A0=C2=A0=C2=A0 specified, then the call returns a file descriptor =
referring
>>>  =C2=A0=C2=A0=C2=A0 to the symbolic link.=C2=A0 This file descriptor ca=
n be used as the
>>>  =C2=A0=C2=A0=C2=A0 dirfd argument in calls to fchownat(2), fstatat(2),=
 linkat(2),
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^
>>>  =C2=A0=C2=A0=C2=A0 and readlinkat(2) with an empty pathname to have th=
e calls
>>>  =C2=A0=C2=A0=C2=A0 operate on the symbolic link.
>>>
>>> I don't know why they include fchownat here, since the resulting call w=
ould fail
>>> with EBADF.=C2=A0 So I didn't implement that in my patch series.
>>
>> I'm not sure if the question here is about fchownat() (where you CAN cha=
nge
>> owner of a symlink on Linux, same as with lchown())
>=20
> Yes, the question is about fchownat.  Are you saying you can change the o=
wner
> even if the symlink was opened with O_PATH?

Without actually writing a test program on Linux, I'm not sure.=20
Logically, I'd expect that changing the owner of a symlink is a metadata=20
operation that affects the containing directory rather than the contents=20
of the file, but that access to the directory entry is what O_PATH is=20
supposed to provide, and therefore it seems like fchownat() on an empty=20
filename should work the same as lchownat().  But if it fails in Linux,=20
then we don't have to do any better.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
