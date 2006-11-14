Return-Path: <cygwin-patches-return-5996-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13896 invoked by alias); 14 Nov 2006 10:54:17 -0000
Received: (qmail 13882 invoked by uid 22791); 14 Nov 2006 10:54:15 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 14 Nov 2006 10:54:06 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6C058544001; Tue, 14 Nov 2006 11:54:03 +0100 (CET)
Date: Tue, 14 Nov 2006 10:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to mapping up to 128 SCSI Disk Devices
Message-ID: <20061114105403.GJ11304@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E05F1FD208D5AA45B78B3983479ECF08E436C5@saturn.p3corpnet.pivot3.com> <20061114100258.GA31134@calimero.vinschen.de> <455999A8.915AABDC@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455999A8.915AABDC@dessent.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00014.txt.bz2

On Nov 14 02:25, Brian Dessent wrote:
> Corinna Vinschen wrote:
> 
> > I must admit that I don't quite understand why that happens, but
> > when I save your patch into a file, all '=' characters are converted
> > into a '=3D' sequence.  This is a bit weird given that you're using
> > us-ascii encoding.  Does anybody know why this happens?
> 
> That's because of:
> 
> > Content-Transfer-Encoding: quoted-printable
> 
> ..but your email client should undo the encoding if you tell it to save
> the message as a file.  Otherwise:
> 
> perl -MMIME::QuotedPrint -ne 'print decode_qp($_)' <in >out

Uh, thanks for the explanation.  I don't know why mutt doesn't convert
this...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
