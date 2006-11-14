Return-Path: <cygwin-patches-return-5995-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32064 invoked by alias); 14 Nov 2006 10:25:53 -0000
Received: (qmail 32048 invoked by uid 22791); 14 Nov 2006 10:25:52 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 14 Nov 2006 10:25:46 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.61) 	(envelope-from <brian@dessent.net>) 	id 1GjvU8-0007T6-VS 	for cygwin-patches@cygwin.com; Tue, 14 Nov 2006 10:25:45 +0000
Message-ID: <455999A8.915AABDC@dessent.net>
Date: Tue, 14 Nov 2006 10:25:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to mapping up to 128 SCSI Disk Devices
References: <E05F1FD208D5AA45B78B3983479ECF08E436C5@saturn.p3corpnet.pivot3.com> <20061114100258.GA31134@calimero.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00013.txt.bz2

Corinna Vinschen wrote:

> I must admit that I don't quite understand why that happens, but
> when I save your patch into a file, all '=' characters are converted
> into a '=3D' sequence.  This is a bit weird given that you're using
> us-ascii encoding.  Does anybody know why this happens?

That's because of:

> Content-Transfer-Encoding: quoted-printable

..but your email client should undo the encoding if you tell it to save
the message as a file.  Otherwise:

perl -MMIME::QuotedPrint -ne 'print decode_qp($_)' <in >out

> The patch is also broken due to unexpected line breaks, see above.

That's always a pain... attachments are really the way to go.

Brian
