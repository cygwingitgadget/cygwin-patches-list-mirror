Return-Path: <cygwin-patches-return-2875-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29614 invoked by alias); 28 Aug 2002 11:07:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29600 invoked from network); 28 Aug 2002 11:07:54 -0000
Message-ID: <3D6CAECC.8070403@netscape.net>
Date: Wed, 28 Aug 2002 04:07:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]: export getc_unlocked, getchar_unlocked, putc_unlocked,
 putchar_unlocked
References: <3D6BBC26.2060408@netscape.net> <20020828125231.C10870@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00323.txt.bz2

Corinna Vinschen wrote:

>On Tue, Aug 27, 2002 at 01:51:34PM -0400, Nicholas Wourms wrote:
>
>>    * cygwin.din: Export getc_unlocked, getchar_unlocked,
>>    putc_unlocked, putchar_unlocked functions.
>>    * include/cygwin/version.h: Bump api minor.
>>
>
>Applied.  Thanks, but you forgot the ChangeLog for the doc dir.
>
>Tsk, tsk, tsk, ;-)
>
Corinna,

Chris had told me not to do changelogs for documentation.  If you want 
them, then in future changes I will do so.

Cheers,
Nicholas
