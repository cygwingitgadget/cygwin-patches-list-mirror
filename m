Return-Path: <cygwin-patches-return-3575-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1051 invoked by alias); 17 Feb 2003 18:03:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1039 invoked from network); 17 Feb 2003 18:03:09 -0000
Message-ID: <00cf01c2d6ae$d2b906b0$78d96f83@pomello>
From: "Max Bowsher" <maxb@ukf.net>
To: "Vaclav Haisman" <V.Haisman@sh.cvut.cz>
Cc: <cygwin-patches@cygwin.com>
References: <20030217185236.X96740-100000@logout.sh.cvut.cz>
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Date: Mon, 17 Feb 2003 18:03:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2003-q1/txt/msg00224.txt.bz2

Vaclav Haisman wrote:
>> Is it wise to set *all* new files to sparse? Surely if this was
>> actually advantageous, Windows would do it anyway? From MSDN: "Note
>> It is up to the application to maintain sparseness by writing zeros
>> with FSCTL_SET_ZERO_DATA." I.e., this will gain nothing unless the
>> application knows about sparse-ness, in which case, it should
>> explicitly specify that the file should be sparse. So, all this
>> patch will do is to force Windows to examine more metadata for every
>> file read. This seems *extremely undesirable*.
>>
>> Max.
>
> As I have written in my previous emails in FreeBSD and SunOS all
> files are sparse if underlying file system supports it. I doubt
> Windows is significantly slower/faster in inspecting file system
> metadata than either of these OSes,

That's nice. Did you read the bit above where I quoted MSDN? Merely setting
the file as sparse will NOT SAVE SPACE on Windows. So, no space gain, and a
performance penalty of untested magnitude. I see only disadvantages.


Max.
