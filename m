From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fileutils-4.0-3
Date: Thu, 14 Jun 2001 10:49:00 -0000
Message-id: <20010614134928.E16245@redhat.com>
References: <Pine.GSO.4.21.0106122003330.3791-100000@devmail.dev.tivoli.com> <20010613105845.D1144@cygbert.vinschen.de> <12812308989.20010613152159@logos-m.ru> <20010613153123.K1144@cygbert.vinschen.de> <4385449600.20010614114100@logos-m.ru> <20010614170757.A1144@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00304.html

On Thu, Jun 14, 2001 at 05:07:57PM +0200, Corinna Vinschen wrote:
>On Thu, Jun 14, 2001 at 11:41:00AM +0400, egor duda wrote:
>> patch attached. i was a bit confused to discover, however, that
>> stat_worker works somehow without it. AFAICS from stat_worker code,
>> if it cannot open file, it still tries to get as much information as
>> it can, file size and times included. so, du works for me either with
>> or without this patch.
>
>The patch is fine, IMO.

It looks fine to me, too.  Please check it in.

I wish I understood why this failed in some situations and not other, though.

cgf
