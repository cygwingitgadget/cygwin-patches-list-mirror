Return-Path: <cygwin-patches-return-3962-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1654 invoked by alias); 14 Jun 2003 12:32:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1634 invoked from network); 14 Jun 2003 12:32:35 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: <cygwin-patches@cygwin.com>
References: <BAY1-DAV408dRYtEcNi00028051@hotmail.com> <20030524180106.GC5604@redhat.com>
Subject: Re: End of buffer suppress scroll
Date: Sat, 14 Jun 2003 12:32:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV42n8eeGbdBm0001926c@hotmail.com>
X-OriginalArrivalTime: 14 Jun 2003 12:32:34.0312 (UTC) FILETIME=[07FB7880:01C33271]
X-SW-Source: 2003-q2/txt/msg00189.txt.bz2

Hi,

>> This scroll is not with scrollbar, but when adding a line. When a
>> character is written in right bottom cell, all of buffer is
>> scrolled. With this patch, the cursor can be 'out of range' while
...
>
> You explained this but I still think there is an escape sequence
> which controls what happens when a character shows up in the lower
> right corner.  I thought there was a termcap/terminfo setting for
> this, too.

There indeed is a termcap entry. But it has no effect in screen. This is the
same as the termcap entry on EOL wrap, you can disable that too in termcap,
but almost no program works anymore then. It's just 'the default' I think to
have EOL wrap, and no wrap at last character of buffer.

Micha.
