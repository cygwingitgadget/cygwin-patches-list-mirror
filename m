Return-Path: <cygwin-patches-return-3558-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13720 invoked by alias); 13 Feb 2003 20:39:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13711 invoked from network); 13 Feb 2003 20:39:24 -0000
Message-ID: <021f01c2d39f$fcd78a00$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: <cygwin-patches@cygwin.com>
References: <20030213012822.A20310-100000@logout.sh.cvut.cz> <20030213203228.GF32279@redhat.com>
Subject: Re: Produce beeps using soundcard
Date: Thu, 13 Feb 2003 20:39:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00207.txt.bz2

Christopher Faylor wrote:
> On Thu, Feb 13, 2003 at 01:34:28AM +0100, Vaclav Haisman wrote:
>>
>> Hi,
>> this small patch adds an ability to produce beeps (\a) using
>> soundcard by MessageBeep() call. It can be enabled by new CYGWIN
>> option winbeep.
>>
>> Vaclav Haisman
>>
>> 2003-02-13  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
>> * environ.cc (windows_beep): New variable declaration.
>> (parse_thing): New CYGWIN option.
>> * fhandler_console.cc (windows_beep): New variable definition.
>> (fhandler_console::write_normal):  Handle the new option.
>> * Makefile.in (DLL_IMPORTS): Add libuser32.a for MessageBeep.
>
> I'm sorry but I really don't want to add too many options to the
> CYGWIN environment variable.  I don't think this really justifies an
> option.

Does that mean it will replace the current beep, or is it a rejection of the
patch? I would really like this - Beep() can be quite painful if you're
wearing headphones!. MessageBeep would be controllable via the volume
settings, but Beep is just a maximum volume blast!

Does it really *matter* for there to be lots of options in CYGWIN? I can't
see any disadvantage at all.


Max.
