Return-Path: <cygwin-patches-return-2717-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1378 invoked by alias); 25 Jul 2002 16:04:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1363 invoked from network); 25 Jul 2002 16:04:50 -0000
Message-ID: <3D402191.9090706@netscape.net>
Date: Thu, 25 Jul 2002 09:04:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: qt patch for winnt.h
References: <3D401950.1070803@netscape.net> <20020725154806.GE10541@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00165.txt.bz2

Christopher Faylor wrote:

>On Thu, Jul 25, 2002 at 11:29:20AM -0400, Nicholas Wourms wrote:
>
>>2002-07-25  Nicholas Wourms  <nwourms@netscape.net>
>>
>>   * winnt.h (HANDLE): Add guard for compiling qt.
>>
>
>I really think this sets an incredibly bad precedent.  Littering the
>system headers with project specific defines is really distasteful
>to me.
>
It's not like this has just cropped up today.  As I said, Ralf and 
others, including Chris January have spent a great deal of time on this, 
but in the end this was the solution.  I'm not trying to set a 
precedent, b/c this wouldn't be the first ifdef of its kind.  I believe 
there is an ifdef in there to "fix" an issue w/ gdb or something.  I'll 
have to go back and look, but I know its in there.

>
>This is Danny's call, though.
>
Ok.

Cheers,
Nicholas
