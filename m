Return-Path: <cygwin-patches-return-8319-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102086 invoked by alias); 14 Feb 2016 18:03:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 101914 invoked by uid 89); 14 Feb 2016 18:03:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.8 required=5.0 tests=BAYES_50,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=ham version=3.3.2 spammy=hood, 201412, Console, 14022016
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Sun, 14 Feb 2016 18:02:59 +0000
Received: from [198.206.215.16] (h16.glup.org [198.206.215.16])	by glup.org (Postfix) with ESMTPSA id 3D767854C4;	Sun, 14 Feb 2016 13:02:57 -0500 (EST)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Content-Type: text/plain;	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: Cygwin select() issues and improvements
From: John Hood <cgull@glup.org>
In-Reply-To: <56C07316.8070001@towo.net>
Date: Sun, 14 Feb 2016 18:03:00 -0000
Cc: cygwin-patches@cygwin.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2101D793-359B-406A-83AA-AA33A28D9F51@glup.org>
References: <56C03624.1030703@glup.org> <56C07316.8070001@towo.net>
To: Thomas Wolff <towo@towo.net>
X-SW-Source: 2016-q1/txt/msg00025.txt.bz2

I hadn't checked UTF-8 input before, but yes, it's the same problem.  Your =
test program and mine are very similar.

Regards,

  --jh

> On Feb 14, 2016, at 7:29 AM, Thomas Wolff <towo@towo.net> wrote:
>=20
>> Am 14.02.2016 um 09:09 schrieb john hood:
>> [I Originally sent this last week, but it bounced.]
>>=20
>> Various issues with Cygwin's select() annoyed me, and I've spent some
>> time gnawing on them.
>>=20
>> * With 1-byte reads, select() on Windows Console input would forget
>> about unread input data stored in the fhandler's readahead buffer.
>> Hitting F1 would send only the first ESC character, until you released
>> the key and another Windows event was generated.  (one-line fix, though
>> I'm not sure it's appropriate/correct)
>>=20
>> * ...
> If that also solves the UTF-8 byte splitting problem https://cygwin.com/m=
l/cygwin/2014-12/msg00118.html that would be great, see test program attach=
ed there.
> Thomas
