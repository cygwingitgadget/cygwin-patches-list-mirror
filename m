Return-Path: <cygwin-patches-return-3873-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23530 invoked by alias); 21 May 2003 17:25:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23511 invoked from network); 21 May 2003 17:25:04 -0000
Date: Wed, 21 May 2003 17:25:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for line draw characters problem & screen scrolling
Message-ID: <20030521172450.GB5744@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030521162232.GC3096@redhat.com> <Pine.GSO.4.44.0305211259290.26639-100000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0305211259290.26639-100000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00100.txt.bz2

On Wed, May 21, 2003 at 01:06:36PM -0400, Igor Pechtchanski wrote:
>On Wed, 21 May 2003, Christopher Faylor wrote:
>> On Wed, May 21, 2003 at 05:32:33PM +0200, Micha Nelissen wrote:
>> >Several problems encountered and tried to fix:
>> >* fhandler_console.cc (write_normal): end of buffer check enables cursor to be
>> >out of range; it better emulates *nix terminal behaviour; ie. it is now
>> >possible to write a single character at right bottom of console buffer without
>> >the console scrolling the buffer.
>>
>> How is this similar to UNIX?  If I do a:
>>
>> sleep 5; echo hello
>>
>> and then scroll my xterm up, xterm scrolls down when hello is printed.  It
>> sounds like your patch would not cause this to happen.
>
>This behavior is controlled, at least in an xterm, by the "Scroll to
>Bottom on Tty Output" resource.  In the Windows console, no such control
>is available, and it does scroll to bottom on output (just verified that).
>I think that's what Micha is trying to fix...  Please correct me if I'm
>wrong.
>
>Micha, if the above is correct, you'll probably want to introduce some
>sort of control that will let users switch back and forth, according to
>their preferences.

Yep.  This is similar to the other "just jump to first line of scroll region"
change.  You can't change the default behavior like this without providing
a method for controlling it.  Maybe xterm has some sort of escape sequence
for controlling this behavior which could be emulated in cygwin.

FWIW, I *like* the scroll to bottom behavior.

cgf
