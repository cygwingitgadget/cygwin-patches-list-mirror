Return-Path: <cygwin-patches-return-3872-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16579 invoked by alias); 21 May 2003 17:22:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16546 invoked from network); 21 May 2003 17:22:33 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: <cygwin-patches@cygwin.com>
References: <Pine.GSO.4.44.0305211259290.26639-100000@slinky.cs.nyu.edu>
Subject: Re: Patch for line draw characters problem & screen scrolling
Date: Wed, 21 May 2003 17:22:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV30uFjc9QhVb00020b4b@hotmail.com>
X-OriginalArrivalTime: 21 May 2003 17:22:32.0908 (UTC) FILETIME=[907088C0:01C31FBD]
X-SW-Source: 2003-q2/txt/msg00099.txt.bz2

Igor Pechtchanski wrote:
> On Wed, 21 May 2003, Christopher Faylor wrote:
>
>> On Wed, May 21, 2003 at 05:32:33PM +0200, Micha Nelissen wrote:
>>> * fhandler_console.cc (write_normal): end of buffer check enables
>>> cursor to be out of range; it better emulates *nix terminal
>>> behaviour; ie. it is now possible to write a single character at
>>> right bottom of console buffer without the console scrolling the
>>> buffer.
>>

> This behavior is controlled, at least in an xterm, by the "Scroll to
> Bottom on Tty Output" resource.  In the Windows console, no such

We're getting all the scrolling confused. My explanation was not clear
enough.

Let me define terms as I see them:
- buffer: all data which the user is able to see with the use of the
scrollbar.
- window: data which the use is able to see without the use of the
scrollbar.

They are 2 types of scrolling:
1) using the scrollbar to change the current window position in the buffer
2) when you write at the last line of the buffer and the cursor 'wraps',
then we need a new line to write next output.

I am referring to the second type of scrolling. When a character is written
in the very right bottom 'cell', then windows *immediately* 'scrolls' (2) to
the next line. I don't want that. *nix behaviour (as I saw it) only scrolls
if *another* character is written. So temporarily the cursor is
'out-of-range' ie. outside the buffer. If another character is written
*without* moving the cursor, then *and only then* all output is moved up.

BTW: you will receive a new set of patches, replacing this one large patch,
later. I will hopefully clear up the other issues when I send those.

Hope this clears it up,

Micha.
