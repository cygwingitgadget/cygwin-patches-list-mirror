Return-Path: <cygwin-patches-return-4853-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26056 invoked by alias); 15 Jul 2004 20:21:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26047 invoked from network); 15 Jul 2004 20:21:53 -0000
Date: Thu, 15 Jul 2004 20:21:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] Reference counting on Audio objects for /dev/dsp
Message-ID: <20040715202128.GA12288@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.58.0407150928040.29800@slinky.cs.nyu.edu> <20040715183335.GB12149@trixie.casa.cgf.cx> <Pine.GSO.4.58.0407151449040.24064@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0407151449040.24064@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00005.txt.bz2

On Thu, Jul 15, 2004 at 02:57:17PM -0400, Igor Pechtchanski wrote:
>> 2) The other problem is that I find it sort of odd to see the dec()
>> method performing a deletion.  Couldn't this be handled where, IMO,
>> it should logically be handled, in the close function, e.g.,
>>
>>   if (!audio_out_->dec ())
>>     delete audio_out_;
>> ?
>
>Umm, that's actually a rather standard construct in reference counting
>(called "object suicide" -- you should get some references if you Google
>for "object suicide reference counting").

Yes, I thought that would be your answer, however, I don't like the idea
of having a method called "inc" which just increments a count and a method
called "dec" which decrements a count and, oh, hey, it might delete the
object, too.

It seems more straightforward to delete audio_out_ in the place where
you'd expect it to be deleted rather than having a o a "dec" call which,
if you check, you'll notice that it deletes the buffer.

Or, as a compromise, don't call it 'dec'.  Call it something which
illustrates what it is doing.

cgf
