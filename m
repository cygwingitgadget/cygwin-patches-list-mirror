Return-Path: <cygwin-patches-return-4295-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27818 invoked by alias); 14 Oct 2003 16:45:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27794 invoked from network); 14 Oct 2003 16:45:11 -0000
Date: Tue, 14 Oct 2003 16:45:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Ncurses frame drawing
Message-ID: <20031014164506.GC16944@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031013170602.GN14344@cygbert.vinschen.de> <3F8BDE21.2090206@student.tue.nl> <20031014142447.GA16944@redhat.com> <20031014145507.GC14344@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014145507.GC14344@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00014.txt.bz2

On Tue, Oct 14, 2003 at 04:55:07PM +0200, Corinna Vinschen wrote:
>On Tue, Oct 14, 2003 at 10:24:47AM -0400, Christopher Faylor wrote:
>> On Tue, Oct 14, 2003 at 01:29:37PM +0200, Micha Nelissen wrote:
>> >Corinna Vinschen wrote:
>> >>This patch is a nice idea but it's not quite correct.  You can't
>> >>rely on "current_codepage" being ansi_cp.  Since the user can set
>> >>it to oem_cp in the CYGWIN environment variable, you have to memorize
>> >>the old value on \E[11m and to restore to the old value on \E[10m.
>> >
>> >Ok, that's true.  Attached is a patch with the suggested changes.
>> 
>> I guess this is ok although it's not thread safe.  It looks like
>> fhandler_console isn't thread safe in general, though.
>> 
>> Corinna do you have time to check this in?
>
>Erm... I was still mulling over this code since I thought there's
>something wrong.  It took some time until it occured to me that this
>implementation overrides the original value of current_codepage, if
>the application accidentally happens to send \E[11m twice.  That
>shouldn't be possible.

Good point.

Ok, I'll just shut up and let you handle this.  :-)

cgf
