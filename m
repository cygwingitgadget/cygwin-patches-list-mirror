Return-Path: <cygwin-patches-return-3908-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25037 invoked by alias); 26 May 2003 16:50:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25016 invoked from network); 26 May 2003 16:50:34 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: <cygwin-patches@cygwin.com>
References: <BAY1-DAV408dRYtEcNi00028051@hotmail.com> <20030524180106.GC5604@redhat.com> <BAY1-DAV71ljENsnqIF0001a86e@hotmail.com> <20030526155509.GB12907@redhat.com>
Subject: Re: End of buffer suppress scroll
Date: Mon, 26 May 2003 16:50:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV31GLjtgceXE0002c4e1@hotmail.com>
X-OriginalArrivalTime: 26 May 2003 16:50:30.0211 (UTC) FILETIME=[EA7D0130:01C323A6]
X-SW-Source: 2003-q2/txt/msg00135.txt.bz2

Christopher Faylor wrote:
> On Mon, May 26, 2003 at 01:08:03PM +0200, Micha Nelissen wrote:
>> Christopher Faylor wrote:
>>> On Sat, May 24, 2003 at 03:41:53PM +0200, Micha Nelissen wrote:
>>> You explained this but I still think there is an escape sequence
>>> which controls what happens when a character shows up in the lower
>>> right corner.  I thought there was a termcap/terminfo setting for
>>> this, too.
>>
>> There is not. Windows always wraps after the last character to the
>> next line, except if you turn this off with a call to SetConsoleMode
>> and disable the WRAP_AT_EOL flag. Nowhere in the code is such a
>> call. The only possible conclusion is that it will always wrap.
>
> I am talking about a *standard* vtxx escape sequence.

Ah, but not implemented yet? If you mean that, I am back on track. So, how
to find out? I only found in termcap manual the 'auto-margin' capability
which has to do with it, but too many programs don't work anymore when it's
disabled. It disables all wrapping at end of line.

Regards,

Micha.
