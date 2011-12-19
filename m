Return-Path: <cygwin-patches-return-7566-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17578 invoked by alias); 19 Dec 2011 16:00:35 -0000
Received: (qmail 17040 invoked by uid 22791); 19 Dec 2011 16:00:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 19 Dec 2011 15:59:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 37A8E2C01DE; Mon, 19 Dec 2011 16:59:48 +0100 (CET)
Date: Mon, 19 Dec 2011 16:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add support for creating native windows symlinks
Message-ID: <20111219155948.GA7148@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com> <20111205101715.GA13067@calimero.vinschen.de> <CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com> <CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00056.txt.bz2

On Dec 18 12:16, Russell Davis wrote:
> Can someone respond to this? If there's a problem with my suggested
> approach I'd like to know what it is. Let me know if clarification is
> needed. Thanks...

I don't think it's the right approach to let Cygwin create symlinks
which are only partially usable in the POSIX environment, even if only
after explicitely enabling them(*).  I agree with Andy and Daniel that
using a special tool like Daniel's winln for this purpose is the way to
go.


Corinna

(*) Actually I wished desparately I hadn't included the "winsymlink"
    setting.  It seemed such a good idea at the time, but the extra
    code necessary to support .lnk symlinks transparently is a big
    mess.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
