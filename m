Return-Path: <cygwin-patches-return-3447-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26317 invoked by alias); 21 Jan 2003 21:38:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26308 invoked from network); 21 Jan 2003 21:38:55 -0000
Date: Tue, 21 Jan 2003 21:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: nanosleep() patch
Message-ID: <20030121214016.GA19951@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030117192853.GA1164@tishler.net> <20030121155842.GS29236@cygbert.vinschen.de> <20030121160201.GA13579@redhat.com> <20030121161706.GU29236@cygbert.vinschen.de> <20030121180536.GC628@tishler.net> <20030121180525.GB15711@redhat.com> <20030121211649.GA2060@tishler.net> <20030121213341.GA952@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121213341.GA952@tishler.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00096.txt.bz2

On Tue, Jan 21, 2003 at 04:33:41PM -0500, Jason Tishler wrote:
>On Tue, Jan 21, 2003 at 04:16:49PM -0500, Jason Tishler wrote:
>> On Tue, Jan 21, 2003 at 01:05:25PM -0500, Christopher Faylor wrote:
>> > I think usleep's implementation was incorrect, actually.
>> 
>> See attached for my next version which addresses the above too.
>
>> 2003-01-21  Jason Tishler  <jason@tishler.net>
>> 
>>   * cygwin.din: Export nanosleep().
>>   * signal.cc (nanosleep): New function.
>>   (sleep): Move old functionality to nanosleep().  Call nanosleep().
>>   (usleep): Remove old functionality.  Call nanosleep().
>>   * include/cygwin/version.h: Bump DLL minor number.
>                                     ^^^
>                                     ***
>
>Oops, typo.

Too late.  Patch rejected.  :-)

I asked Corinna to look at this.  If she agrees, then it will go
into 1.3.20.

cgf
